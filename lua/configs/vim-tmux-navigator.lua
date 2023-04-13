local M = {}
function M.config()
	local opts = { noremap = true, silent = true }

	vim.keymap.set("n", "<M-n>", ":<C-U>TmuxNavigateLeft<cr>", opts)
	vim.keymap.set("n", "<M-e>", ":<C-U>TmuxNavigateDown<cr>", opts)
	vim.keymap.set("n", "<M-u>", ":<C-U>TmuxNavigateUp<cr>", opts)
	vim.keymap.set("n", "<M-i>", ":<C-U>TmuxNavigateRight<cr>", opts)
	vim.keymap.set("n", "<M-\\>", ":<C-U>TmuxNavigatePrevious<cr>", opts)
end

return M
