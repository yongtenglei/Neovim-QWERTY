return {
  {
    "echasnovski/mini.map",
    version = false,
    config = function()
      local mini_map = require("mini.map")

      mini_map.setup()

      mini_map.open()

      local opts = { noremap = true, silent = true, desc = "Toggle Mini.Map" }
      vim.keymap.set("n", "<leader>mm", "<cmd>lua MiniMap.toggle()<cr>", opts)
    end,
  },
  {
    "echasnovski/mini.pairs",
    version = false,
    config = function()
      local mini_pairs = require("mini.pairs")
      mini_pairs.setup()
    end,
  },
  {
    "echasnovski/mini.splitjoin",
    version = false,
    keys = {
      { "gS", "<cmd>lua MiniSplitjoin.toggle()<cr>", desc = "Mini Splitjoin" },
    },
    config = function()
      local mini_splitjoin = require("mini.splitjoin")
      mini_splitjoin.setup()
    end,
  },
}
