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

# Create a temporary directory for extra-files staging
TMP_DIR=$(mktemp -d)
cleanup() {
    rm -rf "$TMP_DIR"
}
trap cleanup EXIT INT TERM

# Mirror the target path structure inside the staging area
DEST_DIR="$TMP_DIR/persistent/etc/sops"
mkdir -p "$DEST_DIR"

# Copy SOPS secrets while preserving permissions
cp -a "$SOPS_SRC/." "$DEST_DIR/"

# Execute nixos-anywhere with the target and extra files
nixos-anywhere \
    --disk-encryption-keys /tmp/secret.boot.key /tmp/secret.boot.key \
    --disk-encryption-keys /tmp/secret.root.key /tmp/secret.root.key \
    --extra-files "$TMP_DIR" \
    "$@" \
    "$TARGET"
