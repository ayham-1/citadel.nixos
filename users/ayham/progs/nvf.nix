{
  pkgs,
  lib,
  ...
}: {
  vim = {
    theme.enable = true;
    theme.style = "dark";

    spellcheck.enable = true;
    spellcheck.languages = ["en" "de"];

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

    notes = {
      neorg = {
        enable = true;
        treesitter.enable = true;
        setupOpts.load = {
          "core.defaults" = {};
          "core.concealer" = {};
          "core.dirman" = {
            config = {
              workspaces.notes = "/data/src/notes/";
              default_workspace = "notes";
              index = "index.norg";
            };
          };
        };
      };
    };

    projects.project-nvim.enable = true;

    extraPlugins = with pkgs.vimPlugins; {
      vimwiki = {
        package = vimwiki;
      };
    };

    luaConfigPost = ''
      -- Configure VimWiki settings using standard global variables
      vim.g.vimwiki_list = {
        {
          path = '/data/src/vimwiki/',
          syntax = 'markdown',
          ext = '.md',
        }
      }

      -- Prevent VimWiki from overriding all markdown files outside of your wiki directory
      vim.g.vimwiki_global_ext = 0
    '';
  };
}
