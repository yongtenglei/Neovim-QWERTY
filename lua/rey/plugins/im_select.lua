return {
  -- should install im-select first, see
  -- https://github.com/daipeihust/im-select
  "keaising/im-select.nvim",
  config = function()
    require("im_select").setup({})
  end,
}
