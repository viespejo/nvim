-- vim: set foldmethod=marker:

local fn = vim.fn

-- not change often {{{
-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_vec_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- }}}

-- Install your plugins here
return packer.startup(function(use)
	-- Packer
	use("wbthomason/packer.nvim") -- Have packer manage itself

	-- speed starttime
	use("lewis6991/impatient.nvim") -- Speed up loading Lua modules in Neovim to improve startup time
	use("nathom/filetype.nvim") -- A faster version of filetype.vim

	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins

	-- color
	use("folke/tokyonight.nvim")

	-- registers
	use("tversteeg/registers.nvim") -- preview the contents of the registers

	-- matchit/matchparen replacement
	use({ "andymass/vim-matchup", setup = [[require('vec.config.matchup')]] })

	-- Completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"L3MON4D3/LuaSnip", -- snippets
			"rafamadriz/friendly-snippets", -- a bunch of snippets to use
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
			-- 'hrsh7th/cmp-nvim-lsp-signature-help',
			{ "hrsh7th/cmp-path", after = "nvim-cmp" },
			-- { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
			{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
			{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
			-- 'lukas-reineke/cmp-under-comparator',
			-- { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
		},
		config = [[require('vec.config.cmp')]],
		-- event = 'InsertEnter *',
	})

	-- luasnip
	use({
		"L3MON4D3/LuaSnip",
		config = [[require('vec.config.luasnip')]],
	})
	-- LSP
	use({
		"neovim/nvim-lspconfig", -- enable LSP
		requires = {
			{ "williamboman/nvim-lsp-installer", after = "nvim-lspconfig" }, -- simple to use language server installer
		},
		config = [[require('vec.config.lsp')]],
	})

	-- formatters and linters
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("vec.config.null-ls")
		end,
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			"p00f/nvim-ts-rainbow",
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = [[require('vec.config.treesitter')]],
	})

	-- FZF
	use({
		vim.env.HOME .. "/.dotfiles/fzf",
		requires = {
			"junegunn/fzf.vim",
			"Shougo/neomru.vim",
		},
	})

	-- autopairs
	use({
		"windwp/nvim-autopairs",
		config = [[ require('vec.config.autopairs') ]],
	})

	-- emmet
	use("mattn/emmet-vim")

	-- colorizer
	use({
		"norcalli/nvim-colorizer.lua",
		config = [[require('vec.config.colorizer')]],
	})

	-- Undotree
	use({ "mbbill/undotree", opt = true, cmd = { "UndotreeToggle" } })

	-- oscyank
	use({
		vim.env.HOME .. "/.dotfiles/vim-submodules/vim-oscyank",
		opt = true,
		cmd = { "OSCYank", "OSCYankReg" },
	})

	-- comments
	use({
		"numToStr/Comment.nvim",
		requires = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = [[require('vec.config.comments')]],
	})

	-- nvim-dap
	use({
		"mfussenegger/nvim-dap",
		requires = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
		opt = true,
		-- cmd = {"DAPInit"},
		-- config = [[require('vec.config.dap.init')]],
	})

	-- GIT
	use({
		"tpope/vim-fugitive",
		{
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = [[require('vec.config.gitsigns')]],
		},
	})

	-- nvimtree
	use({
		"kyazdani42/nvim-tree.lua",
		opt = true,
		cmd = { "NvimTreeToggle" },
		config = function()
			require("vec.config.nvim-tree")
		end,
	})
	use("kyazdani42/nvim-web-devicons")

	-- lualine
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("vec.config.lualine")
		end,
	})

	-- trouble
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("vec.config.trouble")
		end,
	})

	-- copilot
	use("github/copilot.vim")
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
