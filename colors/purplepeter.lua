-- purplepeter.nvim - Colorscheme standalone para Neovim 0.11
-- Gerado a partir da paleta fornecida

local colors = {
  black            = "#0a0520",
  red              = "#ff796d",
  green            = "#99b481",
  yellow           = "#efdfac",
  blue             = "#66d9ef",
  purple           = "#e78fcd",
  cyan             = "#ba8cff",
  white            = "#ffba81",
  brightBlack      = "#100b23",
  brightRed        = "#f99f92",
  brightGreen      = "#b4be8f",
  brightYellow     = "#f2e9bf",
  brightBlue       = "#79daed",
  brightPurple     = "#ba91d4",
  brightCyan       = "#a0a0d6",
  brightWhite      = "#b9aed3",
  bg               = "#2a1a4a",
  fg               = "#ece7fa",
  sel              = "#8689c2",
  cursor           = "#c7c7c7"
}

-- Aplica defaults do editor
vim.api.nvim_set_option("background", "dark")

vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

vim.api.nvim_set_hl(0, "Cursor",            { fg = colors.bg, bg = colors.cursor })
vim.api.nvim_set_hl(0, "Visual",            { bg = colors.sel })
vim.api.nvim_set_hl(0, "LineNr",            { fg = colors.brightPurple })
vim.api.nvim_set_hl(0, "CursorLineNr",      { fg = colors.yellow })
vim.api.nvim_set_hl(0, "CursorLine",        { bg = "#332255" })
vim.api.nvim_set_hl(0, "Search",            { fg = colors.bg, bg = colors.yellow })
vim.api.nvim_set_hl(0, "IncSearch",         { fg = colors.bg, bg = colors.brightYellow })
vim.api.nvim_set_hl(0, "MatchParen",        { fg = colors.brightCyan, bg = colors.brightBlack })

-- Sintaxe básica
vim.api.nvim_set_hl(0, "Comment",           { fg = colors.brightWhite, italic = true })
vim.api.nvim_set_hl(0, "Identifier",        { fg = colors.cyan })
vim.api.nvim_set_hl(0, "Function",          { fg = colors.blue })
vim.api.nvim_set_hl(0, "Statement",         { fg = colors.red })
vim.api.nvim_set_hl(0, "Keyword",           { fg = colors.purple })
vim.api.nvim_set_hl(0, "Type",              { fg = colors.green })
vim.api.nvim_set_hl(0, "String",            { fg = colors.yellow })
vim.api.nvim_set_hl(0, "Number",            { fg = colors.brightPurple })
vim.api.nvim_set_hl(0, "Boolean",           { fg = colors.brightRed })
vim.api.nvim_set_hl(0, "Operator",          { fg = colors.white })

-- Interface
vim.api.nvim_set_hl(0, "Pmenu",             { fg = colors.fg, bg = "#3a2a5a" })
vim.api.nvim_set_hl(0, "PmenuSel",          { fg = colors.bg, bg = colors.cyan })
vim.api.nvim_set_hl(0, "StatusLine",        { fg = colors.fg, bg = "#3e2a63" })
vim.api.nvim_set_hl(0, "StatusLineNC",      { fg = colors.brightBlack, bg = "#3e2a63" })
vim.api.nvim_set_hl(0, "VertSplit",         { fg = colors.brightBlack })
vim.api.nvim_set_hl(0, "WinSeparator",      { fg = colors.brightBlack })
vim.api.nvim_set_hl(0, "TabLine",           { fg = colors.brightBlack, bg = colors.bg })
vim.api.nvim_set_hl(0, "TabLineSel",        { fg = colors.fg, bg = "#403060" })

-- Diagnósticos
vim.api.nvim_set_hl(0, "DiagnosticError",   { fg = colors.red })
vim.api.nvim_set_hl(0, "DiagnosticWarn",    { fg = colors.yellow })
vim.api.nvim_set_hl(0, "DiagnosticInfo",    { fg = colors.blue })
vim.api.nvim_set_hl(0, "DiagnosticHint",    { fg = colors.cyan })

-- Links (mantém consistência)
vim.api.nvim_set_hl(0, "Conditional", { link = "Keyword" })
vim.api.nvim_set_hl(0, "Repeat",      { link = "Keyword" })
vim.api.nvim_set_hl(0, "Label",       { link = "Keyword" })
vim.api.nvim_set_hl(0, "Field",       { link = "Identifier" })
vim.api.nvim_set_hl(0, "Property",    { link = "Identifier" })

return colors
