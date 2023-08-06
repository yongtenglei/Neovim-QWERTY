local colorscheme = "solarized"

local status_ok, _ = pcall(require, colorscheme)

if not status_ok then
  vim.notify("colorscheme" .. colorscheme .. "not found !")
end

-- for CopilotSuggestion
vim.cmd("highlight CopilotSuggestion guifg=#555555 ctermfg=8")

local M = {}
function M.config()
  -- Example config in lua
  vim.g.solarized_italic_comments = true
  vim.g.solarized_italic_keywords = true
  vim.g.solarized_italic_functions = true
  vim.g.solarized_italic_variables = false
  vim.g.solarized_contrast = true
  vim.g.solarized_borders = false
  vim.g.solarized_disable_background = false

  -- Load the colorscheme
  require("solarized").set()
end

return M
