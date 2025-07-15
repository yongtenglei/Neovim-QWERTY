return {
  "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000,
  config = function()
    require("everforest").setup({
      -- "sof", "medium" or "hard"
      background = "hard",
      transparent_background_level = 0,
      italics = true,
      disable_italic_comments = false,
      -- eg. "grey"
      sign_column_background = "none",
      -- "high" or "low"
      ui_contrast = "low",
      dim_inactive_windows = false,
      diagnostic_text_highlight = false,
      -- "grey"` or "coloured"
      diagnostic_virtual_text = "coloured",
      diagnostic_line_highlight = true,
      spell_foreground = false,
      -- EndOfBuffer highlight
      show_eob = true,
      -- "bright" or "dim"
      float_style = "bright",
      -- "none" or "dimmed"
      inlay_hints_background = "none",

      ---@param highlight_groups Highlights
      ---@param palette Palette
      on_highlights = function(highlight_groups, palette) end,
      ---You can override colours in the palette to use different hex colours.
      ---This function will be called once the base and background colours have
      ---been mixed on the palette.
      ---@param palette Palette
      colours_override = function(palette) end,
    })
  end,
}
