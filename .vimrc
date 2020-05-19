:syntax on
:autocmd FileType *      set formatoptions=tcql nocindent comments&
:autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,ex:*/,://
:
:set autoindent
:set autowrite
:ab #d #define
:ab #i #include
:ab #b /********************************************************
:ab #e ********************************************************/
:ab #l /*------------------------------------------------------*/
:set sw=4
:set notextmode
:set notextauto
:set hlsearch
:set incsearch
:set textwidth=70
:set statusline=%t       "tail of the filename
:set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
:set statusline+=%{&ff}] "file format
:set statusline+=%h      "help file flag
:set statusline+=%m      "modified flag
:set statusline+=%r      "read only flag
:set statusline+=%y      "filetype
:set statusline+=%=      "left/right separator
:set statusline+=%c,     "cursor column
:set statusline+=%l/%L   "cursor line/total lines
:set statusline+=\ %P    "percent through file

execute pathogen#infect()
