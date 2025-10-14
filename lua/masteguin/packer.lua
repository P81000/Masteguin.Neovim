vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		requires = { 
            {'nvim-lua/plenary.nvim'},
        }
	}
	
    use({
        'water-sucks/darkrose.nvim',
        as = 'darkrose',
        config = function()
            vim.cmd('colorscheme darkrose')
        end
    })

    use({
        'srcery-colors/srcery-vim',
        as = 'srcery',
        config = function()
            vim.cmd('colorscheme srcery')
        end
    })

    use({
        "EdenEast/nightfox.nvim",
        as = 'nightfox',
        config = function()
            vim.cmd('colorscheme nightfox')
        end
    })

    use({
        "bluz71/vim-moonfly-colors",
        as = 'moonfly',
        config = function()
            vim.cmd('colorscheme moonfly')
        end
    })

    use({
        "NLKNguyen/papercolor-theme",
        as = "PaperColor",
        config = function()
            vim.cmd("colorscheme PaperColor")
        end
    })

    use({
        "no-clown-fiesta/no-clown-fiesta.nvim",
        as = "no-clown-fiesta",
        config = function()
            vim.cmd("colorscheme no-clown-fiesta")
        end
    })

    use({
        "killitar/obscure.nvim",
        as = "obscure",
        config = function()
            vim.cmd("colorscheme obscure")
        end
    })

    use({
        "iruzo/matrix-nvim",
        as = "matrix",
        config = function()
            vim.cmd("colorscheme matrix")
        end
    })

    use({
        "savq/melange-nvim",
        as = "melange",
        config = function()
            vim.cmd("colorscheme melange")
        end
    })

    use( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    use( 'theprimeagen/harpoon' )

    use( 'mbbill/undotree' )

   	use( 'tpope/vim-fugitive' )

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment these if you want to manage LSP servers from neovim
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- LSP Support
            {'neovim/nvim-lspconfig'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    }

    use( 'williamboman/mason.nvim' )

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        }
    }

    use ({
        'nvimdev/lspsaga.nvim',
        after = 'nvim-lspconfig',
        config = function()
            require('lspsaga').setup({
                symbol_in_winbar = {
                    enable = false,
                }
            })
        end,
    })

    use ( 'tpope/vim-sleuth' )

    use ({
        'APZelos/blamer.nvim',
        config = function()
            vim.g.blamer_enabled = true
            vim.g.blamer_delay = 1000
            vim.g.blamer_show_in_visual_modes = 0
            vim.g.blamer_show_in_insert_modes = 0
            vim.g.blamer_prefix = ' > '
            vim.g.blamer_relative_time = 1
        end,
    })


end)
