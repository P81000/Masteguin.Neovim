vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		requires = { 
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-fzf-native.nvim'}
        }
	}
	
	use({
		'rose-pine/neovim',
		as = 'rose-pine',
		config = function()
			vim.cmd('colorscheme rose-pine')
		end
	})
    
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
        "scottmckendry/cyberdream.nvim",
        as = 'cyberdream',
        config = function()
            require("cyberdream").setup({
                transparent = true,
                italic_comments = true,
                hide_fillchars = true,
                bordeless_telescope = true,
            })
            vim.cmd('colorscheme cyberdream')
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

    use( 'lervag/vimtex' )

    use( "andweeb/presence.nvim" )
end)
