local M = {}
function M.config()
  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {},
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = {
        {
          "filename",
          file_status = true,
          path = 3,
          symbols = {
            modified = "[+]", -- Text to show when the file is modified.
            readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
            unnamed = "[No Name]", -- Text to show for unnamed buffers.
            newfile = "[New]", -- Text to show for new created file before first writting
          },
        },
      },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    --tabline = {
    --lualine_a = {},
    --lualine_b = {},
    --lualine_c = { require'tabline'.tabline_buffers },
    --lualine_x = { require'tabline'.tabline_tabs },
    --lualine_y = {},
    --lualine_z = {},
    --},
    extensions = { "fzf", "quickfix", "nvim-tree", "nvim-dap-ui", "aerial" },
  })
end

return M
