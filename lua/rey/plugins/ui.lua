return {
  {
    "mvllow/modes.nvim",
    config = function()
      require("modes").setup({
        colors = {
          bg = "",
          copy = "#f5c359",
          delete = "#c75c6a",
          change = "#c75c6a",
          format = "#c79585",
          insert = "#78ccc5",
          replace = "#245361",
          visual = "#9745be",
        },

        -- Set opacity for cursorline and number background
        line_opacity = 0.45,

        -- Enable cursor highlights
        set_cursor = true,

        -- Enable cursorline initially, and disable cursorline for inactive windows
        -- or ignored filetypes
        set_cursorline = true,

        -- Enable line number highlights to match cursorline
        set_number = true,

        -- Enable sign column highlights to match cursorline
        set_signcolumn = true,

        -- Disable modes highlights for specified filetypes
        -- or enable with prefix "!" if otherwise disabled (please PR common patterns)
        -- Can also be a function fun():boolean that disables modes highlights when true
        ignore = { "NvimTree", "TelescopePrompt", "!minifiles" },
      })
    end,
  },
  {
    "Wansmer/symbol-usage.nvim",
    config = function()
      local function h(name)
        return vim.api.nvim_get_hl(0, { name = name })
      end

      -- hl-groups can have any name
      vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = h("CursorLine").bg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageContent", { bg = h("CursorLine").bg, fg = h("Comment").fg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = h("Function").fg, bg = h("CursorLine").bg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = h("Type").fg, bg = h("CursorLine").bg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = h("@keyword").fg, bg = h("CursorLine").bg, italic = true })

      local function text_format(symbol)
        local fragments = {}

        -- Indicator that shows if there are any other symbols in the same line
        local stacked_functions = symbol.stacked_count > 0 and (" | +%s"):format(symbol.stacked_count) or ""

        if symbol.references then
          local usage = symbol.references <= 1 and "usage" or "usages"
          local num = symbol.references == 0 and "no" or symbol.references
          table.insert(fragments, ("%s %s"):format(num, usage))
        end

        if symbol.definition then
          table.insert(fragments, symbol.definition .. " defs")
        end

        if symbol.implementation then
          table.insert(fragments, symbol.implementation .. " impls")
        end

        return table.concat(fragments, ", ") .. stacked_functions
      end

      require("symbol-usage").setup({
        text_format = text_format,
      })

      local function bubble_text_format(symbol)
        local res = {}

        local round_start = { "", "SymbolUsageRounding" }
        local round_end = { "", "SymbolUsageRounding" }

        -- Indicator that shows if there are any other symbols in the same line
        local stacked_functions_content = symbol.stacked_count > 0 and ("+%s"):format(symbol.stacked_count) or ""

        if symbol.references then
          local usage = symbol.references <= 1 and "usage" or "usages"
          local num = symbol.references == 0 and "no" or symbol.references
          table.insert(res, round_start)
          table.insert(res, { "󰌹 ", "SymbolUsageRef" })
          table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
          table.insert(res, round_end)
        end

        if symbol.definition then
          if #res > 0 then
            table.insert(res, { " ", "NonText" })
          end
          table.insert(res, round_start)
          table.insert(res, { "󰳽 ", "SymbolUsageDef" })
          table.insert(res, { symbol.definition .. " defs", "SymbolUsageContent" })
          table.insert(res, round_end)
        end

        if symbol.implementation then
          if #res > 0 then
            table.insert(res, { " ", "NonText" })
          end
          table.insert(res, round_start)
          table.insert(res, { "󰡱 ", "SymbolUsageImpl" })
          table.insert(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
          table.insert(res, round_end)
        end

        if stacked_functions_content ~= "" then
          if #res > 0 then
            table.insert(res, { " ", "NonText" })
          end
          table.insert(res, round_start)
          table.insert(res, { " ", "SymbolUsageImpl" })
          table.insert(res, { stacked_functions_content, "SymbolUsageContent" })
          table.insert(res, round_end)
        end

        return res
      end

      require("symbol-usage").setup({
        text_format = text_format,
        -- text_format = bubble_text_format,
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          -- component_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
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
              component_separators = {},
              section_separators = {},
              symbols = {
                modified = "[+]",
                readonly = "[-]",
                unnamed = "[No Name]",
                newfile = "[New]",
              },
            },
          },
          lualine_x = {
            {
              "harpoon2",
              icon = "⚓:",
              indicators = { "🦡", "🦎", "🐋", "🐲" },
              active_indicators = { "[🦨]", "[🦖]", "[🐳]", "[🐉]" },
              color_active = {},
              _separator = " ♥ ",
              no_harpoon = "⚓",
            },
            "%=",
            "whichpy",
            "encoding",
            "fileformat",
            "filetype",
          },
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
        extensions = { "oil", "quickfix", "nvim-tree", "nvim-dap-ui", "aerial", "mason", "toggleterm" },
      })
    end,
  },
  {
    "letieu/harpoon-lualine",
    dependencies = {
      {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
      local status, _ = pcall(require, "bufferline")
      if not status then
        return
      end

      vim.api.nvim_set_keymap("n", "gb", "<Cmd>BufferLinePick<CR>", { noremap = true, silent = true })
      vim.opt.termguicolors = true

      require("bufferline").setup({
        options = {
          number = "none",
          --number_style = "superscript" | "subscript" | "" | { "none", "subscript" }, -- buffer_id at index 1, ordinal at index 2
          --number_style =  "subscript",
          modified_icon = "✥",
          buffer_close_icon = "󰅖",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 14,
          max_prefix_length = 13,
          tab_size = 20,
          show_buffer_close_icons = true,
          show_buffer_icons = true,
          show_tab_indicators = true,
          --diagnostics = "coc",
          diagnostics = "nvim_lsp",
          always_show_bufferline = true,
          separator_style = "thin",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              padding = 1,
            },
          },
        },
      })
    end,
  },
  {
    "goolord/alpha-nvim",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Set menu
      dashboard.section.buttons.val = {
        dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", "  Recently used files", ":Telescope oldfiles<CR>"),
        dashboard.button("f", " Find file", ":Telescope find_files<CR>"),
        dashboard.button("t", " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("s", "  Settings", ":e $HOME/.config/nvim/init.lua | :cd %:p:h | split . | wincmd k | pwd<CR>"),
        dashboard.button("q", " Quit NVIM", ":qa<CR>"),
      }

      -- Set footer
      local handle = assert(io.popen("fortune -s"))
      local fortune = handle:read("*all")
      handle:close()
      dashboard.section.footer.val = fortune
      dashboard.section.header.opts.hl = "Title"
      dashboard.section.buttons.opts.hl = "Debug"
      dashboard.section.footer.opts.hl = "Conceal"
      dashboard.config.opts.noautocmd = true

      -- vim.cmd[[autocmd User AlphaReady echo 'ready']]

      alpha.setup(dashboard.opts)

      dashboard.section.header.val = {
        [[ ...............',,........,;;'............... ]],
        [[ ...............,,','......,'','.............. ]],
        [[ ...............,'..','....,,.',.............. ]],
        [[ ...............,'...',;,..',..,,............. ]],
        [[ ...............,'.....',,.',...,'............ ]],
        [[ ...............,'.......,,,'...,,............ ]],
        [[ ...............,'.......':;....,,............ ]],
        [[ ...............,,........;;....,,............ ]],
        [[ ................,'.............,;............ ]],
        [[ .................,,'............',,.......... ]],
        [[ ..................,'..............,,......... ]],
        [[ ................','................,'........ ]],
        [[ ..............',,'.................,,........ ]],
        [[ ...........'','....................,,........ ]],
        [[ .........','.......................';........ ]],
        [[ ........,,'........................,,........ ]],
        [[ .......,'........................,,'......... ]],
        [[ ......,,........................';'.......... ]],
        [[ ......,'.........................,;'......... ]],
        [[ ......,'..........................','........ ]],
        [[ ......,'...........................','....... ]],
        [[ ......,'............................',....... ]],
        [[ ......',.............................,'...... ]],
        [[ .......,'............................',...... ]],
        [[ .......',............................',...... ]],
        [[ ........',...........................,,...... ]],
        [[ .........,,..........................,'...... ]],
        [[ ..........,,........................,'....... ]],
        [[ ..........,;...........'',;'......',,........ ]],
        [[ ..........;,...',,'.',,,',;,.'.'',,.......... ]],
        [[ ..........',''''',,'''....''','''............ ]],
        [[ ............................................. ]],
      }

      --dashboard.section.header.val = {
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWKOOOXMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMWK00KNNK00OOO0OOOOO0OkO0xOMMMMMMMMMMMMMMM ]]
      --[[ MMMMWX0O0XWMMWXK00XXOkxdxOOO0KKKXXKK0kddoldOXMMMMMMMMMMMMMMM ]]
      --[[ MMMXxc;;;cx00dc;;;:dOxokKXXXXXXXXXXXXKkddllkXWMMMMMMMMMMMMMM ]]
      --[[ MMWx;,,,,,;::;,;,,,;loxOkOKXXXXXXXXKkk0XNNXOxxXMMMMMMMMMMMMM ]]
      --[[ MMNx;,,,,,,,,,,,,,,,l0KK0kdxKXXXXNKxkkxKWMMWNkdKMMMMMMMMMMMM ]]
      --[[ MMW0c,,,,,,,,,,,,,,;ckNMMMNxdKNNXNOxOc.dWMMMWXdkWMMMMMMMMMMM ]]
      --[[ MMMWKo;,,,,,,,,,,,:lcxNMMMMXodX0O0OxKXKNMMMMWXxOMMMMMMMMMMMM ]]
      --[[ MMMMWXx:,,,,,,,,,:kNWMMMMMMNocooodxdONWMMMMMNxdXMMMMMMMMMMMM ]]
      --[[ MMMMMMW0o;,,,,,:lxXWMMMMMMNkokOkdx0KOkOKXKKOdcdXMMMMMMMMMMMM ]]
      --[[ MMMMMMMMNOc;,;cdOxxOKXNXKOdd0XNXKXNXNKOkkkxdxxokXNMMMMMMMMMM ]]
      --[[ MMMMMMMMMWXxoO0OkOxoxkkkxxOXXXXXXXXXXXXNNNNKOxld0OOKWMMMMMMM ]]
      --[[ MMMMMMMMMMMWWWMWNKko0NNNNNXXXXXXXXXXXXXXXXXX0kloOOkxKMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMNxkNXXXXXXXXXXXXXXXXXXXXXX0koxKKKXWMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMkdKNXXXXXXXXXXXXXXXXXXXXX0xo0MMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMXxxKXXXXXXXXXXXXXXXXXXXX0OddXMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMNkd0XXXXXXXXXXXXXXXXXX0Oxo0WMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMWKxx0XXXXXXXXXXXXXXKOkdd0WMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMWOoxkO0KKXXXXK0kxdolkNMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMKxOkoxOOOOOOkkxokkxXMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMNkxOKWMMMMMMMMWOxxOWMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMWXNMMMMMMMMMMMNKXWMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --}

      --dashboard.section.header.val = {

      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0dONMMMWKONMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0xdOMMM0dlkWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXOoxNMNkkdxWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXdxNMKdcoKMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNNWMNkkNMMMWXKNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWOddxx0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNkokOxlkWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXdoddd0NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNOxxONMMMMWNKK0OOkkxxxkO0XWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0ldkooOKOkxdoooooooooooolodxkKWMMMMMWNNWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXoxKOllxxk00KKKK0000000000kdoooxOOxdooldXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWWMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMWNX0XMMMMMMMMMMMMMMMMMMMMMWOlodk0KKKKKKKKKKKKKKKK0000000Oo:cccxk:cXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0xdddd0WMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMWX0OkOO0xdKMMMMMMMMMMMMMWKOkkkOkllkKKKKKKKK0KKKKKKKKKKKKKK0000kdooxo;lKMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWX00KWMMMMMMMMWNXK00OOOO0KXNWMMXxdkKXXxl0MMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMWX0Okkkk0XWMMWOo0WMMMMMMMMMMXxdO00O:;d0KKKKKKKKKKKKKKKKKKKKKKKKK000Oxk0x:c0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0xkkxdONMWKOxdxxddddddoooooodxkxOKkk0XxlKMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMNKOkkkk0XWMMMMMMMMWOoOWMMMMMMMMK:;0WWWd:xKK00KKKOxdooooxOKKKKKKK00KKKK00000OOdldKWWMMMMMMMMMMMMMMMMMMMWWNNNWWWMMMMMMMMWWWNNWWMWkxX0Okolxxdxk0XXNNNNNXXXXXKOkdlcoc;okdo0WMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMWKOOOkOXWMMMMMMMMMMMMMMW0lkWMMMMMMWo..;0MO;oKK00K0dcldxkkkxolcx0KKKK00KKKKKK0000O0OockWMMMMMMMMMMMMMMMMWWKkdllodk0NWWWWWXOxddoodk0N0xOd:ddokKXNXXXXXXXXXXXXXXXXK0OkxollcdXMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMWOoxXWMMMMMMMMMMMMMMMMMMMM0lkWMMMMMX:..:KWd:kKK0Kk::kNWMMMMMMNk:cOK00KKKK0KK000000OO0d:kWMMMMMMMMMMMMMMWXxl:::::::coOXNKxl::::::::cdKOxocd0XXXXXXXXXXXXXXXXXXXXXXKkllll:;lkXWMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMM0xOxOWMMMMMMMMMMMMMMMMMMMMMKlxWMMMMX::0XWK:c0K0KO:cXMWWWMMMMMMMXl:kKKK0K0000000000000OccKMMMMMMMMMMMMMWXd:::::::::::coxl::::::::::::xKdl0XXXXXXXXXXXXXXXXXXXXXKkoddxOKKK0kolo0WMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMM0kNKdOWMMMMMMMMMMMMMMMMMMMMMKlxNMMMWx:kXOdocd0KKo:KW0o;:0MMMMMMM0;oKKKKK00000000000000d;xMMMMMMMMMMMMMW0l:::::::::::::::::::::::::::llcldddoox0XXXXXXXXXXXXXXOloONWWWWMMWWN0d:lKMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMKxKW0oOWMMMMMMMMMMMMMMMMMMMMMKldNMMMWOlccdx:lOKO:lNWo...kMMMMMMMO;oKK0KKK0000000000000k;dMMMMMMMMMMMMMWOc:c:::::::::::::::::::::::::cdOKKXK0xoclkXXXXXXXXXXXOcxNNXNWMMMMMMWNX0lc0MMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMWXO0N0lOWMMMMMMMMMMMMMMMMMMMMMKlxWMMMMkckK0kloK0c:XWXkx0WMMMMMMXl:OKKK000KKK000K000OO0x;xMMMMMMMMMMMMMWKl:c:::::::::::::::::::::::::l0WWMMWWMWXx;lKXXXXXXXXXllXO:',kWMWMMMWWWX0ccXMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMNOkXOoOWMMMMMMMMMMMMMMMMMMMMM0lkWMMMXxdxdo:d0Kx;cKWMMWWWWMMNkcckKKKKKKKK0KKK00000O0OccKMMMMMMMMMMMMMWNkc::::::::::::::::::::::::::ccxNMMMMMMMW0:c0NXXXXXN0cxXc.. :XMMMMMMMWNXx:kMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMWOkXOlOWMMMMMMMMMMMMMMMMMMMMWOlOMMMM0l::lx0KKKkl:loxkOOkxolcd0KKKKKKKKKKK0K000000Oo:OMMMMMMMMMMMMMMMWNkl:::::::::::::::::::::::::,.'OMMMMMMMMMO;lKXXXXXNOckWKdldKWMMMMMMMWNKx:kMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMWOxXOlOWMMMMMMMMMMMMMMMMMMMMWkl0MMMNo;oO0KKKKKK0xolllllodOKKKKKKKKKKKKKK0K000000d:kWWMMMMMMMMMMMMMMMMN0o::::::::::::::::::::::oocckNMMMMMMMMWNl'xX0OO0N0cxWWMMMMMMMMMMMMWXKdoKMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMWkxXOlOWMMMMMMMMMMMMMMMMMMMMWxlKMWXol0KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK0K0K00000k:oNWWMMMMMMMMMMMMMMMMMWXxc:::::::::::::::::::dKWWWWWMMMMMMMMWNd'od:lloxOolXMMMMMMMMMMMMMWXklkWMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMNkxXOlOMMMMMMMMMMMMMMMMMMWNKOcoOkxldKKKKKKKKKKK000KKKKKKKKKKKKKKKKKK0KKK00000c;0MWMMMMMMMMMMMMMMMMMMMWNOoc:::::::::::::::cxXWWMMWMMMMMMMMMWXl;cldddkdokoo0WWMMMMMMMMMWXx;cXMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMNOxKOl0MMMMMMMMMMMWX0OkkOOOOocokx:dKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK00O0k;oWMMMMMMMMMMMMMMMMMMMMMMWWXkl::::::::::::ccdXWWMMMMMMMMMMMMWXx;o0dc:coxOXKxlokNWMMMMMWNkcc:c0MMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMWOdKOlOWMMMMWXOkxkkkO0XWMWNkldOl;xKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK00O0d,xMMMMMMMMMMMMMMMMMMMMMMMMMMWKxc::::::::clxxclKWWWWMMMMMMMWNKd;oKNX0xx0XXXXXKkoloddddoolcokd:xMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMWOd0OlkK0kkkkk0XWMMMWX0OOOO0NMO:xKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK000O0o,OMMMMMMMMMMMMMMMMMMMMMMMMMMMWN0oc:::::lodxxxoldOXWMMMMWWXOo::xXNXXXXNXXXXXXXXXKOkxxxkkkkkkx:lKNWMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMW0dO0clO0XWMMWX0OkOOOOKNWMMMMO:xKKKKKKKKKKKKKKKKKKKKK0KKKKKKKKKKKKK00000l;0MMMMMMMMMMMMMMMMMMMMMMMMMMMMMWXkl::oxxdxOKXXKd:lddooolllcokKNXXXXXXXXXXXXXXXXXXXXNNXXKOkkkc:dxxxkKWMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMKxkdxWWX0OkkkO0KNWMMMMMMMMMOcxKKKKKKKKKKKKKKKKK0KK00KKKKKKKKKKKKKK00O0o:OMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWW0xkKWN0xddoodlo0KOOkkkOKXNXXXXXXXXXXXXXXXXXXXXXXXXXXXXKOkklc0XKOxddONMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMNOolk0OO0KWMMMMMMMMMMMMMMMKcdKKKKKKKKKKKKKKKK0K0k0KOO0KKKKKKKKKKK00O0x;xMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWWMWMMMWX0Oc:0XXNNNXXXXXXNNNNNXXXXXXXXXXXXXXXXXXXXXXXOkkc;d0KXXN0cdWMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMNKKNMMMMMMMMMMMMMMMMMMMMNllKKKKKKKKKKKKKKKK0KkoOKdxKKKKKKKKKKKK0000k;cNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWMk:kNXNNXNNNNNNXXXXXXXXXXXXXXXXXXXXXXXXXXXXOkkl,lxdxxkkx0WMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWdcOKKKKKKKKKKKKKKKKOodOdx0KKKKKKKKKKKKK0000l,OMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0:dNNXXNXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX0kkl:0WWNNNWMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMO:dKKKKKKKKKKKKKKKKOdxxk0KKKKKKKKKKKKKK0000k;lNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNlcKNXXNNNXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXOkkccKMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNoc0KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK00000l;OMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMk;xNXXXNXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX0kkk:oNMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0cdKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK0000x;xMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNo:OXXXXXXXXXXXXXXXXXXXXXXXXXXNNNXNNXXXKOkkd:kMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWOcxKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK0000k;oWWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXo;kXXXXXXXXXXXXXXXXXNNNXXXXXXXNXXXXXKOkkkclXMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWOco0KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK00000k;lOkk0NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNx:o0XXXXXXXXXXXXXXXNXNXXXNXXNXXXXXKOkkko:OMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMKocxKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK000O00o;dX0llKMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWKo:dKXXXXXXXXXXXXXXXXXXXNXXXXXXX0OkkkockWMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWOllkKKKKK00KKKKKKKKKKKKKKKKKKKK000OO0x:lkkkkKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0lcdKNXXXXXXXXXXXXXXXXXXNNXX0Okkkxoo0WMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNxcld0K00KKKKKKKKKKKKKKKKKKK00000O0x:oXWWWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWOc:oOXXXXXXXXXXXXXXXXXXK0OkxdlcokNMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0dOOoclk0KK0000K000K0000000000O00kl:xNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMOcloodxk0KXXXXXXXXK0kdollool;lNMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMKokX0xdxdoodxO000O0KOkO0000000kdolldKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMkl0X0kc;ooooooooooooodo:dKXKldWMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0oxOkONMWN0kddddl:kX0olddoolloddx0NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMOckNXkdKWWNNXXXXXNWWMMNdoKXkcOMWMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWNXNMMMMMMMMMWNKOll0NxcoxkOOKNWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNdcdddKWMMMMMMMMMMMMMMWOcxxcxNMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNxodd0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN0k0NMMMMMMMMMMMMMMMMMW0xdOWMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWX0XWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]
      --[[ MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ]]

      --}
    end,
  },
}
