-- install the tools
-- :MasonInstall gopls golangci-lint-langserver delve goimports gofumpt gomodifytags gotests impl
-- also
-- :GoInstallDeps
local M = {}
function M.config()
	require("dap-go").setup()

	require("gopher").setup({
		commands = {
			go = "go",
			gomodifytags = "gomodifytags",
			gotests = "~/go/bin/gotests", -- also you can set custom command path
			impl = "impl",
			iferr = "iferr",
		},
	})
end

return M
