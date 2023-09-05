return {
	-- essential plugins
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-lua/popup.nvim" },

	{ "christoomey/vim-tmux-navigator" },

	-- my favorite comment plugin (no dot lazy loading...)
	-- comment: <leader>cc uncomment: <leader>cu
	{ "scrooloose/nerdcommenter", lazy = false },

	-- smarter auto change directory
	{
		"airblade/vim-rooter",
	},

	{
		"kylechui/nvim-surround",
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},

	-- optional: require fcitx-remote or fcitx5-remote
	-- { "h-hg/fcitx.nvim" },
}
