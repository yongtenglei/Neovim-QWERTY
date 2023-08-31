return {
	"Shatur/neovim-ayu",
	config = function()
		local colorscheme = "ayu"

		local status_ok, _ = pcall(require, colorscheme)

		if not status_ok then
			vim.notify("colorscheme" .. colorscheme .. "not found !")
		end

		-- setup must be called before loading the colorscheme
		-- Default options:
		--vim.o.background = "dark" -- or "light" for light mode
		vim.o.background = "light" -- or "dark" for dark mode

		-- for CopilotSuggestion
		vim.cmd("highlight CopilotSuggestion guifg=#555555 ctermfg=8")

		require("ayu").setup({
			mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
			overrides = {}, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
		})

		-- options: ayu-dark ayu-light ayu-mirage
		vim.cmd("colorscheme ayu-light")
	end,
}
