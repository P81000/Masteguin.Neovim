local en = false
local function ismd()
    return vim.bo.filetype == "markdown"
end

local function toggle_glow()
    if not ismd() and not en then
        print("Error: Glow can only be used on Markdown files.")
        return
    end
    vim.cmd("Glow" .. (en and "!" or ""))
    en = not en
end

vim.keymap.set("n", "<leader>md", toggle_glow)
