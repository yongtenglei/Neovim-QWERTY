local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
  require("rey.plugins.guess-indent"),
  require("rey.plugins.gitsigns"),
  require("rey.plugins.which-key"),
  require("rey.plugins.telescope"),
  require("rey.plugins.lspconfig"),
  require("rey.plugins.conform"),
  require("rey.plugins.blink-cmp"),

  require("rey.plugins.themes.vague"),
  -- require("rey.plugins.themes.tokyonight"),

  require("rey.plugins.todo-comments"),
  require("rey.plugins.mini"),
  require("rey.plugins.treesitter"),

  require("rey.plugins.debug"),
  require("rey.plugins.indent_line"),
  require("rey.plugins.lint"),

  require("rey.plugins.tree"),
  require("rey.plugins.snacks"),
  require("rey.plugins.aerial"),
  require("rey.plugins.ui"),
  require("rey.plugins.visual-multi"),
  require("rey.plugins.toggle-term"),
  require("rey.plugins.nvim-surround"),
  require("rey.plugins.preview"),
  require("rey.plugins.life-quality"),
  require("rey.plugins.harpoon"),
  require("rey.plugins.gitignore"),
  require("rey.plugins.just-for-fun"),

  require("rey.plugins.languages.golang.go"),
  require("rey.plugins.languages.markdown.markdown"),
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
