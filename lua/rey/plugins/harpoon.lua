return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("harpoon").setup({
      menu = {
        width = vim.api.nvim_win_get_width(0) - 40,
      },
    })
  end,
  keys = {
    { "gm", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark file with harpoon" },
    { "g;", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Go to next harpoon mark" },
    {
      "g'",
      "<cmd>lua require('harpoon.ui').nav_prev()<cr>",
      desc = "Go to previous harpoon mark",
    },
    { "ga", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Show harpoon marks" },
    { "gj", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "go harpoon marks 1" },
    { "gk", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "go harpoon marks 2" },
    { "gh", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "go harpoon marks 3" },
    { "gl", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "go harpoon marks 4" },
  },
}
