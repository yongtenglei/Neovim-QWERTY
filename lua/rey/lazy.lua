local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

require("lazy").setup({
  -- theme first :)
  -- { import = "rey.plugins.themes.solarized" },
  -- { import = "rey.plugins.themes.ayu" },
  { import = "rey.plugins.themes.gruvbox" },
  -- { import = "rey.plugins.themes.kanagawa" },
  -- { import = "rey.plugins.themes.catppuccin" },

  { import = "rey.plugins" },
  { import = "rey.plugins.lsp" },
  { import = "rey.plugins.mini" },
  { import = "rey.plugins.languages.markdown" },
  { import = "rey.plugins.languages.latex" },
  { import = "rey.plugins.languages.golang" },
  { import = "rey.plugins.languages.rust" },
}, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
