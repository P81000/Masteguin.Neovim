vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("v", "<leader>y", "\"+y")

vim.keymap.set("n", "<leader>ct", ":lua changeTheme()<CR>")

vim.api.nvim_set_keymap("i", "'", '"', { noremap = true })
vim.api.nvim_set_keymap("i", '"', "'", { noremap = true })

vim.api.nvim_set_keymap("i", "<TAB>", "pumvisible() ? '<C-y>' : '<TAB>'", { expr = true, noremap = true, silent = true })
