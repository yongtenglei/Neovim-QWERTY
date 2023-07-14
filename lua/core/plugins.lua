local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

return lazy.setup({

	{ "nvim-lua/popup.nvim" }, -- An implementation of the Popup API from vim in Neovim
	{ "nvim-lua/plenary.nvim" }, -- Useful lua functions used ny lots of plugins

	-- little things make life better
	{
		"ethanholz/nvim-lastplace",
		config = function()
			require("configs.lastplace").config()
		end,
	},
	{ "jiangmiao/auto-pairs" },
	{
		"kylechui/nvim-surround",
		config = function()
			require("configs.surround").config()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("configs.indentline").config()
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		config = function()
			require("configs.flash").config()
		end,
	},

	-- helpful if you use fcitx
	{ "h-hg/fcitx.nvim" },

	-- ctag
	{
		"stevearc/aerial.nvim",
		config = function()
			require("configs.aerial").config()
		end,
	},

	-- my favorite comment plugin (no dot lazy loading...)
	-- comment: <leader>cc un-comment: <leader>cu
	{ "scrooloose/nerdcommenter", lazy = false },

	-- basic rice
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("configs.lualine").config()
		end,
	},
	{
		"akinsho/bufferline.nvim",
		config = function()
			require("configs.bufferline").config()
		end,
	},
	{ "kyazdani42/nvim-web-devicons", lazy = true },

	-- file manager
	{
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("configs.nvimtree").config()
		end,
		version = "nightly",
	},

	{ "BurntSushi/ripgrep" }, --requires
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("configs.treesitter").config()
		end,
		build = ":TSUpdate",
		dependencies = {
			{ "p00f/nvim-ts-rainbow" },
		},
	},

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("configs.telescope").config()
		end,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		lazy = false,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
	{
		-- This is original author, check his repo for latest changes
		--"HUAHUAI23/telescope-session.nvim",

		-- Added some feature I want, so I use this personal one
		"yongtenglei/telescope-session.nvim",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("telescope").load_extension("xray23")
		end,
	},
	{
		"gbprod/yanky.nvim",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("telescope").load_extension("yank_history")
			require("yanky").setup({})
		end,
	},
	{
		"nvim-telescope/telescope-bibtex.nvim",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("telescope").load_extension("bibtex")
		end,
	},

	-- lsp
	{
		"williamboman/mason.nvim",
		config = function()
			require("configs.mason").config()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("configs.masonlspconfig").config()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig").config()
		end,
		dependencies = {
			{ "hrsh7th/nvim-cmp" }, -- Autocompletion plugin
			{ "hrsh7th/cmp-nvim-lsp" }, -- LSP source for nvim-cmp
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "f3fora/cmp-spell" },
			{ "hrsh7th/cmp-calc" },
			{ "kdheepak/cmp-latex-symbols" },
			{ "saadparwaiz1/cmp_luasnip" }, -- Snippets source for nvim-cmp
			{
				"L3MON4D3/LuaSnip",
				config = function()
					require("configs.luasnip").config()
				end,
				dependencies = {
					{ "rafamadriz/friendly-snippets" },
				},
			}, -- Snippets plugin
			{ "ray-x/cmp-treesitter" },
			{ "onsails/lspkind.nvim" },
		},
	},

	-- lsp signature
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("configs.lsp_signature").config()
		end,
	},

	-- auto format and other stuff
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("configs.null-ls").config()
		end,
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	},

	-- languages
	{ "mfussenegger/nvim-dap" },
	{ "theHamsta/nvim-dap-virtual-text" },
	{ "rcarriga/nvim-dap-ui" },
	-- golang
	{
		"olexsmir/gopher.nvim",
		config = function()
			require("configs.gopher").config()
		end,
	},
	{ "leoluz/nvim-dap-go" },
	-- rust
	{
		"simrat39/rust-tools.nvim",
		ft = { "rust" },
		config = function()
			require("configs.rust-tools").config()
		end,
		dependencies = { "neovim/nvim-lspconfig", "ray-x/lsp_signature.nvim" },
	},

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("configs.gitsigns").config()
		end,
	},

	-- toggle term
	--{ "akinsho/toggleterm.nvim",    version = "*" },

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("configs.nvimcolorizer").config()
		end,
	},

	-- markdown support
	{ "godlygeek/tabular", ft = { "markdown" } }, -- requires
	{ "plasticboy/vim-markdown", ft = { "markdown" } },
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown" },
		dependencies = {
			{ "dhruvasagar/vim-table-mode" },
		},
	},

	-- latex
	{
		"lervag/vimtex",
		config = function()
			require("configs.vimtex").config()
		end,
		ft = "tex",
	},
	{
		"jbyuki/nabla.nvim",
		config = function()
			--require("configs.nabla").config()
		end,
	},

	-- dashboard
	{
		"goolord/alpha-nvim",
		config = function()
			require("configs.alpha").config()
		end,
	},

	{ "mg979/vim-visual-multi" },

	-- themes give your favorite theme a priority = 1000,
	--{ "sainnhe/gruvbox-material" },
	--{
	--"ellisonleao/gruvbox.nvim",
	--config = function()
	--require("configs.theme.gruvbox").config()
	--end,
	--},
	--{ "joshdick/onedark.vim" },
	--{ "Rigellute/shades-of-purple.vim" },
	--{
	--"rebelot/kanagawa.nvim",
	--config = function()
	--require("configs.theme.kanagawa").config()
	--end,
	--},
	--{ "sainnhe/everforest" },
	--{
	--"catppuccin/nvim",
	--config = function()
	--require("configs.theme.catppuccin").config()
	--end,
	--},
	{
		"Shatur/neovim-ayu",
		config = function()
			require("configs.theme.ayu").config()
		end,
		priority = 1000,
	},

	-- UI
	--{
	--"folke/noice.nvim",
	--config = function()
	--require("configs.noice").config()
	--end,
	--dependencies = { { "MunifTanjim/nui.nvim" } },
	--},
	--{
	--"rcarriga/nvim-notify",
	--config = function()
	--require("configs.notify").config()
	--end,
	--},
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("configs.scrollbar").config()
		end,
	},
	{
		"folke/todo-comments.nvim",
		config = function()
			require("configs.todo-comments").config()
		end,
	},
	{
		"j-hui/fidget.nvim",
		config = function()
			require("configs.fidget").config()
		end,
		-- to avoid break changes
		tag = "legacy",
	},

	-- which-key (default config is enough)
	{
		"folke/which-key.nvim",
	},

	-- marks
	{
		"chentoast/marks.nvim",
		config = function()
			require("configs.marks").config()
		end,
	},

	-- with Tmux
	{
		"christoomey/vim-tmux-navigator",
	},
})
