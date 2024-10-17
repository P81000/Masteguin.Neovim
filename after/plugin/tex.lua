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

-- Compile with lualatex
local function compile_lualatex()
    local filename = vim.fn.expand("%:p")
    local pdfname = vim.fn.expand("%:p:r") .. ".pdf"

    vim.fn.system("lualatex --interaction=nonstopmode --synctex=1 " .. filename)

    -- Open PDF with xreader
    vim.fn.jobstart({"xreader", pdfname}, {detach = true})
end

-- Key mapping to compile LaTeX
vim.keymap.set('n', '<leader>lt', compile_lualatex)

-- Autocommand to compile on save
-- vim.api.nvim_create_autocmd("BufWritePost", {
--     pattern = "*.tex",
--     callback = compile_lualatex,
-- })
