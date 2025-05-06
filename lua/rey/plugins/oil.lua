return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  config = function()
    require("oil").setup()
    vim.keymap.set("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Oil: Open parent directory" })
  end,
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
}
