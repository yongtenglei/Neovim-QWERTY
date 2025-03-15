return {
  "echasnovski/mini.surround",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local mini_surround = require("mini.surround")
    mini_surround.setup()
  end,
}
