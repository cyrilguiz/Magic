local config = {}

-- config server in this function
function config.nvim_lsp()
  local lspconfig = require('lspconfig')
  local cmp_nvim_lsp = require('cmp_nvim_lsp')
  local keymap = vim.keymap -- for conciseness
  local opts = { noremap = true, silent = true }
  local on_attach = function(_, bufnr)
    opts.buffer = bufnr
    opts.desc = 'Show LSP references'
    keymap.set('n', 'gR', '<Cmd>Telescope lsp_references<Cr>', opts)
    opts.desc = 'Go to declaration'
    keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    opts.desc = 'Show LSP definitions'
    keymap.set('n', 'gd', '<Cmd>Lspsaga peek_definition<Cr>', opts)
    opts.desc = 'Show LSP implementations'
    keymap.set('n', 'gi', '<Cmd>Telescope lsp_implementations<Cr>', opts)
    opts.desc = 'Show LSP type definitions'
    keymap.set('n', 'gt', '<Cmd>Lspsaga peek_type_definiton<Cr>', opts)
    opts.desc = 'See available code actions'
    keymap.set({ 'n', 'v' }, '<Leader>ca', '<Cmd>Lspsaga code_action<Cr>', opts)
    opts.desc = 'Smart rename'
    keymap.set('n', '<Leader>rn', '<Cmd>Lspsaga rename<Cr>', opts)
    opts.desc = 'Show buffer diagnostics'
    keymap.set('n', '<Leader>D', '<Cmd>Lspsaga show_buf_diagnostics<Cr>', opts)
    opts.desc = 'Show line diagnostics'
    keymap.set('n', '<Leader>d', '<Cmd>Lspsaga show_line_diagnostics<Cr>', opts)
    opts.desc = 'Go to previous diagnostic'
    keymap.set('n', '[d', '<Cmd>Lspsaga diagnostic_jump_prev<Cr> ', opts)
    opts.desc = 'Go to next diagnostic'
    keymap.set('n', ']d', '<Cmd>Lspsaga diagnostic_jump_next<Cr>', opts)
    opts.desc = 'Show documentation for what is under cursor'
    keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<Cr>', opts)
    opts.dec = 'LSP outline'
    keymap.set('n', '<Leader>l', '<Cmd>Lspsaga outline<Cr>', opts)
    opts.desc = 'Restart LSP'
    keymap.set('n', '<Leader>rs', ':LspRestart<CR>', opts)
  end

  local capabilities = cmp_nvim_lsp.default_capabilities()

  local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
  end

  local servers = {
    'gopls',
    'zls',
    'tsserver',
    'taplo',
    'jsonls',
    'tailwindcss',
    'html',
  }

  for _, server in pairs(servers) do
    lspconfig[server].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end
  lspconfig['emmet_ls'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'svelte' },
  })

  lspconfig['lua_ls'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.stdpath('config') .. '/lua'] = true,
          },
        },
      },
    },
  })
end

function config.nvim_cmp()
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  local lspkind = require('lspkind')

  cmp.setup({
    completion = {
      completeopt = 'menu,menuone,preview,noselect',
    },
    snippet = { -- configure how nvim-cmp interacts with snippet engine
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
      ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(), -- show completion suggestions
      ['<C-e>'] = cmp.mapping.abort(), -- close completion window
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ['<Up>'] = cmp.mapping.abort(),
      ['<Down>'] = cmp.mapping.abort(),
    }),
    -- sources for autocompletion
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- snippets
      { name = 'buffer' }, -- text within current buffer
      { name = 'path' }, -- file system paths
    }),
    -- configure lspkind for vs-code like pictograms in completion menu
    formatting = {
      format = lspkind.cmp_format({
        maxwidth = 50,
        ellipsis_char = '...',
      }),
    },
  })
end

function config.lua_snip()
  local ls = require('luasnip')
  local types = require('luasnip.util.types')
  ls.config.set_config({
    history = true,
    enable_autosnippets = true,
    updateevents = 'TextChanged,TextChangedI',
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { '<- choiceNode', 'Comment' } },
        },
      },
    },
  })
  require('luasnip.loaders.from_lua').lazy_load({ paths = vim.fn.stdpath('config') .. '/snippets' })
  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip.loaders.from_vscode').lazy_load({
    paths = { './snippets/' },
  })
end

function config.lspsaga()
  require('lspsaga').setup({})
end
return config
