vim.g.vimtex_compiler_latexmk = {
    executable = 'latexmk',
    options = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '-pvc' },
}
vim.api.nvim_set_keymap('n', '<leader>ll', ':VimtexCompile<CR>', { noremap = true, silent = true })
