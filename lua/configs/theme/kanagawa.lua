local colorscheme = "kanagawa"

local status_ok, _ = pcall(require, colorscheme)

if not status_ok then
	vim.notify("colorscheme" .. colorscheme .. "not found !")
end

-- setup must be called before loading the colorscheme
-- Default options:
vim.o.background = "dark" -- or "light" for light mode

-- for CopilotSuggestion
vim.cmd("highlight CopilotSuggestion guifg=#555555 ctermfg=8")

-- Global Statusline. Note: it works really nice with dimInactive = true
vim.opt.laststatus = 3
vim.opt.fillchars:append({
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┨",
	vertright = "┣",
	verthoriz = "╋",
})

local M = {}
function M.config()
	-- Default options:
	require("kanagawa").setup({
		undercurl = true, -- enable undercurls
		commentStyle = { italic = true },
		functionStyle = {},
		keywordStyle = { italic = true },
		statementStyle = { bold = true },
		typeStyle = {},
		variablebuiltinStyle = { italic = true },
		specialReturn = true, -- special highlight for the return keyword
		specialException = true, -- special highlight for exception handling keywords
		transparent = true, -- do not set background color
		dimInactive = true, -- dim inactive window `:h hl-NormalNC`
		globalStatus = true, -- adjust window separators highlight for laststatus=3
		terminalColors = true, -- define vim.g.terminal_color_{0,17}
		colors = {},
		overrides = {},
		theme = "default", -- Load "default" theme or the experimental "light" theme
	})
end

vim.cmd("colorscheme kanagawa")

return M
