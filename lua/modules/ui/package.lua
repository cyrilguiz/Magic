local package = require('core.pack').package
local conf = require('modules.ui.config')

package({ 'glepnir/dashboard-nvim', config = conf.dashboard })

package({
  'glepnir/spaceline.vim',
})

package({
  'cyrilguiz/base46.nvim',
  config = conf.base46,
})

package({
  'akinsho/nvim-bufferline.lua',
  config = conf.nvim_bufferline,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
})

package({
  'lukas-reineke/indent-blankline.nvim',
  event = 'BufRead',
  config = function()
    require('ibl').setup()
  end,
})

package({
  'nvim-neo-tree/neo-tree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  config = conf.neotree,
})

package({
  'm4xshen/autoclose.nvim',
  config = function()
    require('autoclose').setup({})
  end,
})

package({
  'folke/noice.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  config = conf.noice,
})
