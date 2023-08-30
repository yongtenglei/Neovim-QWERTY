return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	config = function()
		require("fidget").setup({
			window = { blend = 0 },
		})
	end,
	-- to avoid break changes
	tag = "legacy",
}
