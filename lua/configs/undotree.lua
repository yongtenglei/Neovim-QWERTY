local M = {}
function M.config()
	vim.keymap.set("n", "<leader>U", ":UndotreeToggle<cr>")
end

return M
