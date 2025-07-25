" ============================================
" TMUX INTEGRATION
" ============================================

" Enable mouse support for all modes (normal, visual, insert, command)
set mouse=a

" Use system clipboard as default register (+ register) - works with tmux clipboard integration
set clipboard=unnamedplus

" AUDIT CHANGE: Removed cursor shape config - let tmux handle this via terminal-overrides
" Original config conflicted with tmux's cursor handling (line 21 in .tmux.conf)
" if exists('$TMUX')
"     let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
"     let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
" else
"     let &t_SI = "\e[5 q"
"     let &t_EI = "\e[2 q"
" endif

" Better colors in tmux
"if (has("termguicolors"))
"    set termguicolors
"endif

" ============================================
" ESSENTIAL VIM SETTINGS
" ============================================

" Show line numbers
"set number
"set relativenumber

" Search configuration for better usability
set ignorecase          " Ignore case in search patterns
set smartcase           " Override ignorecase if search contains uppercase
set incsearch           " Show matches as you type
set hlsearch            " Highlight all search matches

" Indentation
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent
set nosmartindent
filetype indent on

" Visual improvements
"set cursorline
"set colorcolumn=80
"set signcolumn=yes
"set scrolloff=8

" File handling
set hidden
set autoread
set noswapfile
set nobackup
set undofile
set undodir=~/.vim/undodir

" Performance optimizations
set lazyredraw          " Don't redraw during macros/scripts
set updatetime=50       " Faster completion and swap file writes (ms)

" ============================================
" KEY MAPPINGS
" ============================================

" Use Ctrl-C to copy in visual mode (instead of cancel)
"vnoremap <C-S-c> "+ygv<Esc>
"vnoremap <C-S-v> "+pgv<Esc>

" Better escape (AUDIT CHANGE: commented out since caps lock is mapped to escape)
" inoremap jk <Esc>
" inoremap kj <Esc>

" Move lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Stay centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Clear search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Better paste from system clipboard (avoids indentation issues)
nnoremap <leader>p "+p

" Toggle paste mode with leader+v (more reliable than Ctrl+Shift combinations)
nnoremap <leader>v :set paste!<CR>i
" Exit paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" ============================================ 
" REQUIRED PLUGINS (AUDIT CHANGE: promoted from recommendations)
" ============================================

" CRITICAL: Install vim-plug first, then add these to your plugin section:
" Plug 'christoomey/vim-tmux-navigator'  " REQUIRED - seamless vim/tmux navigation (enabled in tmux config)
" Plug 'tmux-plugins/vim-tmux'           " Optional - tmux conf syntax highlighting
" Plug 'roxma/vim-tmux-clipboard'        " Optional - enhanced clipboard integration

" To install: Add plugins between plug#begin() and plug#end(), then run :PlugInstall
