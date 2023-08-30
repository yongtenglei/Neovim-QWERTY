return {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",
	config = function()
		local luasnip_loader = require("luasnip.loaders.from_vscode")
		luasnip_loader.lazy_load()
		luasnip_loader.lazy_load({ paths = { "~/.config/nvim/snippets/" } })
		--require("luasnip.loaders.from_vscode").lazy_load({paths = {"~/.config/nvim/snippets/"}})

		--local keymap = vim.api.nvim_set_keymap
		--local opts = { noremap = true, silent = true }
		--keymap("i", "<c-n>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
		--keymap("s", "<c-n>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
		--keymap("i", "<c-e>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
		--keymap("s", "<c-e>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

		local luasnip = require("luasnip")
		luasnip.config.setup({
			region_check_events = "CursorHold,InsertLeave,InsertEnter",
			delete_check_events = "TextChanged,InsertEnter",
		})
	end,
	dependencies = {
		{ "rafamadriz/friendly-snippets" },
	},
}
