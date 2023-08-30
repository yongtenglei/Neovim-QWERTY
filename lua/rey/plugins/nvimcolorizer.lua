return {
	"norcalli/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- Use the `default_options` as the second parameter, which uses
		-- `foreground` for every mode. This is the inverse of the previous
		-- setup configuration.
		require("colorizer").setup({
			"*", -- Highlight all files, but customize some others.
			css = { css = true }, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
			vue = { css = true }, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
		}, { mode = "foreground" })
	end,
}
