return {
  "ddl004/poop.nvim",
  config = function()
    vim.g.eject_speed = 30
    local emojis = { "💩", "👻", "🐙", "⚡️" }
    local period = 5
    vim.on_key(function(key)
      if vim.api.nvim_get_mode().mode ~= "i" then
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
