return {
  "ddl004/poop.nvim",
  config = function()
    -- Function to check if the current file type is excluded
    -- Hint: use ":set filetype?" to find the filetype
    local function is_fts_excluded(buf_ft, excluded_fts)
      for _, ft in ipairs(excluded_fts) do
        if buf_ft == ft then
          return true
        end
      end
      return false
    end

    local excluded_fts = {
      "TelescopePrompt",
    }

    -- Customized settings
    vim.g.eject_speed = 30
    local emojis = { "💩", "👻", "🐙", "⚡️" }
    local period = 5

    vim.on_key(function(key)
      local mode = vim.api.nvim_get_mode().mode
      local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")

      if mode ~= "i" or is_fts_excluded(buf_ft, excluded_fts) then
        return
      end

      vim.schedule_wrap(function()
        local left = emojis[math.random(1, #emojis)]
        local right = emojis[math.random(1, #emojis)]
        local should_eject = math.random(1, period) == 1

        if should_eject then
          vim.cmd.Eject(left, right)
        end
      end)()
    end, nil)
  end,
}
