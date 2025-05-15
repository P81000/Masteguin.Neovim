local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local themes = require("telescope.themes")
local conf = require("telescope.config").values
local Path = require("plenary.path")

local function list_dirs(path)
    local cmd = "fd --type d --hidden --exclude .git --max-depth 1 . " .. vim.fn.shellescape(path)
    local h = io.popen(cmd)
    if not h then return {} end

    local tbl = {}
    for line in h:lines() do
        local rel = Path:new(line):make_relative(path)
        if rel ~= "." then
            table.insert(tbl, rel .. "/")
        end
    end
    h:close()

    table.insert(tbl, 1, "../")
    table.insert(tbl, 1, "./")
    return tbl
end

local function dir_explorer(start_path)
    start_path = vim.fn.fnamemodify(start_path or vim.fn.getcwd(), ":p")
    local dirs = list_dirs(start_path)

    pickers.new(themes.get_dropdown({
        previewer    = false,
        width        = 0.5,
        height       = 0.5,
    }), {
        finder = finders.new_table {
            results = dirs,
            entry_maker = function(entry)
                return { value = entry, display = entry, ordinal = entry }
            end,
        },
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            local function on_confirm()
                local sel = action_state.get_selected_entry() and action_state.get_selected_entry().value
                local query = vim.trim(action_state.get_current_line())

                actions.close(prompt_bufnr)

                if query ~= "" and (not sel or query ~= sel) then
                    local target = query:sub(1,1) == "/" and query or (start_path .. "/" .. query)
                    local real   = vim.fn.fnamemodify(target, ":p")

                    if vim.fn.isdirectory(real) == 1 then
                        vim.cmd("cd " .. vim.fn.fnameescape(real))
                        vim.cmd("silent! edit " .. vim.fn.fnameescape(real))
                    else
                        vim.notify("⛔ Directory not found: " .. real, vim.log.levels.ERROR)
                    end
                    return
                end

                if sel == "./" then
                    vim.cmd("cd " .. vim.fn.fnameescape(start_path))
                    vim.cmd("silent! edit " .. vim.fn.fnameescape(start_path))

                elseif sel == "../" then
                    local up = vim.fn.fnamemodify(start_path .. "/..", ":p")
                    dir_explorer(up)
                else
                    local clean = sel:sub(-1) == "/" and sel:sub(1, -2) or sel
                    local newp  = vim.fn.fnamemodify(start_path .. "/" .. clean, ":p")
                    dir_explorer(newp)
                end
            end

            map("i", "<CR>", on_confirm)
            map("n", "<CR>", on_confirm)
            return true
        end,
    }):find()
end

vim.keymap.set("n", "<leader>pF", function()
    dir_explorer()
end)
