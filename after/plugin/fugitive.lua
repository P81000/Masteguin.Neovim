vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
vim.keymap.set('n', '<leader>ga', [[:Git add . -v<CR>]])
vim.keymap.set('n', '<leader>gc', [[:lua require('git_utils').git_commit('-v')<CR>]])
vim.keymap.set('n', '<leader>gp', [[:lua require('git_utils').git_push('-v')<CR>]])
