return {
	"ellisonleao/gruvbox.nvim",
	config = function()
		local colorscheme = "gruvbox"

		local status_ok, _ = pcall(require, colorscheme)

		if not status_ok then
			vim.notify("colorscheme" .. colorscheme .. "not found !")
		end

		-- setup must be called before loading the colorscheme
		-- default options:
		vim.o.background = "dark" -- or "light" for light mode

		-- for copilotsuggestion
		vim.cmd("highlight copilotsuggestion guifg=#555555 ctermfg=8")

		-- default options:
		require("gruvbox").setup({
			terminal_colors = true, -- add neovim terminal colors
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = false,
		})
		vim.cmd("colorscheme gruvbox")
	end,
}
