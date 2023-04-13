local colorscheme = "gruvbox"

local status_ok, _ = pcall(require, colorscheme)

if not status_ok then
	vim.notify("colorscheme" .. colorscheme .. "not found !")
end

-- setup must be called before loading the colorscheme
-- Default options:
vim.o.background = "dark" -- or "light" for light mode

-- for CopilotSuggestion
vim.cmd("highlight CopilotSuggestion guifg=#555555 ctermfg=8")

local M = {}
function M.config()
	require("gruvbox").setup({
		undercurl = true,
		underline = true,
		bold = true,
		italic = true,
		strikethrough = true,
		invert_selection = false,
		invert_signs = false,
		invert_tabline = false,
		invert_intend_guides = false,
		inverse = true, -- invert background for search, diffs, statuslines and errors
		contrast = "", -- can be "hard", "soft" or empty string
		overrides = {},
	})
end

vim.cmd("colorscheme gruvbox")

return M
