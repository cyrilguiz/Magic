local config = {}

function config.theme()
  vim.cmd([[colorscheme nightowl]])
end

function config.dashboard()
  local db = require('dashboard')
  db.setup({
    theme = 'hyper',
    config = {
      week_header = {
        enable = true,
      },
      shortcut = {
        { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
        {
          desc = ' Files',
          group = 'Label',
          action = 'Telescope find_files',
          key = 'f',
        },
        {
          desc = ' Apps',
          group = 'DiagnosticHint',
          action = 'Telescope app',
          key = 'a',
        },
        {
          desc = ' dotfiles',
          group = 'Number',
          action = 'Telescope dotfiles',
          key = 'd',
        },
      },
    },
  })
end

function config.nvim_bufferline()
  require('bufferline').setup({
    options = {
      modified_icon = '✥',
      buffer_close_icon = '',
      always_show_bufferline = false,
    },
  })
end

function config.indent_blankline()
  require('ibl').setup()
end

function config.neotree()
  require('neo-tree').setup({
    close_if_last_window = true,
    icon = {
      folder_empty = '󰜌',
    },
    git_status = {
      symbols = {
        added = '✚',
        modified = '',
      },
    },
    file_size = {
      enabled = true,
      required_width = 25,
    },
    commands = {},
    window = {
      position = 'right',
      width = 35,
    },
  })
end

function config.lualine()
  local fn = vim.fn
  local cwd = function()
    local dir_name = '%#St_cwd# 󰉖 ' .. fn.fnamemodify(fn.getcwd(), ':t') .. ' '
    return (vim.o.columns > 85 and dir_name) or ''
  end

  require('lualine').setup({
    sections = {
      lualine_y = { cwd() },
    },
  })
end

function config.noice()
  vim.opt.termguicolors = true
  require('notify').setup({
    top_down = false,
    stages = 'fade',
    render = 'compact',
  })
  require('noice').setup()
end
return config
