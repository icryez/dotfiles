-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'


	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	use ({'Mofiqul/dracula.nvim',
	config = function()
		vim.cmd[[colorscheme dracula]]
	end
})
	use('mbbill/undotree')
	use('tpope/vim-fugitive', {run = ':TSUpdate'})
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
			--- Uncomment the two plugins below if you want to manage the language servers from neovim
			-- {'williamboman/mason.nvim'},
			-- {'williamboman/mason-lspconfig.nvim'},

			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},
			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lua'},
			{'rafamadriz/friendly-snippets'},
			{'L3MON4D3/LuaSnip'},
		}
	}
    use ('ThePrimeagen/vim-be-good')
    
use({
  "mfussenegger/nvim-jdtls",
  config = function()
    -- https://github.com/fitrh/init.nvim/blob/main/lua/plugin/jdtls/config.lua
    require("plugin.jdtls.config").attach()
  end,
  module = "jdtls",
})
  end)
