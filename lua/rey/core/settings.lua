vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = "a"

vim.o.showmode = false

vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

vim.o.breakindent = true

vim.o.undofile = true
vim.o.undodir = vim.fn.expand("~/.config/nvim/.tmp/undo")

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = "yes"

vim.o.updatetime = 250

vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.autoindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.cindent = true
vim.o.smartindent = true

vim.o.list = true
vim.opt.listchars = {
  tab = "▸ ",
  trail = "▫",
  nbsp = "␣",
}

vim.opt.iskeyword:append("-")

vim.o.inccommand = "split"

vim.o.cursorline = true

vim.o.scrolloff = 99

vim.o.confirm = true

-- vim.opt.guifont = "CaskaydiaCove Nerd Font Mono:h12"
vim.opt.guifont = "Maple Mono NF:h12"

vim.opt.guicursor = {
  "n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon1000-blinkoff1000",
  "i-ci:ver1-Cursor/lCursor-blinkwait1000-blinkon1000-blinkoff1000",
  "r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100",
}

-- Disables automatic commenting on newline
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "*" },
  command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
})

-- compiler
vim.cmd([[noremap r :call CompileRunGcc()<CR>]])
vim.cmd([[func! CompileRunGcc()
  exec "w"
  if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'cpp'
    set splitbelow
    exec "!g++ -std=c++11 % -Wall -o %<"
    :sp
    :res -15
    :term ./%<
  elseif &filetype == 'java'
    set splitbelow
    :sp
    :res -5
    term javac % && time java %<
  elseif &filetype == 'rust'
    set splitbelow
    :sp
    :res -5
    term cargo run
  elseif &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'python'
    set splitbelow
    :sp
    :term python3 %
  elseif &filetype == 'html'
    silent! exec "!".g:mkdp_browser." % &"
  elseif &filetype == 'markdown'
    exec ":MarkdownPreview"
  elseif &filetype == 'tex'
    silent! exec "VimtexStop"
    silent! exec "VimtexCompile"
  elseif &filetype == 'dart'
    exec "CocCommand flutter.run -d ".g:flutter_default_device." ".g:flutter_run_args
    silent! exec "CocCommand flutter.dev.openDevLog"
  elseif &filetype == 'javascript'
    set splitbelow
    :sp
    :term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
  elseif &filetype == 'go'
    set splitbelow
    :sp
    :term go run .
  elseif &filetype == 'plantuml'
    exec "PlantumlOpen"
  endif
endfunc]])
