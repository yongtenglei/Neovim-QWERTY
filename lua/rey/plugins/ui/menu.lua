return {
  { "nvchad/volt", lazy = true },
  {
    "nvchad/menu",
    lazy = true,
    keys = {
      -- Keyboard users
      {
        "<C-t>",
        function()
          require("menu").open("default")
        end,
        mode = "n",
      },

      -- Mouse users + nvimtree users
      {
        "<RightMouse>",
        function()
          vim.cmd.exec('"normal! \\<RightMouse>"')
          local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
          require("menu").open(options, { mouse = true })
        end,
        mode = "n",
      },
    },
  },
}
