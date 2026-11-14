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

if vim.fn.has("win32") == 0 then
    vim.o.shell = "/bin/bash"
    vim.o.shellcmdflag = "-l -c"
else
    if vim.fn.executable("pwsh") == 1 then
        vim.o.shell = "pwsh"
    else
        vim.o.shell = "powershell"
    end
    vim.o.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
    vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    vim.o.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
    vim.o.shellquote = ""
    vim.o.shellxquote = ""
end

-- vim.lsp.set_log_level("debug")


vim.filetype.add({
  pattern = {
    ['.*%.blade%.php'] = 'php',
  },
})
