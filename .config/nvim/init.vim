let mapleader = ","

" colorscheme solarized     " set colorscheme
" set showmatch		      " Show matching brackets.
" set softtabstop=4         " unify
" set t_Co=256              " enable 256-color mode.
" set tabstop=4             " tab spacing
set autowrite		      " Automatically save before commands like :next and :make
set expandtab             " use spaces instead of tabs
set hidden		          " Hide buffers when they are abandoned
set ignorecase            " Make searches case-insensitive.
set inccommand=nosplit
set linebreak
set mouse=a		          " Enable mouse usage (all modes)
set noshowmode
set number                " show line numbers
set scrolloff=5
set shiftwidth=4          " indent/outdent by 4 columns
set smartcase		      " Do smart case matching
set splitbelow splitright
set termguicolors

highlight Normal guibg=NONE ctermbg=NONE


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autoiastall VimPlug if not installed already
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

" A tree explorer plugin for vim.
Plug 'scrooloose/nerdtree'
" , { 'on': 'NERDTreeToggle' }

" A solid language pack for Vim.
Plug 'sheerun/vim-polyglot'

" Lean & mean status/tabline for vim that's light as air
" Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'

" Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP, unite, Denite, lightline, vim-startif...
Plug 'ryanoasis/vim-devicons'

" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'
Plug 'melonmanchan/vim-tmux-resizer'

" Surround.vim: quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" Vim syntax highlighting for i3 config
Plug 'mboughaba/i3config.vim'

" Ease your git workflow within Vim
Plug 'jreybert/vimagit'

" Vim syntax highlighting for the OpenSCAD language
Plug 'sirtaj/vim-openscad'

" Fzf :heart: vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Distraction-free writing in Vim
Plug 'junegunn/goyo.vim'

" Vim plugin for sxhkd (Simple X hotkey daemon)
Plug 'kovetskiy/sxhkd-vim'

" Fugitive.vim: A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" The fancy start screen for Vim.
Plug 'mhinz/vim-startify'

" A vim plugin for writing Latex quickly.
Plug 'brennier/quicktex'

" Incremental search improved - successor of incsearch.vim
Plug 'haya14busa/is.vim'

" Enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'

Plug 'tpope/vim-commentary'

" Flake8 plugin for Vim
Plug 'nvie/vim-flake8'

" Resize tmux panes and vim splits with same shortcuts
Plug 'melonmanchan/vim-tmux-resizer'

Plug 'vim/killersheep'

"Themes
Plug 'lifepillar/vim-solarized8'
" Plug 'tomasr/molokai'
Plug 'fatih/molokai'
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
Plug 'joshdick/onedark.vim'

call plug#end()

" colorscheme gruvbox
" colorscheme jellybeans
colorscheme molokai
highlight MatchParen guifg=bg guibg=fg gui=bold
highlight Normal guibg=NONE ctermbg=NONE

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf mappings
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" let g:airline_powerline_fonts = 1

let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \   'gitbranch': 'FugitiveHead',
      \ },
      \ }

function! MyFiletype()
      return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
  endfunction

  function! MyFileformat()
        return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
    endfunction


autocmd BufReadPost *
            \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
            \ |   exe "normal! g`\""
            \ | endif

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Update binds when sxhkdrc is updated.
autocmd BufWritePost *sxhkdrc !pkill -USR1 -x sxhkd

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
map <leader>p :!opout <c-r>%<CR><CR>

nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Brake up multiline insert so that undo removes one line
" inoremap <CR> <CR>

let g:tex_flavor = "latex"
let g:LatexBox_viewer=$READER
let g:LatexBox_latexmk_preview_continuously=1
