return {
	"echasnovski/mini.splitjoin",
	version = false,
	keys = {
		{ "gS", "<cmd>lua MiniSplitjoin.toggle()<cr>", desc = "Mini Splitjoin" },
	},
	config = function()
		local mini_splitjoin = require("mini.splitjoin")
		mini_splitjoin.setup()
	end,
}
