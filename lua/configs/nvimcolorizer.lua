local M = {}
function M.config()
  require 'colorizer'.setup {
    filetypes = {
      'css',
      'javascript',
      html = { mode = 'foreground'; }
    },
    user_default_options = { mode = "background", },
  }
end

return M
