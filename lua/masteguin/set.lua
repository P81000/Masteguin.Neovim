vim.opt.guicursor = ""

vim.opt.clipboard = "unnamedplus"

vim.opt.nu = true
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- vim.opt.smartindent = true

vim.opt.linebreak = true
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.showbreak = " ↪ "

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

vim.diagnostic.config({
    virtual_lines = { current_line = true }
})

vim.o.shell = "/bin/bash"
vim.o.shellcmdflag = "-l -c"

-- vim.lsp.set_log_level("debug")


vim.filetype.add({
  pattern = {
    ['.*%.blade%.php'] = 'php',
  },
})
