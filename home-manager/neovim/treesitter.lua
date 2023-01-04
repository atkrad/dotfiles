
-- Treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {},
  sync_install = false,
  auto_install = false,

  playground = {
    enable = true,
  },
  highlight = { enable = true },
  indent = { enable = true },
}

