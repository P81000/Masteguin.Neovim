vim.g.vimtex_compiler_method = 'latexmk'

vim.g.vimtex_compiler_latexmk = {
    executable = 'latexmk',
    options = {'-pdf', '-interaction=nonstopmode', '-synctex=1'},
}

vim.g.vimtex_compiler_latexmk.engine = 'pdflatex'

vim.g.vimtex_view_method = 'general'

vim.g.vimtex_mainfile_auto = 1
vim.g.vimtex_mainfile_manual = 1

vim.keymap.set('n', '<leader>ll', ':VimtexCompile<CR>')
vim.keymap.set('n', '<leader>lv', ':VimtexView<CR>')
