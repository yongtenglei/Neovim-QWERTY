return {
  "tamton-aquib/duck.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<leader>dd", "<cmd>lua require('duck').hatch('🐙')<cr>", desc = "Duck hatch" },
    { "<leader>dk", "<cmd>lua require('duck').cook()<cr>", desc = "Duck cook" },
  },

  --config = function()
  ---- 🦆 ඞ 🦀 🐈 🐎 🦖 🐤 🐙
  --vim.keymap.set("n", "<leader>dd", function()
  --require("duck").hatch("🐙")
  --end, {})

  --vim.keymap.set("n", "<leader>dk", function()
  --require("duck").cook()
  --end, {})
  --end,
}
