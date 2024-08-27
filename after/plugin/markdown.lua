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

local function toggle_okular()
    if not ismd() and not en then
        print("Error: Okular can only be used on Markdown files.")
        return
    end

    if not en then
        vim.cmd('silent! !okular ' .. vim.fn.expand('%:p') .. ' &')
    end

    en = not en
end

vim.keymap.set("n", "<leader>mg", toggle_glow)
vim.keymap.set("n", "<leader>mo", toggle_okular)
