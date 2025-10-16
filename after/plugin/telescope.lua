local builtin = require('telescope.builtin')
local utils = require('telescope.utils')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

vim.keymap.set('n', '<leader>pg', function()
    local search_query = vim.fn.input("Grep > ")
    builtin.grep_string({ search = search_query })
end)

vim.keymap.set('n', '<leader>ps', function()
    local search_query = vim.fn.input("Grep > ")
	builtin.grep_string({
        search = search_query,
        cwd = utils.buffer_dir(),
        only_sort_text = true
    })
end)

