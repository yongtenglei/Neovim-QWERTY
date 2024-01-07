local function opts(desc)
  return { desc = desc, noremap = true, silent = true, nowait = true }
end

-- Rust Crates
vim.keymap.set("n", "<leader>Co", "<cmd>lua require('crates').show_popup()<CR>", opts("Show popup"))
vim.keymap.set("n", "<leader>Cr", "<cmd>lua require('crates').reload()<CR>", opts("Reload"))
vim.keymap.set("n", "<leader>Cv", "<cmd>lua require('crates').show_versions_popup()<CR>", opts("Show Versions"))
vim.keymap.set("n", "<leader>Cf", "<cmd>lua require('crates').show_features_popup()<CR>", opts("Show Features"))
vim.keymap.set(
  "n",
  "<leader>Cd",
  "<cmd>lua require('crates').show_dependencies_popup()<CR>",
  opts("Show Dependencies Popup")
)
vim.keymap.set("n", "<leader>Cu", "<cmd>lua require('crates').update_crate()<CR>", opts("Update Crate"))
vim.keymap.set("n", "<leader>Ca", "<cmd>lua require('crates').update_all_crates()<CR>", opts("Update All Crates"))
vim.keymap.set("n", "<leader>CU", "<cmd>lua require('crates').upgrade_crate<CR>", opts("Upgrade Crate"))
vim.keymap.set("n", "<leader>CA", "<cmd>lua require('crates').upgrade_all_crates(true)<CR>", opts("Upgrade All Crates"))
vim.keymap.set("n", "<leader>CH", "<cmd>lua require('crates').open_homepage()<CR>", opts("Open Homepage"))
vim.keymap.set("n", "<leader>CR", "<cmd>lua require('crates').open_repository()<CR>", opts("Open Repository"))
vim.keymap.set("n", "<leader>CD", "<cmd>lua require('crates').open_documentation()<CR>", opts("Open Documentation"))
vim.keymap.set("n", "<leader>CC", "<cmd>lua require('crates').open_crates_io()<CR>", opts("Open Crate.io"))

-- Rust LSP
vim.keymap.set("n", "<leader>La", "<cmd>lua vim.cmd.RustLsp('codeAction')<cr>", opts("Rust Code Action"))
vim.keymap.set("n", "<leader>Ld", "<cmd>lua vim.lsp.buf.definition()<cr>", opts("Definition"))
vim.keymap.set("n", "<leader>LD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts("Declaration"))
vim.keymap.set("n", "<leader>Li", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts("Implementation"))
vim.keymap.set("n", "<leader>Lo", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts("Type Definition"))
vim.keymap.set("n", "<leader>LR", "<cmd>Telescope lsp_references<cr>", opts("References"))
vim.keymap.set("n", "<leader>Ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts("Display Signature Information"))
vim.keymap.set("n", "<leader>Lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts("Rename all references"))
vim.keymap.set("n", "<leader>Lf", "<cmd>lua vim.lsp.buf.format()<cr>", opts("Format"))
vim.keymap.set("n", "<leader>Lk", "<cmd>lua vim.cmd.RustLsp { 'hover' 'actions' }<cr>", opts("Hover"))
vim.keymap.set("n", "<leader>Ll", "<cmd>TroubleToggle document_diagnostics<cr>", opts("Document Diagnostics (Trouble)"))
vim.keymap.set("n", "<leader>Lw", "<cmd>Telescope diagnostics<cr>", opts("Diagnostics"))
vim.keymap.set(
  "n",
  "<leader>LL",
  "<cmd>TroubleToggle workspace_diagnostics<cr>",
  opts("Workspace Diagnostics (Trouble)")
)
vim.keymap.set(
  "n",
  "<leader>Lc",
  "<cmd>lua require('config.utils').copyFilePathAndLineNumber()<CR>",
  opts("Copy File Path and Line Number")
)
vim.keymap.set("n", "B", "<cmd>RustLsp hover actions<CR>", opts("Rust Hover"))
vim.keymap.set("n", "LE", "<cmd>RustLsp explainError<CR>", opts("Explain error"))
