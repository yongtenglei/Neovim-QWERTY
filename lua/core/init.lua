require("core.settings")
require("core.keymaps")

require("core.plugins")

if vim.g.neovide then
	require("configs.neovide")
end
