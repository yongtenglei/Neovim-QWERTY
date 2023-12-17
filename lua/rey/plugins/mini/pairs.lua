return {
  "echasnovski/mini.pairs",
  version = false,
  event = "InsertEnter",
  config = function()
    local mini_pairs = require("mini.pairs")
    mini_pairs.setup()
  end,
}
