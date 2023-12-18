local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here 
  -- with the ones you want to install
  ensure_installed = {
                    'tsserver', --foi
                    'rust_analyzer', --foi
                    'pyright', --foi
                    'clangd', --foi
                    'volar',
                    'html', --foi
                    'cssls', --foi
                    'marksman' --foi
                },
  handlers = {
    lsp_zero.default_setup,
  },
})
