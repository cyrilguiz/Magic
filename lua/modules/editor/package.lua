local package = require('core.pack').package
local conf = require('modules.editor.config')

package({
  'nvim-treesitter/nvim-treesitter',
  event = 'BufRead',
  run = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = conf.nvim_treesitter,
})

package({
  'nvimdev/guard.nvim',
  dependencies = {
    'nvimdev/guard-collection',
  },
  config = conf.guard,
})

package({
  'numtoStr/Comment.nvim',
  config = function()
    require('Comment').setup({})
  end,
})

package({
  'williamboman/mason.nvim',
  dependencies = {
    { 'williamboman/mason-lspconfig.nvim' },
  },
  config = conf.mason,
})
