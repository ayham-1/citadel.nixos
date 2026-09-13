#!/bin/sh
set -eu

# Usage check
if [ "$#" -lt 1 ]; then
    printf 'Usage: %s [user@]host [nixos-anywhere options...]\n' "$0" >&2
    printf 'Example: %s root@192.168.1.50 --flake .#my-hostname\n' "$0" >&2
    exit 1
fi

TARGET="$1"
shift

SOPS_SRC="/persistent/etc/sops"

# Verify source SOPS directory exists
if [ ! -d "$SOPS_SRC" ]; then
    printf 'Error: Local SOPS directory %s does not exist.\n' "$SOPS_SRC" >&2
    exit 1
fi

if [ -z "${BW_SESSION:-}" ]; then
    printf 'Error: BW_SESSION is not set. Run "export BW_SESSION=$(bw unlock --raw)" first.\n' >&2
    exit 1
fi

# Create a temporary directory for extra-files staging
TMP_DIR=$(mktemp -d)
cleanup() {
    rm -rf "$TMP_DIR"
}
trap cleanup EXIT INT TERM


# Mirror the target path structure inside the staging area
mkdir -p "$TMP_DIR/persistent/etc/sops"
mkdir -p "$TMP_DIR/tmp/keys"

# Copy SOPS secrets while preserving permissions
cp -a "$SOPS_SRC/." "$DEST_DIR/"

# Retrieve passwords from bitwarden
printf 'Fetching LUKS root password from Bitwarden...\n'
bw get password "LUKS_ROOT_ITEM_ID" | tr -d '\n' > "$TMP_DIR/tmp/secret.root.key"
printf 'Fetching LUKS boot password from Bitwarden...\n'
bw get password "LUKS_BOOT_ITEM_ID" | tr -d '\n' > "$TMP_DIR/tmp/secret.boot.key"
chmod 600 "$TMP_DIR/tmp/"*.key

# Execute nixos-anywhere with the target and extra files
nixos-anywhere \
    --disk-encryption-keys /tmp/secret.boot.key "$TMP_DIR/tmp/secret.boot.key" \
    --disk-encryption-keys /tmp/secret.root.key "$TMP_DIR/tmp/secret.root.key" \
    --extra-files "$TMP_DIR" \
    "$@" \
    "$TARGET"
