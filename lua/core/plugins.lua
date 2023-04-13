local fn = vim.fn

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
  augroup packer_user_config
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

-- Only required if you have packer configured as `opt`
--vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
  -- Packer can manage itself
  use({ "wbthomason/packer.nvim" })
  use("nvim-lua/popup.nvim")  -- An implementation of the Popup API from vim in Neovim
  use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins

  use({ "ethanholz/nvim-lastplace" })

  use({ "nvim-lualine/lualine.nvim" })

  use({ "akinsho/bufferline.nvim" })

  use({ "kyazdani42/nvim-web-devicons" })

  use({
    "kyazdani42/nvim-tree.lua",
    tag = "nightly",
  })

  use({ "lukas-reineke/indent-blankline.nvim" })

  -- 注释 <leader>cc 反注释 <leader>cu
  use({ "scrooloose/nerdcommenter" })

  use({ "BurntSushi/ripgrep" }) --requires
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use({ "p00f/nvim-ts-rainbow" })
  -- requires
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  })
  use({ "nvim-telescope/telescope.nvim", requires = { { "nvim-lua/plenary.nvim" } } })

  use({ "phaazon/hop.nvim", branch = "v2" }) --rv2' optional but strongly recommended

  use({ "NvChad/nvim-colorizer.lua" })

  use({ "jiangmiao/auto-pairs" })

  -- lsp
  use({ "williamboman/mason.nvim" })
  use({ "williamboman/mason-lspconfig.nvim" })
  use({ "neovim/nvim-lspconfig" })
  use({ "hrsh7th/nvim-cmp" })    -- Autocompletion plugin
  use({ "hrsh7th/cmp-nvim-lsp" }) -- LSP source for nvim-cmp
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-path" })
  use({ "hrsh7th/cmp-cmdline" })
  use({ "hrsh7th/cmp-nvim-lua" })
  use({ "f3fora/cmp-spell" })
  use({ "hrsh7th/cmp-calc" })
  use({ "saadparwaiz1/cmp_luasnip" }) -- Snippets source for nvim-cmp
  use({ "L3MON4D3/LuaSnip" })        -- Snippets plugin
  use({ "rafamadriz/friendly-snippets" })
  use({ "ray-x/cmp-treesitter" })
  use({ "onsails/lspkind.nvim" })

  -- languages
  use({ "mfussenegger/nvim-dap" })
  use({ "theHamsta/nvim-dap-virtual-text" })
  use({ "rcarriga/nvim-dap-ui" })

  use({ "olexsmir/gopher.nvim" })
  use({ "leoluz/nvim-dap-go" })

  -- Git
  use({ "lewis6991/gitsigns.nvim" })

  -- toggle term
  use({ "akinsho/toggleterm.nvim", tag = "*" })

  use({ "j-hui/fidget.nvim" })

  use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" } })

  use({ "h-hg/fcitx.nvim" })

  use({ "godlygeek/tabular", ft = { "markdown" } }) -- requires
  use({ "plasticboy/vim-markdown", ft = { "markdown" } })
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  })
  use({ "dhruvasagar/vim-table-mode" })

  use({ "mbbill/undotree" })

  use({ "lervag/vimtex" })

  use({ "goolord/alpha-nvim" })

  use({ "mg979/vim-visual-multi" })

  use({ "chentoast/marks.nvim" })

  use({ "stevearc/aerial.nvim" })

  -- themes
  use({
    "sainnhe/gruvbox-material",
    "ellisonleao/gruvbox.nvim",
    "joshdick/onedark.vim",
    "Rigellute/shades-of-purple.vim",
    "rebelot/kanagawa.nvim",
    "sainnhe/everforest",
    "catppuccin/nvim",
    "Shatur/neovim-ayu",
  })

  -- surround
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
  })

  -- translator
  --use({ "voldikss/vim-translator" })

  -- benchmark
  use({ "dstein64/vim-startuptime" })
  use({ "lewis6991/impatient.nvim" })

  -- UI
  use({ "folke/noice.nvim" })
  use({ "MunifTanjim/nui.nvim" })
  use({ "rcarriga/nvim-notify" })
  use({ "petertriho/nvim-scrollbar" })
  use({ "folke/todo-comments.nvim" })

  -- with Tmux
  use({ "christoomey/vim-tmux-navigator" })
end)
