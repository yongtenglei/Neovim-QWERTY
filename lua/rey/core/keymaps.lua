vim.keymap.set("n", "<leader>rc", ":e ~/.config/nvim/init.lua <cr>", { desc = "Source config file" })
vim.keymap.set("n", "<leader>sc", ":set spell!<cr>", { desc = "Spell check" })
vim.keymap.set("n", "=", "nzz", { desc = "Next search" })
vim.keymap.set("n", "-", "Nzz", { desc = "Previous Search" })
vim.keymap.set("n", "<leader><cr>", ":nohlsearch<cr>", { desc = "No highlight search" })
vim.keymap.set("n", "L", "$", { desc = "End of line" })
vim.keymap.set("n", "H", "0", { desc = "Start of line" })
vim.keymap.set("n", "K", "5k", { desc = "5k" })
vim.keymap.set("n", "J", "5j", { desc = "5j" })
vim.keymap.set("v", "K", "5k", { desc = "5k" })
vim.keymap.set("v", "J", "5j", { desc = "5j" })
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "Q", ":q!<enter>", { desc = "Quick exit" })

-- Indent
vim.keymap.set("n", "<", "<<", { desc = "Indent" })
vim.keymap.set("n", ">", ">>", { desc = "Deindent" })
-- Stay in indent mode when you indent code
vim.keymap.set("v", "<", "<gv", { desc = "Indent" })
vim.keymap.set("v", ">", ">gv", { desc = "Deindent" })
-- Move text up and down
vim.keymap.set("v", "<A-down>", ":m '>+1<CR>gv=gv", { desc = "Move text up" })
vim.keymap.set("v", "<A-up>", ":m '<-2<CR>gv=gv", { desc = "Move text down" })

-- Split screen
vim.keymap.set("n", "sk", ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>", { desc = "Split horizontally" })
vim.keymap.set("n", "sj", ":set splitbelow<CR>:split<CR>", { desc = "Split horizontally" })
vim.keymap.set("n", "sh", ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>", { desc = "" })
vim.keymap.set("n", "sl", ":set splitright<CR>:vsplit<CR>", { desc = "" })
-- Rotate window
vim.keymap.set("n", "srh", "<C-w>b<C-w>K", { desc = "" })
vim.keymap.set("n", "srv", "<C-w>b<C-w>H", { desc = "" })

-- Adjust window size
vim.keymap.set("n", "<up>", ":res +5<cr>", { desc = "" })
vim.keymap.set("n", "<down>", ":res -5<cr>", { desc = "" })
vim.keymap.set("n", "<left>", ":vertical resize+5<cr>", { desc = "" })
vim.keymap.set("n", "<right>", ":vertical resize-5<cr>", { desc = "" })

-- Tab management
vim.keymap.set("n", "ti", ":tabe<cr>", { desc = "" })
vim.keymap.set("n", "th", ":-tabnext<cr>", { desc = "" })
vim.keymap.set("n", "tl", ":+tabnext<cr>", { desc = "" })
-- Move tabs
vim.keymap.set("n", "tmh", ":-tabmove<cr>", { desc = "" })
vim.keymap.set("n", "tml", ":+tabmove<cr>", { desc = "" })

-- Buffer switcher
vim.keymap.set("n", "bh", ":bp<cr>", { desc = "" })
vim.keymap.set("n", "bl", ":bn<cr>", { desc = "" })

-- Terminal enhancement
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

--  Use leader+<hjkl> to switch between windows
vim.keymap.set("n", "<leader>ww", "<C-w>w", { desc = "Move focus to another window" })
vim.keymap.set("n", "<leader>h", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<leader>l", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<leader>j", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<leader>k", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("yank-highlight", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

vim.keymap.set("n", "<leader>ef", ":FormatEnable<cr>", { desc = "[E]nable [F]ormat" })
vim.keymap.set("n", "<leader>df", ":FormatDisable<cr>", { desc = "[D]isable [F]ormat" })

local function trim_trailing_whitespace()
  local view = vim.fn.winsaveview()
  vim.cmd([[keeppatterns %s/\s\+$//e]])
  vim.fn.winrestview(view)
end

vim.api.nvim_create_user_command("TrimWhitespace", function()
  trim_trailing_whitespace()
end, {})


local skip_trimming_trailing_whitespace_filetypes = {
  mail = true,
  markdown = true,
  gitcommit = true,
  text = true,
  help = true,
  [''] = true
}

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    if not vim.bo.binary and not skip_trimming_trailing_whitespace_filetypes[vim.bo.filetype] then
      trim_trailing_whitespace()
    end
  end,
})
