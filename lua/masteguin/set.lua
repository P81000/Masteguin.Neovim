vim.opt.guicursor = ""

vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
        ["+"] = "clip.exe",
        ["*"] = "clip.exe",
    },
    paste = {
        ["+"] = "powershell.exe -NoProfile -Command Get-Clipboard",
        ["*"] = "powershell.exe -NoProfile -Command Get-Clipboard",
    },

}

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.linebreak = true
vim.opt.wrap = true
vim.opt.breakindent = true
-- vim.opt.showbreak = string.rep(" ", 3)
vim.opt.showbreak = "↪ "

vim.opt.colorcolumn = "100"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.signcolumn = "no"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.spelllang = "en_us"
vim.opt.spell = true

-- vim.cmd([[
--     augroup auto_save
--         autocmd!
--         autocmd InsertLeave * if &modifiable && !&readonly && expand('%') != '' | silent! write | endif
--     augroup END
-- ]])

vim.diagnostic.config({
  virtual_lines = { current_line = true },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.wo.winbar = nil
    end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "h" },
  callback = function()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "h", "cc", "hpp" },
    callback = function()
        vim.keymap.set("n", "=", [[:%!clang-format -assume-filename=% -style=file<CR>]], { buffer = true, noremap = true, silent = true })

        vim.keymap.set("x", "=", function()
            local s = vim.api.nvim_buf_get_mark(0, "<")[1]
            local e = vim.api.nvim_buf_get_mark(0, ">")[1]
            if s == 0 or e == 0 then
                print("No visual selection for clang-format")
                return
            end
            if s > e then s, e = e, s end

            local file = vim.fn.expand("%:p")

            vim.api.nvim_input("<Esc>")

            local view = vim.fn.winsaveview()
            vim.cmd(string.format(
                "%%!clang-format -lines=%d:%d -assume-filename=%s -style=file",
                s, e, vim.fn.shellescape(file)
            ))
            vim.fn.winrestview(view)
        end, { buffer = true, noremap = true, silent = true })
    end,
})
