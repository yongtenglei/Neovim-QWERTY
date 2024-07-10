return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local status_ok, gitsigns = pcall(require, "gitsigns")
    if not status_ok then
      return
    end

    gitsigns.setup({})
  end,
}
