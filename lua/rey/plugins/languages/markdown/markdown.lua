return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = ":call mkdp#util#install()",
    dependencies = {
      { "dhruvasagar/vim-table-mode", ft = { "markdown" } },
      { "godlygeek/tabular", ft = { "markdown" } },
    },
    ft = { "markdown" },
    config = function()
      -- if do not work in .md file, please do `:call mkdp#util#install()`
      -- do not auto preview
      vim.cmd([[let g:mkdp_auto_start = 1]])
      -- auto close preview when leaving .md buffer
      vim.cmd([[let g:mkdp_auto_close = 1]])
      -- auto refresh preview
      vim.cmd([[let g:mkdp_refresh_slow = 0]])
      -- only .md file
      vim.cmd([[let g:mkdp_command_for_global = 0]])
      -- only 127.0.0.1
      vim.cmd([[let g:mkdp_open_to_the_world = 0]])
      -- use custom IP to open preview page
      -- useful when you work in remote vim and preview on local browser
      -- more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
      -- default empty
      vim.cmd([[let g:mkdp_open_ip = '']])
      -- specify browser to open preview page
      -- default: ''
      -- google-chrome-stable for linux
      vim.cmd([[let g:mkdp_browser = 'google-chrome']])
      -- set to 1, echo preview page url in command line when open preview page
      vim.cmd([[let g:mkdp_echo_preview_url = 0]])
      -- a custom vim function name to open preview page
      -- this function will receive url as param
      -- default is empty
      vim.cmd([[let g:mkdp_browserfunc = '']])
      -- recognized filetypes
      -- these filetypes will have MarkdownPreview... commands
      vim.cmd("let g:mkdp_filetypes = ['markdown']")

      --========================common config ⬆️========================
      -- options for markdown render
      -- mkit: markdown-it options for render
      -- katex: katex options for math
      -- uml: markdown-it-plantuml options
      -- maid: mermaid options
      -- disable_sync_scroll: if disable sync scroll, default 0
      -- sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
      --   middle: mean the cursor position alway show at the middle of the preview page
      --   top: mean the vim top viewport alway show at the top of the preview page
      --   relative: mean the cursor position alway show at the relative positon of the preview page
      -- hide_yaml_meta: if hide yaml metadata, default is 1
      -- sequence_diagrams: js-sequence-diagrams options
      -- content_editable: if enable content editable for preview page, default: v:false
      -- disable_filename: if disable filename header for preview page, default: 0
      vim.cmd([[let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }]])

      -- use a custom markdown style must be absolute path
      -- like '/Users/username/markdown.css' or expand('~/markdown.css')
      --let g:mkdp_markdown_css = '/Users/rey/.config/nvim/old/markdown/markdown.css'
      -- Other
      --let g:mkdp_markdown_css = '~/.config/nvim/old/markdown/markdown.css'
      -- Mac
      -- vim.cmd(
      --   [[let g:mkdp_markdown_css = '/Users/rey/.config/nvim/lua/rey/plugins/languages/markdown/templates/markdown.css']]
      -- )

      -- use a custom highlight style must absolute path
      -- like '/Users/username/highlight.css' or expand('~/highlight.css')
      -- vim.cmd([[let g:mkdp_highlight_css = '~/.config/nvim/lua/rey/plugins/languages/markdown/templates/markdown.css']])

      -- use a custom port to start server or random for empty
      vim.cmd([[let g:mkdp_port = '']])

      -- preview page title
      -- ${name} will be replace with the file name
      vim.cmd([[let g:mkdp_page_title = '${name}_____']])
    end,
  },
  {
    "plasticboy/vim-markdown",
    ft = { "markdown" },
    config = function()
      -- allowing folding
      vim.cmd([[let g:vim_markdown_folding_disabled = 0]])
      -- folding like python
      vim.cmd([[let g:vim_markdown_folding_style_pythonic = 1]])
      -- cannot set folding section
      vim.cmd([[let g:vim_markdown_override_foldtext = 0]])
      -- folding level (1 - 6 )
      vim.cmd([[let g:vim_markdown_folding_level = 1]])
      -- default key
      vim.cmd([[let g:vim_markdown_no_default_key_mappings = 0]])
      -- allowing auto fit
      vim.cmd([[let g:vim_markdown_toc_autofit = 1]])
      -- By default text emphasis works across multiple lines until a closing token is found
      vim.cmd([[let g:vim_markdown_emphasis_multiline = 1]])

      -- concealing
      vim.cmd([[set conceallevel=0]])
      -- allowing code block concealing
      vim.cmd([[let g:vim_markdown_conceal_code_blocks = 1]])
      -- cs as csharp and py as python
      --vim.cmd([[let g:vim_markdown_fenced_languages = ['csharp=cs', 'python=py']]])

      -- extension
      vim.cmd([[let g:vim_markdown_math = 1]])
      -- strikethrough
      vim.cmd([[let g:vim_markdown_strikethrough = 1]])

      -- Adjust new list item indent to 2 space (4 by default)
      vim.cmd([[let g:vim_markdown_new_list_item_indent = 2]])

      -- not necessary to do so [link text](link-url.md)
      vim.cmd([[let g:vim_markdown_no_extensions_in_markdown = 1]])

      -- auto write when `ge`
      vim.cmd([[let g:vim_markdown_autowrite = 1]])

      -- how to open new files when `ge` options: tab, vsplit, hsplit, current(by default)
      vim.cmd([[let g:vim_markdown_edit_url_in = 'vsplit']])

      -- load snippets
      require("rey.plugins.languages.markdown.autocmds")
    end,
  },
}
