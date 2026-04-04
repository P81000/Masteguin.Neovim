local themes = require('telescope.themes')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')

-- Caminho do arquivo para armazenar a ultima opcao escolhida
local theme_file_path = vim.fn.stdpath('config') .. '/last_selected_theme'

if not vim.g.selected_theme then
  local last_theme = vim.fn.filereadable(theme_file_path) == 1
    and vim.fn.readfile(theme_file_path)[1]
    or 'no-clown-fiesta'

  vim.g.selected_theme = last_theme
end

local available_themes = {
  'moonfly',
  'no-clown-fiesta',
  'obscure',
  'melange',
  'rose-pine',
  'purplepeter'
}

function changeTheme()
  local opts = themes.get_dropdown({
    prompt_title = 'Choose Neovim theme:',
    layout_config = {
      width = 60,
      height = 10,
    },
  })

  pickers.new(opts, {
    finder = finders.new_table({
      results = available_themes,
    }),

    sorter = sorters.get_generic_fuzzy_sorter(),

    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()

        vim.g.selected_theme = selection[1]

        vim.cmd.colorscheme(vim.g.selected_theme)

--         vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
--         vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

        vim.fn.writefile({ vim.g.selected_theme }, theme_file_path)

        actions.close(prompt_bufnr)
      end)

      return true
    end,
  }):find()
end

vim.cmd.colorscheme(vim.g.selected_theme)
-- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
-- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
