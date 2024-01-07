return {
  "saecki/crates.nvim",
  tag = "stable",
  ft = { "rust", "toml" },
  event = { "BufRead", "BufReadPre", "BufNewFile" },
  config = function()
    require("crates").setup({
      popup = {
        border = "rounded",
      },
    })
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
}
