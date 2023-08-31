return {
  "jbyuki/nabla.nvim",
  keys = {
    {
      "<leader>p",
      [[:lua require("nabla").popup()<CR>]],
      desc = "nabla (math expression)",
    },
  },
}
