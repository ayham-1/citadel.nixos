{ pkgs, lib, ... }: {
  vim = {
    theme.enable = true;
    theme.style = "dark";

    statusline.lualine.enable = true;
    telescope.enable = true;

    treesitter.enable = true;
    autocomplete.nvim-cmp.enable = true;

    lsp = {
      enable = true;
      formatOnSave = true;
      lspconfig.enable = true;
      lspkind.enable = true;
      lspsaga.enable = true;
    };

    mini = {
      animate.enable = true;
      indentscope.enable = true;
    };

    formatter = { conform-nvim.enable = true; };
    binds = { whichKey.enable = true; };

    options = {
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
    };

    languages = {
      enableTreesitter = true;

      nix.enable = true;
      rust.enable = true;
      clang.enable = true;
    };
  };
}
