local config = {}

function config.mason()
  local mason = require('mason')
  local mason_lspconfig = require('mason-lspconfig')

  mason.setup({
    ui = {
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
      },
    },
  })

  mason_lspconfig.setup({
    ensure_installed = {
      'tsserver',
      'html',
      'cssls',
      'tailwindcss',
      'lua_ls',
      'emmet_ls',
    },
    automatic_installation = true, -- not the same as ensure_installed
  })
end

function config.nvim_treesitter()
  vim.api.nvim_command('set foldmethod=expr')
  vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
  require('nvim-treesitter.configs').setup({
    ensure_installed = 'all',
    ignore_install = { 'phpdoc' },
    highlight = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
    },
  })
end

function config.guard()
  local ft = require('guard.filetype')

  ft('lua'):fmt('stylua')
  ft('zig'):fmt('zigfmt')
  vim.g.zig_fmt_autosave = 0

  local langs = {
    'json',
    'toml',
    'go',
    'typescript',
    'typescriptreact',
    'html',
    'css',
  }

  for _, lang in pairs(langs) do
    ft(lang):fmt('lsp')
  end

  require('guard').setup({
    fmt_on_save = true,
    lsp_as_default_formatter = false,
  })
end

return config
