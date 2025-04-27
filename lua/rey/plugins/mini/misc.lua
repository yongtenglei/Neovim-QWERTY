return {
  "echasnovski/mini.misc",
  version = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local mini_misc = require("mini.misc")
    mini_misc.setup()
  end,
}
