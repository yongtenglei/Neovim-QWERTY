return {
  "olexsmir/gopher.nvim",
  ft = { "go" },
  config = function()
    -- install the tools
    -- gopls golangci-lint-langserver delve goimports gofumpt gomodifytags gotests impl
    -- also
    -- :GoInstallDeps
    require("gopher").setup({
      commands = {
        go = "go",
        gomodifytags = "gomodifytags",
        gotests = "~/go/bin/gotests", -- also you can set custom command path
        impl = "impl",
        iferr = "iferr",
      },
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
