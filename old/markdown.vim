" allowing folding
let g:vim_markdown_folding_disabled = 0
" folding like python
let g:vim_markdown_folding_style_pythonic = 1
" cannot set folding section
let g:vim_markdown_override_foldtext = 0
" folding level (1 - 6 )
let g:vim_markdown_folding_level = 1
" default key
let g:vim_markdown_no_default_key_mappings = 0
" allowing auto fit
let g:vim_markdown_toc_autofit = 1
" By default text emphasis works across multiple lines until a closing token is found
let g:vim_markdown_emphasis_multiline = 1

"concealing
set conceallevel=0
" allowing code block concealing
let g:vim_markdown_conceal_code_blocks = 1
" cs as csharp and py as python
let g:vim_markdown_fenced_languages = ['csharp=cs', 'python=py']

" extension
let g:vim_markdown_math = 1
" strikethrough
let g:vim_markdown_strikethrough = 1

"Adjust new list item indent to 2 space (4 by default)
let g:vim_markdown_new_list_item_indent = 2

" not necessary to do so [link text](link-url.md)
let g:vim_markdown_no_extensions_in_markdown = 1

" auto write when `ge`
let g:vim_markdown_autowrite = 1

" how to open new files when `ge` options: tab, vsplit, hsplit, current(by default)
let g:vim_markdown_edit_url_in = 'vsplit'
