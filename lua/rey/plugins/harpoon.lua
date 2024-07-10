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
    { "<leader>gm", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark file with harpoon" },
    { "<leader>gu", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Go to next harpoon mark" },
    {
      "<leader>gi",
      "<cmd>lua require('harpoon.ui').nav_prev()<cr>",
      desc = "Go to previous harpoon mark",
    },
    { "<leader>ga", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Show harpoon marks" },
    { "<leader>gj", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "go harpoon marks 1" },
    { "<leader>gk", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "go harpoon marks 2" },
    { "<leader>gh", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "go harpoon marks 3" },
    { "<leader>gl", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "go harpoon marks 4" },
  },
}
