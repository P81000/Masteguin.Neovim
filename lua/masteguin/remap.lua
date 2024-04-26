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

vim.keymap.set("n", "<leader>hl", ":set hlsearch<CR>")
vim.keymap.set("n", "<leader>nhl", ":nohlsearch<CR>")
