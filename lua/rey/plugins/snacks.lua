return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      statuscolumn = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      bufdelete = { enabled = true },
      lazygit = { enabled = true },
      zen = { enabled = true },

      git = { enabled = false },
      gitbrowse = { enabled = false },
      image = { enabled = false },
      notify = { enabled = false },
      rename = { enabled = false },
      scratch = { enabled = false },
      toggle = { enabled = false },
      util = { enabled = false },
      win = { enabled = false },
      layout = { enabled = false },
      animate = { enabled = false },
      debug = { enabled = false },
      scroll = { enabled = false },
      indent = { enabled = false },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      picker = { enabled = false },
      quickfile = { enabled = false },
      scope = { enabled = false },
      words = { enabled = false },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        },
      },
    },
    keys = {
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>zm",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },
      {
        "<leader>bd",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
    },
  },
}
