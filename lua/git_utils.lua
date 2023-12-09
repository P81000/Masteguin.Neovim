local M = {}

function M.git_commit(options)
    local commit_msg = vim.fn.input('Commit message: ')
    if commit_msg ~= '' then
        vim.fn.system('git commit '.. options .. ' -m "' .. commit_msg .. '"')
    else
        print('Commit message cannot be empty.')
    end
end

function M.git_push(options)
    local branch_name = vim.fn.input('Branch name: ')
    if commit_msg ~= '' then
        vim.fn.syste('git push '.. options .. ' -u origin "' .. branch_name .. '"')
    else
        print('Specify a branch name.')
    end
end

return M
