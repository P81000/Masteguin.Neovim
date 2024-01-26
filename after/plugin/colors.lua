local themes = require('telescope.themes')
local actions = require('telescope.actions')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')

-- Caminho do arquivo para armazenar a última opção escolhida
local theme_file_path = vim.fn.stdpath('config') .. '/last_selected_theme'

if not vim.g.selected_theme then
    -- Tente ler a última opção escolhida do arquivo
    local last_theme = vim.fn.filereadable(theme_file_path) == 1 and vim.fn.readfile(theme_file_path)[1] or 'darkrose'
    vim.g.selected_theme = last_theme
end

local available_themes = {'darkrose', 'rose-pine', 'srcery'}

function changeTheme()
  local theme_opts = themes.get_dropdown {
    prompt_title = 'Choose Neovim theme: ',
    themes = available_themes,
    layout_config = {
      width = 60,
      height = 10,
    },
  }

  pickers.new(theme_opts, {
    finder = finders.new_table {
      results = available_themes,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
        }
      end,
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr, map)
      map('i', '<CR>', function()
        local selection = require('telescope.actions.state').get_selected_entry()
        print("Selected " .. selection.value .. " as NeoVim theme")
        vim.g.selected_theme = selection.value
        vim.cmd.colorscheme(vim.g.selected_theme)
        vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

        -- Salve a escolha do tema no arquivo
        vim.fn.writefile({vim.g.selected_theme}, theme_file_path)

        -- Feche o buffer de prompt manualmente
        vim.api.nvim_buf_delete(prompt_bufnr, { force = true })
      end)

      actions.select_default:replace(function()
        -- Feche o buffer de prompt manualmente
        vim.api.nvim_buf_delete(prompt_bufnr, { force = true })
      end)

      return true
    end,
  }):find()
end

vim.cmd.colorscheme(vim.g.selected_theme)
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

