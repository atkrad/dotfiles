{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    package = pkgs.unstable.neovim-unwrapped;
    plugins = with pkgs.unstable.vimPlugins; [
      {
        plugin = dracula-nvim;
        type = "lua";
        config = ''
          require('dracula').setup {
            -- show the '~' characters after the end of buffers
            show_end_of_buffer = true,
          }
          require('dracula').load()
          vim.cmd.colorscheme("dracula")
        '';
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          require('nvim-treesitter.configs').setup {
            ensure_installed = {},
            sync_install = false,
            auto_install = false,

            highlight = { enable = true },
            indent = { enable = true },
          }
        '';
      }
      {
        plugin = nvim-treesitter-context;
        type = "lua";
        config = ''
          require('treesitter-context').setup {
            enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
            max_lines = 10, -- How many lines the window should span. Values <= 0 mean no limit.
            -- Separator between context and content. Should be a single character string, like '—'
            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
            separator = "—",
          }
        '';
      }
      {
        plugin = nvim_context_vt;
        type = "lua";
        config = ''
          require("nvim_context_vt").setup({
            disable_ft = { "markdown", "yaml" },
          })
        '';
      }
      {
        plugin = nvim-colorizer-lua;
        type = "lua";
        config = ''
          require('colorizer').setup()
        '';
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = ''
          require('gitsigns').setup {
            current_line_blame = true,
          }
        '';
      }
      {
        plugin = statuscol-nvim;
        type = "lua";
        config = ''
          require("statuscol").setup {
            relculright = true,
          }
        '';
      }
      {
        plugin = nvim-cursorline;
        type = "lua";
        config = ''
          require('nvim-cursorline').setup {
            cursorword = {
              enable = true,
              min_length = 3,
              hl = { underline = true },
            }
          }
        '';
      }
      {
        plugin = which-key-nvim;
        type = "lua";
        config = ''
          require("which-key").setup {
            win = {
              border = "single",
            },
          }
        '';
      }
    ];
    extraConfig = ''
      syntax on
      syntax enable

      set cursorline
      set number                        " Show line numbers
      set ruler                         " Show line and column number
      set termguicolors
    '';
    extraLuaConfig = ''
      vim.keymap.set("n", "<space><space>", function() require("which-key").show() end)
    '';
    extraPackages = with pkgs; [
      # For tree-sitter
      gcc
      lua
    ];
  };
}
