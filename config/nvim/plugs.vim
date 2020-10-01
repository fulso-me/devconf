call plug#begin('~/.config/nvim/plugged')
" coc installs
" npm install -g vim-language-server               ; viml
" npm i -g bash-language-server                    ; sh
" Shellcheck                                       ; sh
" shfmt                                            ; sh
" npm install -g dockerfile-language-server-nodejs ; dockerfile
" haskell-ide-engine                               ; haskell
" brittany                                         ; haskell
" hlint                                            ; haskell
" refact                                           ; haskell
" pip install pylint                               ; python
" pip install autopep8                             ; python
" pip install jedi-language-server                 ; python
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'donRaphaco/neotex', { 'for': 'tex' }
Plug 'google/vim-jsonnet', { 'for': 'jsonnet' }
"Plug 'ledger/vim-ledger', { 'for': 'ledger' } " ledger
"Plug 'davidhalter/jedi-vim'
Plug 'sirtaj/vim-openscad', { 'for': 'scad'}

Plug 'SirVer/ultisnips' " ultisnips
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'godlygeek/tabular'
Plug 'ludovicchabant/vim-gutentags' " needs Exuberant Ctags or Universal Ctags
Plug 'skywind3000/gutentags_plus'
Plug 'mbbill/undotree'
" Plug 'vim-scripts/auto-pairs-gentle'

Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-commentary'

Plug 'tyru/eskk.vim' " japanese

call plug#end()

let g:coc_global_extensions = [
  \ 'coc-marketplace',
  \ 'coc-diagnostic',
  \ 'coc-spell-checker',
  \ 'coc-vimlsp',
  \ 'coc-json',
  \ 'coc-docker',
  \ 'coc-html',
  \ 'coc-markdownlint',
  \ 'coc-python',
  \ 'coc-yaml',
  \]
