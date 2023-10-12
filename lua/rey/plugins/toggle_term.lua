return {
	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = function(term)
					if term.direction == "float" then
						return 20
					elseif term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					else
						return 20
					end
				end,
				open_mapping = [[<c-\>]],
				hide_numbers = true,
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				insert_mappings = true,
				persist_size = true,
				persist_mode = true,
				direction = "float", --   close_on_exit = true,"vertical" | "horizontal" | "tab" | "float",
				close_on_exit = true,
				shell = vim.o.shell,
				float_opts = {
					border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' |
					winblend = 3,
				},
			})

			-- Custom terminal function
			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

			function _LAZYGIT_TOGGLE()
				lazygit:toggle()
			end

			vim.api.nvim_set_keymap(
				"n",
				"<leader>g",
				"<cmd>lua _LAZYGIT_TOGGLE()<CR>",
				{ noremap = true, silent = true }
			)
		end,
	},
}
