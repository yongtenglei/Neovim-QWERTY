return {
  "echasnovski/mini.map",
  version = false,
  config = function()
    local mini_map = require("mini.map")
    mini_map.setup()

    -- open map automatically
    mini_map.open()

    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>mm", "<cmd>lua MiniMap.toggle()<cr>", opts)
  end,
}
