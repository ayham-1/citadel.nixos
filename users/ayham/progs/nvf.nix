{
  pkgs,
  lib,
  ...
}: {
  vim = {
    theme.enable = true;
    theme.style = "dark";

    statusline.lualine.enable = true;
    telescope.enable = true;

    treesitter.enable = true;
    autocomplete.nvim-cmp.enable = true;
    #autocomplete.blink-cmp.enable = true;

    lsp = {
      enable = true;
      formatOnSave = true;
      lspconfig.enable = true;
      lspkind.enable = true;
      lspsaga.enable = true;
    };

    mini = {
      #animate.enable = true;
      indentscope.enable = true;
    };

    visuals = {
      fidget-nvim.enable = true;
      rainbow-delimiters.enable = true;
    };

    utility = {
      oil-nvim = {
        enable = true;
        gitStatus.enable = true;
      };
      outline = {
        aerial-nvim.enable = true;
      };
      sleuth.enable = true;
      smart-splits.enable = true;
      undotree.enable = true;
    };

    git.enable = true;

    formatter = {conform-nvim.enable = true;};
    binds = {whichKey.enable = true;};
    debugger.nvim-dap.enable = true;
    diagnostics.enable = true;
    dashboard.startify.enable = true;

    filetree.neo-tree.enable = true;

    comments.comment-nvim.enable = true;

    git = {
      git-conflict.enable = true;
    };

    options = {
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      autoindent = true;
    };

    languages = {
      enableTreesitter = true;

      nix.enable = true;
      nix.format.enable = true;
      rust.enable = true;
      zig.enable = true;
      clang.enable = true;
    };

    projects.project-nvim.enable = true;
  };
}
