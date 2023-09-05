return {
	"echasnovski/mini.files",
	version = false,
	keys = {
		{ "<leader>mf", "<cmd>lua MiniFiles.open()<cr>", desc = "Mini files" },
	},
	config = function()
		local mini_files = require("mini.files")
		mini_files.setup()
	end,
}
