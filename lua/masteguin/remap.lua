vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("v", "<leader>y", "\"+y")

vim.keymap.set("n", "<leader>ct", ":lua changeTheme()<CR>")

vim.api.nvim_set_keymap("i", "'", '"', { noremap = true })
vim.api.nvim_set_keymap("i", '"', "'", { noremap = true })

vim.keymap.set("n", "<leader>w", function() vim.cmd("w") end, { noremap = true, silent=true })
vim.keymap.set("n", "<leader>q", function()
    local modifiedBuffers = vim.tbl_filter(function(buf)
        return vim.api.nvim_buf_get_option(buf, "modified")
    end, vim.api.nvim_list_bufs())

    if #modifiedBuffers > 0 then
        vim.fn.input("Error: There are unsaved changes. Save or discard them before quiting! Press ENTER or type command to continue")
	    vim.cmd("buffer " .. modifiedBuffers[1])
    else
        vim.cmd("q")
    end
end, { noremap = true, silent=true })
vim.keymap.set("n", "<leader>wq", function() vim.cmd("wq") end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>so", function() vim.cmd("so") end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>wa", ":wa<CR>")
vim.keymap.set("n", "<leader>fq", ":q!<CR>")

vim.keymap.set("n", "<leader>hl", function() if vim.o.hlsearch then vim.cmd("nohlsearch") else vim.cmd("set hlsearch") end end, { noremap = true, silent = true })

vim.keymap.set("t", "<leader><ESC>", "<C-\\><C-n>", { noremap = true })
vim.keymap.set("n", "<leader>0", "$", { noremap = true })
vim.keymap.set("v", "<leader>0", "$", { noremap = true })

vim.keymap.set("n", "<leader>tn", ":tabnext<CR>", { noremap = true })
vim.keymap.set("n", "<leader>tp", ":tabprev<CR>", { noremap = true })
