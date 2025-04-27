return {
  -- Important: execute
  -- :GoInstallBinaries
  "fatih/vim-go",
  build = ":GoInstallBinaries",
  ft = { "go" },
  init = function()
    vim.g.go_doc_keywordprg_enabled = 0
  end,
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "go",
      callback = function()
        vim.cmd([[let g:go_doc_keywordprg_enabled = 0]])
        -- vim.g.go_doc_keywordprg_enabled = 0

        local opts = { noremap = true, buffer = true }
        vim.keymap.set("n", "<leader>r", "<Plug>(go-run)", opts)
        vim.keymap.set("n", "<leader>t", "<Plug>(go-test)", opts)
        vim.keymap.set("n", "<leader>c", "<Plug>(go-coverage-toggle)", opts)
        vim.keymap.set("n", "<leader>a", "<Plug>(go-alternate-edit)", opts)

        -- Function to run :GoBuild or :GoTestCompile
        local function build_go_files()
          local file = vim.fn.expand("%")
          if file:match("^.+_test%.go$") then
            vim.fn["go#test#Test"](0, 1)
          elseif file:match("^.+%.go$") then
            vim.fn["go#cmd#Build"](0)
          end
        end

        -- Keybinding for build
        vim.keymap.set("n", "<leader>b", build_go_files, opts)
      end,
    })

    -- Set buffer-local options for Go files
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
      pattern = "*.go",
      callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
      end,
    })
  end,
}
