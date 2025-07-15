return {
  {
    "neolooong/whichpy.nvim",
    dependencies = {
      { "mfussenegger/nvim-dap-python" },
      { "nvim-telescope/telescope.nvim" },
    },
    ft = "python",
    keys = {
      { "<leader>fP", mode = { "n" }, ":WhichPy select<cr>", desc = "[F]ind Python ENV" },
    },
    opts = {
      picker = {
        name = "telescope", -- "builtin", "fzf-lua", "telescope"
        telescope = {
          prompt_title = "I 🤟 Python",
        },
        -- builtin = {
        --   prompt = "vim.ui.select",
        -- },
      },
    },
  },
}
