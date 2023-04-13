local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local M = {}
function M.config()
  --local telescope = require("telescope")
  local actions = require("telescope.actions")

  telescope.setup({

    defaults = {

      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "smart" },

      mappings = {
        i = {
          ["<C-j>"] = actions.cycle_history_next,
          ["<C-k>"] = actions.cycle_history_prev,

          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,

          ["<C-c>"] = actions.close,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,

          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<C-l>"] = actions.complete_tag,
          ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
        },

        n = {
          --["<esc>"] = actions.close,
          ["<C-c>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

          ["e"] = actions.move_selection_next,
          ["u"] = actions.move_selection_previous,
          ["U"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["E"] = actions.move_to_bottom,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["?"] = actions.which_key,
          ["D"] = actions.delete_buffer,
        },
      },
    },

    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      aerial = {
        -- Display symbols as <root>.<parent>.<symbol>
        show_nesting = {
          ["_"] = false, -- This key will be the default
          json = true, -- You can set the option for specific filetypes
          yaml = true,
        },
      },
    },
  })
  -- add fzf_native plugin
  telescope.load_extension("fzf")
  telescope.load_extension("aerial")

  -- mapping function
  local builtin = require("telescope.builtin")
  local theme = require("telescope.themes")

  local curr_buff = function()
    local opt = theme.get_ivy()
    builtin.current_buffer_fuzzy_find(opt)
  end

  vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
  vim.keymap.set("n", "<leader>fF", ":Telescope find_files cwd=")
  vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
  vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
  vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
  vim.keymap.set("n", "<leader>fc", builtin.command_history, {})
  vim.keymap.set("n", "<leader>fs", builtin.search_history, {})
  vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
  vim.keymap.set("n", "<leader>fn", ":Noice telescope<cr>")
  vim.keymap.set("n", "<leader>fv", ":Telescope aerial<cr>")
  vim.keymap.set(
    "n",
    "<C-_>", -- <C-_> means <C-/> for some historical reason
    curr_buff,
    {}
  --":Telescope current_buffer_fuzzy_find sorting_strategy=ascending theme=ivy <cr>" -- vim script format
  )
end

return M
