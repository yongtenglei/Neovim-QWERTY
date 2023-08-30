vim.cmd([[autocmd Filetype markdown inoremap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l]])
vim.cmd([[autocmd Filetype markdown inoremap <buffer> ,w <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>]])
vim.cmd([[autocmd Filetype markdown inoremap <buffer> ,n ---<Enter><Enter>]])
vim.cmd([[autocmd Filetype markdown inoremap <buffer> ,b **** <++><Esc>F*hi]])
vim.cmd([[autocmd Filetype markdown inoremap <buffer> ,s ~~~~ <++><Esc>F~hi]])
vim.cmd([[autocmd Filetype markdown inoremap <buffer> ,i ** <++><Esc>F*i]])
vim.cmd([[autocmd Filetype markdown inoremap <buffer> ,d `` <++><Esc>F`i]])
vim.cmd([[autocmd Filetype markdown inoremap <buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA]])
vim.cmd("autocmd Filetype markdown inoremap <buffer> ,m - [ ]]")
vim.cmd([[autocmd Filetype markdown inoremap <buffer> ,p ![](<++>) <++><Esc>F[a]])
vim.cmd(
	[[autocmd Filetype markdown inoremap <buffer> ,q <div align=center><img src=""></div><Enter><Enter><++><ESC>2k^f"a]]
)
vim.cmd(
	[[autocmd Filetype markdown inoremap <buffer> ,x <div align=center><Enter><Enter><++><Enter><Enter></div><Enter><Enter><++><ESC>4k0c$]]
)
vim.cmd([[autocmd Filetype markdown inoremap <buffer> ,a [](<++>) <++><Esc>F[a]])
vim.cmd([[autocmd Filetype markdown inoremap <buffer> ,1 #<Space><Enter><++><Esc>kA]])
vim.cmd([[autocmd Filetype markdown inoremap <buffer> ,2 ##<Space><Enter><++><Esc>kA]])
vim.cmd([[autocmd Filetype markdown inoremap <buffer> ,3 ###<Space><Enter><++><Esc>kA]])
vim.cmd([[autocmd Filetype markdown inoremap <buffer> ,4 ####<Space><Enter><++><Esc>kA]])
vim.cmd([[autocmd Filetype markdown inoremap <buffer> ,l --------<Enter>]])
vim.cmd([[autocmd Filetype markdown inoremap <buffer> ,h ``<++><Esc>4hi]])
