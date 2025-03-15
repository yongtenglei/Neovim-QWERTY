return {
  "aliqyan-21/wit.nvim",
  keys = {
    {
      "<leader>ws",
      ":WitSearch ",
      desc = "Web Search",
    },
  },
  config = function()
    require("wit").setup()
  end,
}
