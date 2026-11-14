-- Harpoon 2 (branch harpoon2). Migrado da API v1.
local harpoon = require("harpoon")

-- Chave estavel do projeto: o git root do cwd atual.
-- A mesma lista carrega de qualquer subpasta, e os paths ficam relativos
-- a esta raiz (display consistente). Corrige o problema de paths mistos do v1.
local function project_root()
  local cwd = (vim.uv or vim.loop).cwd()
  local git = vim.fs.find(".git", { upward = true, path = cwd })[1]
  if git then
    return vim.fs.dirname(git)
  end
  return cwd
end

harpoon:setup({
  settings = {
    save_on_toggle = true,
    sync_on_ui_close = true,
    key = project_root,
  },
  default = {
    get_root_dir = project_root,
  },
})

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():next() end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():prev() end)
