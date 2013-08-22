" Pretty syntax hi-lighting.
syntax enable
set background=dark
" Use solarized colorscheme only if we are in gui mode. Otherwise, depend on
" the terminal for the solarized colorscheme.
if has('gui_running')
  colorscheme solarized
endif

" Turn on filetype plugin & indent
filetype plugin indent on

" Press F5 to go to pasting mode & F5 again to go back.
nnoremap <F5> :set invpaste paste?<Enter>
imap <F5> <C-O><F5>
set pastetoggle=<F5>

" Tabs. See http://tedlogan.com/techblog3.html for an explanation of what
" these means. Alternatively read ":help options".
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab

" navigation mappings
noremap <S-j> <PageDown>
noremap <S-k> <PageUp>
noremap <S-l> <S-a>
noremap <S-h> <S-i>
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h
nnoremap <C-k> <C-W>k
nnoremap <C-j> <C-W>j

" Remap Esc to kj.
inoremap <Esc> <NOP>
inoremap kj <Esc>

" Arrow keys no more.
inoremap <Left>  <NOP>
inoremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>

" Show line numbers by default.
set number
" Show matching brackets.
set showmatch
" How many tenths of a second to blink matching brackets.
set mat=5
" Fix the backspace problem.
set backspace=2

" Highlight searches & press space to turn off highlighting and clear any
" message already displayed.
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Statusline. Copied shamelessly from
" http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

" Trim Trailing Whitespace.
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

" Cursor changes depending on mode.
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Work specific configuration
if filereadable(glob("~/workdotfiles/vimrc"))
  source ~/workdotfiles/vimrc
endif
