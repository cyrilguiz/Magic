local config = {}

function config.base46()
  require('base46').load_theme({
    base = 'base46',
    theme = 'nightowl',
    transparency = false,
  })
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
    commands = {},
    window = {
      position = 'right',
      width = 35,
    },
    filesystem = {
      filtered_items = {
        hide_gitignore = false,
        hide_dotfiles = false,
        hide_by_name = {
          '.git',
        },
        always_show = {
          '.gitignored',
        },
      },
    },
  })
end

function config.noice()
  vim.opt.termguicolors = true
  require('notify').setup({
    top_down = false,
    render = 'compact',
  })
  require('noice').setup({
    views = {
      cmdline_popup = {
        position = {
          row = 1,
          col = 75,
        },
        size = {
          width = 40,
          height = 1,
        },
      },
      popupmenu = {
        relative = 'editor',
        position = {
          row = 4,
          col = 75,
        },
        size = {
          width = 37,
          height = 10,
        },
        border = {
          style = 'rounded',
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
        },
      },
    },
  })
end

return config
