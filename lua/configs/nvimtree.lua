-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "tt", ":NvimTreeToggle<cr>", { noremap = true, silent = true })

-- nvim-tree is also there in modified buffers so this function filter it out
local modifiedBufs = function(bufs)
  local t = 0
  for k, v in pairs(bufs) do
    if v.name:match("NvimTree_") == nil then
      t = t + 1
    end
  end
  return t
end

vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1
        and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil
        and modifiedBufs(vim.fn.getbufinfo({ bufmodified = 1 })) == 0
    then
      vim.cmd("quit")
    end
  end,
})

local M = {}
function M.config()
  require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
      adaptive_size = true,
      mappings = {
        list = {
          { key = { "<CR>", "i", "<2-LeftMouse>" }, action = "edit" },
          { key = "<C-e>", action = "edit_in_place" },
          { key = "O", action = "edit_no_picker" },
          { key = { "<C-]>", "<2-RightMouse>" }, action = "cd" },
          { key = "<C-v>", action = "vsplit" },
          { key = "<C-x>", action = "split" },
          { key = "<C-t>", action = "tabnew" },
          { key = "<", action = "prev_sibling" },
          { key = ">", action = "next_sibling" },
          { key = "P", action = "parent_node" },
          { key = { "<Esc>", "n" }, action = "close_node" },
          { key = "<Tab>", action = "preview" },
          { key = "K", action = "first_sibling" },
          { key = "J", action = "last_sibling" },
          { key = "I", action = "toggle_git_ignored" },
          { key = "H", action = "toggle_dotfiles" },
          { key = "U", action = "toggle_custom" },
          { key = "R", action = "refresh" },
          { key = "a", action = "create" },
          { key = "d", action = "remove" },
          { key = "D", action = "trash" },
          { key = "r", action = "rename" },
          { key = "<C-r>", action = "full_rename" },
          { key = "x", action = "cut" },
          { key = "c", action = "copy" },
          { key = "p", action = "paste" },
          { key = "y", action = "copy_name" },
          { key = "Y", action = "copy_path" },
          { key = "gy", action = "copy_absolute_path" },
          { key = "[e", action = "prev_diag_item" },
          { key = "[c", action = "prev_git_item" },
          { key = "]e", action = "next_diag_item" },
          { key = "]c", action = "next_git_item" },
          { key = "n", action = "dir_up" },
          { key = "s", action = "system_open" },
          { key = "f", action = "live_filter" },
          { key = "F", action = "clear_live_filter" },
          { key = "q", action = "close" },
          { key = "W", action = "collapse_all" },
          { key = "E", action = "expand_all" },
          { key = "S", action = "search_node" },
          { key = ".", action = "run_file_command" },
          { key = "<C-k>", action = "toggle_file_info" },
          { key = "g?", action = "toggle_help" },
          { key = "m", action = "toggle_mark" },
          { key = "bmv", action = "bulk_move" },
        },
      },
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },
  })
end

return M
