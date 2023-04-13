local M = {}
function M.config()
	--------------------------------nvim-cmp------------------------
	--local capabilities = vim.lsp.protocol.make_client_capabilities()
	--capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- luasnip setup
	local luasnip = require("luasnip")

	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	local types = require("cmp.types")
	local str = require("cmp.utils.str")
	local lspkind = require("lspkind")

	-- nvim-cmp setup
	local cmp = require("cmp")

	local select_opts = { behavior = cmp.SelectBehavior.Select }

	cmp.setup({
		preselect = cmp.PreselectMode.None,
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-u>"] = cmp.mapping.scroll_docs(4),
			["<C-l>"] = cmp.mapping.complete(),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
			["<Up>"] = cmp.mapping.select_prev_item(select_opts),
			["<Down>"] = cmp.mapping.select_next_item(select_opts),
			["<C-n>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.jumpable(1) then
					luasnip.jump(1)
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<C-e>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
			-- super tab GOOD! But I like tab to confirm
			--["<tab>"] = cmp.mapping(function(fallback)
			--if cmp.visible() then
			--cmp.select_next_item()
			--elseif luasnip.expand_or_jumpable() then
			--luasnip.expand_or_jump()
			--elseif has_words_before() then
			--cmp.complete()
			--else
			--fallback()
			--end
			--end, { "i", "s" }),

			--["<S-Tab>"] = cmp.mapping(function(fallback)
			--if cmp.visible() then
			--cmp.select_prev_item()
			--elseif luasnip.jumpable(-1) then
			--luasnip.jump(-1)
			--else
			--fallback()
			--end
			--end, { "i", "s" }),
			--}),

			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
				elseif require("luasnip").expand_or_jumpable() then
					vim.fn.feedkeys(
						vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
						""
					)
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		experimental = {
			ghost_text = false,
		},
		window = {
			--documentation = {
			--border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			--},
			completion = {
				border = "rounded",
				winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
			},
			documentation = {
				border = "rounded",
				winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
			},
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" }, -- For luasnip users.
			{
				name = "buffer",
				option = {
					get_bufnrs = function()
						return vim.api.nvim_list_bufs()
					end,
				},
			},
			{ name = "treesitter" },
			{ name = "calc" },
			{ name = "path" },
			{ name = "nvim_lua" },
			{ name = "spell" },
		}),
		formatting = {
			fields = {
				cmp.ItemField.Abbr,
				cmp.ItemField.Kind,
				cmp.ItemField.Menu,
			},
			format = lspkind.cmp_format({
				mode = "symbol_text",
				maxwidth = 60,
				before = function(entry, vim_item)
					vim_item.menu = ({
						nvim_lsp = "ﲳ",
						nvim_lua = "",
						treesitter = "",
						path = "ﱮ",
						buffer = "﬘",
						zsh = "",
						luasnip = "",
						spell = "",
					})[entry.source.name]

					-- Get the full snippet (and only keep first line)
					local word = entry:get_insert_text()
					if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
						word = vim.lsp.util.parse_snippet(word)
					end
					word = str.oneline(word)
					if
						entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
						and string.sub(vim_item.abbr, -1, -1) == "~"
					then
						word = word .. "~"
					end

					vim_item.abbr = word

					return vim_item
				end,
			}),
		},
		--enable catppuccin integration
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
	})

	local sign = function(opts)
		vim.fn.sign_define(opts.name, {
			texthl = opts.name,
			text = opts.text,
			numhl = "",
		})
	end

	sign({ name = "DiagnosticSignError", text = "✘" })
	sign({ name = "DiagnosticSignWarn", text = "▲" })
	sign({ name = "DiagnosticSignHint", text = "⚑" })
	sign({ name = "DiagnosticSignInfo", text = "" })

	--Another suit of icon
	--sign({ name = "DiagnosticSignError", text = "" })
	--sign({ name = "DiagnosticSignWarn", text = "" })
	--sign({ name = "DiagnosticSignHint", text = "" })
	--sign({ name = "DiagnosticSignInfo", text = "" })

	vim.diagnostic.config({
		virtual_text = false,
		severity_sort = true,
		signs = true,
		update_in_insert = false,
		underline = false,
		float = {
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	})

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

	--------------------------------lspconfig-----------------------
	local lspconfig = require("lspconfig")

	-- Mappings.
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "<space>E", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		vim.keymap.set("n", "B", vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
		vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
		vim.keymap.set("n", "<space>F", function()
			vim.lsp.buf.format({ async = true })
		end, bufopts)
	end

	local lsp_flags = {
		-- This is the default in Nvim 0.7+
		debounce_text_changes = 150,
	}

	local lsp_defaults = lspconfig.util.default_config
	lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, capabilities)

	local servers = {
		"clangd",
		"rust_analyzer",
		"pyright",
		"lua_ls",
		"cmake",
		"cssls",
		"dockerls",
		"gopls",
		"html",
		"jsonls",
		"sqlls",
		"volar",
		"yamlls",
		"quick_lint_js",
	}
	for _, lsp in pairs(servers) do
		lspconfig[lsp].setup({
			on_attach = on_attach,
			flags = lsp_flags,
		})
	end
end

return M
