return {
  "rest-nvim/rest.nvim",
  config = function()
    require("telescope").load_extension("rest")
    vim.keymap.set("n", "<leader>rr", ":Rest run <CR>")
    vim.keymap.set("n", "<leader>re", function()
      require("telescope").extensions.rest.select_env()
    end)
  end,
}
