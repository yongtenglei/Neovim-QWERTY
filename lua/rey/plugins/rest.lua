return {
  "rest-nvim/rest.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "http")
    end,
  },
  config = function()
    require("telescope").load_extension("rest")
    vim.keymap.set("n", "<leader>rr", ":Rest run <CR>")
    vim.keymap.set("n", "<leader>re", function()
      require("telescope").extensions.rest.select_env()
    end)
  end,
}
