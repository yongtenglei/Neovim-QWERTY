return {
  "echasnovski/mini.cursorword",
  event = { "BufReadPre", "BufNewFile" },
  version = false,
  config = function()
    local mini_cursorword = require("mini.cursorword")
    mini_cursorword.setup()
  end,
}
