return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local status_ok, gitsigns = pcall(require, "gitsigns")
    if not status_ok then
      return
    end

    gitsigns.setup({
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
        delay = 500,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    })
  end,
}
