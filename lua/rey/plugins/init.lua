return {
  -- essential plugins
  { "nvim-lua/plenary.nvim" },
  { "nvim-lua/popup.nvim" },

  { "christoomey/vim-tmux-navigator" },

  -- smarter auto change directory
  { "airblade/vim-rooter" },

  {
    "kylechui/nvim-surround",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },

  -- optional: require fcitx-remote or fcitx5-remote
  -- { "h-hg/fcitx.nvim" },
}
