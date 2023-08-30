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
  { import = "rey.plugins.themes.solarized" },
  { import = "rey.plugins" },
  { import = "rey.plugins.lsp" },
  { import = "rey.plugins.languages.markdown" },
},
{
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
  notify = false,
  },
})
