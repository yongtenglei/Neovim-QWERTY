return {
  "wintermute-cell/gitignore.nvim",
  keys = {
    {
      "<leader>ig",
      mode = { "n" },
      function()
        require("gitignore").generate()
      end,
      desc = "Gitignore generator",
    },
  },
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
}
