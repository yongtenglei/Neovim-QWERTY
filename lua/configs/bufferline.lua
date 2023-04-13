local M = {}
function M.config()
	local status, bufferline = pcall(require, "bufferline")
	if not status then
		return
	end

	--按键映射
	--nnoremap <silent> gb :BufferLinePick<CR>
	vim.api.nvim_set_keymap("n", "gb", "<Cmd>BufferLinePick<CR>", { noremap = true, silent = true })

	vim.api.nvim_set_keymap("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true })
	vim.opt.termguicolors = true

	require("bufferline").setup({
		options = {
			number = "none",
			--number_style = "superscript" | "subscript" | "" | { "none", "subscript" }, -- buffer_id at index 1, ordinal at index 2
			--number_style =  "subscript",
			modified_icon = "✥",
			buffer_close_icon = "",
			left_trunc_marker = "",
			right_trunc_marker = "",
			max_name_length = 14,
			max_prefix_length = 13,
			tab_size = 20,
			show_buffer_close_icons = true,
			show_buffer_icons = true,
			show_tab_indicators = true,
			--diagnostics = "coc",
			diagnostics = "nvim_lsp",
			always_show_bufferline = true,
			separator_style = "thin",
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "center",
					padding = 1,
				},
			},
		},
	})
end

return M
