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
             "EdenEast/nightfox.nvim",
             config = function()
                 vim.cmd("colorscheme nightfox")
             end
         },
         {
             "bluz71/vim-moonfly-colors",
             config = function()
                 vim.cmd("colorscheme moonfly")
             end
         },
         {
             "no-clown-fiesta/no-clown-fiesta.nvim",
             config = function()
                 vim.cmd("colorscheme no-clown-fiesta")
             end
         },
         {
             "killitar/obscure.nvim",
             config = function()
                 vim.cmd("colorscheme obscure")
             end
         },
         {
             "savq/melange-nvim",
             config = function()
                 vim.cmd("colorscheme melange")
             end
         },
         {
             "rose-pine/neovim",
             config = function()
                 vim.cmd("colorscheme rose-pine")
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
             "nvim-treesitter/nvim-treesitter"
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
                     automatic_instalation = false,
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
                     automatic_instalation = false,
                     ensure_installed = {
                         "lua_ls",
                         "intelephense",
                         "laravel_ls"
                     }
                 })
             end
         },
     },
   
    checker = { enabled = false },
    ui = { border = "single" },
})
