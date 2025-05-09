return {
  "saghen/blink.cmp",
  dependencies = {
    { "rafamadriz/friendly-snippets" },
    {
      "echasnovski/mini.icons",
      config = function()
        require("mini.icons").mock_nvim_web_devicons()
      end,
      opts = {},
    },
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
    },
    { "moyiz/blink-emoji.nvim" },
  },

  version = "1.*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "none",

      ["<C-l>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-n>"] = { "select_next", "snippet_forward", "fallback_to_mappings" },
      ["<C-p>"] = { "select_prev", "snippet_backward", "fallback_to_mappings" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

      ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      trigger = { show_in_snippet = false },
      keyword = { range = "full" },
      accept = { auto_brackets = { enabled = true } },
      documentation = {
        window = {
          border = "rounded",
        },
        auto_show = true,
      },
      ghost_text = { enabled = true },
      menu = {
        border = "rounded",
        draw = {
          -- padding = { 0, 1 },
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "kind" },
          },
          components = {
            kind_icon = {
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,

              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
            kind = {
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
        },
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer", "emoji" },
      providers = {
        emoji = {
          module = "blink-emoji",
          name = "Emoji",
          score_offset = 15,
          opts = { insert = true },
          -- Enable emoji completion only for git commits and markdown.
          -- By default, enabled for all file-types.
          -- should_show_items = function()
          --   return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
          -- end,
        },
      },
    },

    snippets = { preset = "luasnip" },

    signature = {
      window = { border = "rounded" },
      enabled = true,
    },

    -- or "lua"
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
