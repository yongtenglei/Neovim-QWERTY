return {
  {
    "saghen/blink.cmp",
    event = "VimEnter",
    version = "1.*",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        build = (function()
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        },
        opts = {},
      },
      { "folke/lazydev.nvim" },
      { "moyiz/blink-emoji.nvim" },
      {
        "samiulsami/cmp-go-deep",
        dependencies = { "kkharji/sqlite.lua" },
      },
      {
        "edte/blink-go-import.nvim",
        ft = "go",
        config = function()
          require("blink-go-import").setup()
        end,
      },
      { "saghen/blink.compat" },
      { "onsails/lspkind.nvim" },
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
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
        trigger = { show_in_snippet = true },
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
                  local icon = ctx.kind_icon
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      icon = dev_icon
                    end
                  else
                    icon = require("lspkind").symbolic(ctx.kind, {
                      mode = "symbol",
                    })
                  end

                  return icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  local hl = ctx.kind_hl
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      hl = dev_hl
                    end
                  end
                  return hl
                end,
              },
              kind = {

                highlight = function(ctx)
                  local hl = ctx.kind_hl
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      hl = dev_hl
                    end
                  end
                  return hl
                end,
              },
            },
          },
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer", "lazydev", "emoji", "go_deep", "go_pkgs" },
        providers = {
          lazydev = {
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
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
          go_deep = {
            name = "go_deep",
            module = "blink.compat.source",
            min_keyword_length = 3,
            max_items = 5,
            ---@module "cmp_go_deep"
            ---@type cmp_go_deep.Options
            opts = {
              -- Enable/disable notifications.
              notifications = true,

              -- How to get documentation for Go symbols.
              -- options:
              -- "hover" - LSP 'textDocument/hover'. Prettier.
              -- "regex" - faster and simpler.
              get_documentation_implementation = "hover",

              -- How to get the package names.
              -- options:
              -- "treesitter" - accurate but slower.
              -- "regex" - faster but can fail in edge cases.
              get_package_name_implementation = "regex",

              -- Whether to exclude vendored packages from completions.
              exclude_vendored_packages = false,

              -- Timeout in milliseconds for fetching documentation.
              -- Controls how long to wait for documentation to load.
              documentation_wait_timeout_ms = 100,

              -- Maximum time (in milliseconds) to wait before "locking-in" the current request and sending it to gopls.
              debounce_gopls_requests_ms = 250,

              -- Maximum time (in milliseconds) to wait before "locking-in" the current request and loading data from cache.
              debounce_cache_requests_ms = 50,

              -- Path to store the SQLite database
              -- Default: "~/.local/share/nvim/cmp_go_deep.sqlite3"
              db_path = vim.fn.stdpath("data") .. "/cmp_go_deep.sqlite3",

              -- Maximum size for the SQLite database in bytes.
              db_size_limit_bytes = 200 * 1024 * 1024, -- 200MB
            },
          },
          go_pkgs = {
            module = "blink-go-import",
            name = "Import",
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
  },
}
