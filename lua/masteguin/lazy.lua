local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:append(lazypath)

require("lazy").setup({
     spec = {
         {
             "nvim-telescope/telescope.nvim",
             dependencies = { "nvim-lua/plenary.nvim" },
         },
         {
             "no-clown-fiesta/no-clown-fiesta.nvim",
         },
         {
             "killitar/obscure.nvim",
         },
         {
             "savq/melange-nvim",
         },
         {
             "rose-pine/neovim",
             config = function()
                 require("rose-pine").setup({
                     styles = {
                         bold = true,
                         italic = true,
                         transparency = true
                     }
                 })
             end
         },
         {
             "APZelos/blamer.nvim",
             config = function()
                 vim.g.blamer_enabled = true
                 vim.g.blamer_delay = 1500
                 vim.g.blamer_show_in_visual_modes = 0
                 vim.g.blamer_show_in_insert_modes = 0
                 vim.g.blamer_prefix = " >> "
                 vim.g.blamer_relative_time = 1
             end
         },
         {
             "tpope/vim-sleuth"
         },
         {
             "nvimdev/lspsaga.nvim",
             config = function()
                 require("lspsaga").setup({
                     symbol_in_winbar = {
                         enable = false,
                     }
                 })
             end,
         },
         {
             "nvim-treesitter/nvim-treesitter",
             build = ":TSUpdate",
             lazy = false,
             config = function()
                 local status, ts = pcall(require, "nvim-treesitter.configs")
                 if not status then return end

                 ts.setup({
                     ensure_installed = {
                         "c", "cpp", "lua", "vim", "vimdoc", "query", "php", "html"
                     },
                     highlight = {
                         enable = true,
                         additional_vim_regex_highlighting = false,
                     },
                     indent = { enable = true },
                 })
             end,
         },
         {
             "theprimeagen/harpoon"
         },
         {
             "mbbill/undotree"
         },
         {
             "tpope/vim-fugitive"
         },
         {
             "neovim/nvim-lspconfig"
         },
         {
             "OXY2DEV/markview.nvim",
             lazy = false,

             -- Completion for `blink.cmp`
             -- dependencies = { "saghen/blink.cmp" },
         },
         {
             "VonHeikemen/lsp-zero.nvim",
             branch = "v3.x",
             dependencies = {
                 { "neovim/nvim-lspconfig" },
                 { "hrsh7th/nvim-cmp" },
                 { "hrsh7th/cmp-nvim-lsp" },
             },
         },
         {
             "williamboman/mason.nvim",
             config = function()
                 require("mason").setup({
                     automatic_installation = false,
                     ensure_installed = {
                         "lua_ls",
                         "intelephense",
                         "laravel_ls"
                    }
                })
             end
         },
         {
             "williamboman/mason-lspconfig.nvim",
             dependencies = { "williamboman/mason.nvim" },
             config = function()
                 require("mason-lspconfig").setup({
                     automatic_installation = false,
                     ensure_installed = {
                         "lua_ls",
                         "laravel_ls"
                     }
                 })
             end
         },
         {
             "kevinhwang91/nvim-ufo",
             dependencies = "kevinhwang91/promise-async",
             event = "BufReadPost",
             config = function()
                 vim.opt.foldcolumn = '1'
                 vim.opt.foldlevel = 99
                 vim.opt.foldlevelstart = 99
                 vim.opt.foldenable = true
                 vim.opt.fillchars = {
                     eob       = " ",
                     fold      = " ",
                     foldopen  = "▾",   -- U+25BE
                     foldsep   = " ",
                     foldclose = "▸",   -- U+25B8
                 }

                 local function c_cpp_provider(bufnr)
                     local ranges = require('ufo.provider.indent').getFolds(bufnr)

                     local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
                     local inc_start = nil
                     for i, line in ipairs(lines) do
                         if line:match("^%s*#%s*include") then
                             if not inc_start then inc_start = i - 1 end
                         else
                             if inc_start ~= nil then
                                 if (i - 2) > inc_start then
                                     table.insert(ranges, { startLine = inc_start, endLine = i - 2, kind = 'imports' })
                                 end
                                 inc_start = nil
                             end
                         end
                     end
                     if inc_start and (#lines - 1) > inc_start then
                         table.insert(ranges, { startLine = inc_start, endLine = #lines - 1, kind = 'imports' })
                     end

                     return ranges
                 end

                 require('ufo').setup({
                     provider_selector = function(bufnr, filetype, buftype)
                         if filetype == 'c' or filetype == 'cpp' then
                             return c_cpp_provider
                         end
                         return { 'treesitter', 'indent' }
                     end
                 })

                 vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
                 vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
             end
         }
     },

     checker = { enabled = false },
     ui = { border = "single" },
 })
