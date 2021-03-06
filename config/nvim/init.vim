" Plug {{{

let g:vim_home = get(g:, 'vim_home', expand('~/.config/nvim/'))
exec 'source' g:vim_home.'plugs.vim'


"}}}

" Basics {{{
let mapleader = ','

syntax on
colorscheme gruvbox
set termguicolors

"Make sure directories exist
if !isdirectory($HOME.'/.vim-tmp')
    call mkdir($HOME.'/.vim-tmp', '', 0770)
endif
if !isdirectory($HOME.'/.vim-tmp/backup')
    call mkdir($HOME.'/.vim-tmp/backup', '', 0700)
endif
if !isdirectory($HOME.'/.vim-tmp/swp')
    call mkdir($HOME.'/.vim-tmp/swp', '', 0700)
endif
if !isdirectory($HOME.'/.vim-tmp/undo')
    call mkdir($HOME.'/.vim-tmp/undo', '', 0700)
endif
"}}}

" Japanese {{{

let g:eskk#show_annotation = 1
let g:eskk#no_default_mappings = 1
let g:eskk#large_dictionary = {
\   'path': '/usr/share/skk/SKK-JISYO.L',
\   'sorted': 1,
\   'encoding': 'euc-jp',
\ }

imap <Leader>j <Plug>(eskk:toggle)
cmap <Leader>j <Plug>(eskk:toggle)
lmap <Leader>j <Plug>(eskk:toggle)

" <leader>j to write in ひりがな
" q while writing to write in カタカナ
" start word with ; and <C-x><C-o> to omni complete ;かんじ<C-x><C-o> -> 漢字

" }}}

" Sets {{{
" set nocompatible
set modelines=5
set number
set relativenumber
set scrolloff=3 " keep at least 3 lines at top or bottom while scrolling
set showmode
set showcmd
set wildmenu " nice prediction menu
set wildmode=list:longest " list matches and complete till longest common match
set visualbell " shutup
set cursorline
set ruler " line/col numbers
set backspace=indent,eol,start " backspace through newlines and indents
set concealcursor=nc " conceal in normal/command modes
set conceallevel=0
set nowrap
set encoding=utf-8
scriptencoding=utf-8
set list
set listchars=tab:▸\ ,eol:␣
set history=1000 " history of :cmd
set backupdir=~/.vim-tmp/backup//
set directory=~/.vim-tmp/swp//
set foldmethod=marker
set foldcolumn=3 " Keep 2 levels of fold visually represented
set lazyredraw " don't redraw during a macro.
set inccommand=split

set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes

" format options
set formatoptions-=r " don't auto insert comment lines
set formatoptions-=o " ""
set formatoptions-=c " don't autowrap comments
set formatoptions-=q " format comments gq
set formatoptions-=wa " auto-format paragraphs, trailing whitespace means a continued paragraph
set formatoptions+=j " join comments sanely

"tabline - plugin/tabline.vim
set showtabline=1 "only if there are tabs
set tabline=%!MyTabLine()

"undo persistance
set undodir=~/.vim-tmp/undo//
set undofile
set undolevels=1000
set undoreload=10000

" Hell with tabs
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Hide buffers without saving.
set hidden

let g:neotex_enabled=2
let g:neotex_subfile=1
"}}} 

" Statusline {{{
set laststatus=2 "always have a statusline
set statusline= "clear statusline
set statusline+=%h%m%r%w "flags
set statusline+=%1*%-3.3n%* "buffer
set statusline+=%f "filename
set statusline+=%1*%y%* "filetype
set statusline+=%L "total lines
set statusline+=%= "right align
set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}
set statusline+=%= "right align
set statusline+=%{ObsessionStatus()}
"set statusline+=[%{LinterStatus()}]
set statusline+=%{FugitiveStatusline()}
"}}}

" Remaps {{{
"make Y behave like C and D
nnoremap Y y$

" I'm too used to jj for ESC and ^[
" inoremap jj <ESC>

" repeat macro instead of ex mode
nnoremap Q @@

" better search
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap >s/ >smagic/
cnoremap .s/ .smagic/
cnoremap g/ :g/\v
cnoremap g// :g//
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
" nnoremap <tab> %
" vnoremap <tab> %

" no stupid help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

"nice j and k
nnoremap j gj
nnoremap k gk

"nice sideways scroll
nnoremap zh zH
nnoremap zl zL

" kill trailing whitespaces
"nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" new selected split
"nnoremap <leader>w <C-w>v<C-w>l
" better split movement
nnoremap <C-h>      <C-w>h
nnoremap <C-j>      <C-w>j
nnoremap <C-k>      <C-w>k
nnoremap <C-l>      <C-w>l
nnoremap <C-w><C-h> <C-w>H
nnoremap <C-w><C-j> <C-w>J
nnoremap <C-w><C-k> <C-w>K
nnoremap <C-w><C-l> <C-w>L

" switch ` and ' for marks
nnoremap ' `
nnoremap ` '

" sudo write
ca w!! w !sudo tee >/dev/null "%"

" turn on and off spelling
map <F8> :setlocal spell spelllang=en_gb<CR>
map <F10> :setlocal nospell<CR>
"}}}
" {{{ autocmd
augroup always
  autocmd!
  " linenumbers in insert, relative everywhere else
  au InsertEnter * set norelativenumber
  au InsertLeave * set relativenumber
augroup END
" }}}
