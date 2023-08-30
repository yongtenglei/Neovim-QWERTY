return {
	-- essential plugins
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-lua/popup.nvim" },

	{ "christoomey/vim-tmux-navigator" },

	-- my favorite comment plugin (no dot lazy loading...)
	-- comment: <leader>cc uncomment: <leader>cu
	{ "scrooloose/nerdcommenter", lazy = false },

	{
		"jiangmiao/auto-pairs",
	},

	{
		"kylechui/nvim-surround",
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},

	-- optional: require fcitx-remote or fcitx5-remote
	-- { "h-hg/fcitx.nvim" },
}
