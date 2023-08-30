local M = {}
function M.config()
	require("fidget").setup({
		window = { blend = 0 },
	})
end

return M
