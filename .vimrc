" Configuration file for Vim.

" use Vim mode instead of pure Vi, it must be the first instruction
" This must be first, because it changes other options as side effect
set nocompatible

" display settings
set encoding=utf-8 " encoding used for displaying file
set ruler " show the cursor position all the time

" syntax highlighting
syntax enable " enable syntax highlighting (is the same as "syntax on"?)

" highlight matching braces
set showmatch " highlight matching braces 
set noshowmatch " do not highlight matching braces (it doesn't work!!!) 
let loaded_matchparen = 1 "prevents the matchparen plugin from loading and highlighting parenthesis!
hi MatchParen cterm=none ctermbg=black ctermfg=magenta  " It works in execute mode but not in vimrc!?
hi MatchParen gui=none guibg=black guifg=magenta  " It works in execute mode but not in vimrc!? 

set showmode " show insert/replace/visual mode
set number " show line numbers
set nowrap
set smartindent " Better than 'autoindent' 
set mouse=a " mouse support

" write settings
set confirm " confirm :q in case of unsaved changes
set fileencoding=utf-8 " encoding used when saving file
set fileencodings=ucs-bom,utf-8,latin-1

"set nobackup " do not keep the backup~ file
set backup " tell vim to keep a backup file
set backupdir=~/tmp " tell vim where to put its backup files (folder must exists)
set dir=.,~/tmp " tell vim where to put swap files (folder must exists)

" edit settings
set backspace=indent,eol,start " backspacing over everything in insert mode (like most programs)
set shiftwidth=2 " set indentation depth to 2 columns
set softtabstop=2 " backspacing over 2 spaces like over tabs
set tabstop=2 " set tabulator length to 2 columns
set expandtab " fill tabs with spaces
set scrolloff=7 " number of context lines to see above and below the cursor.

" search settings
set hlsearch " highlight search results
set ignorecase " do case insensitive search...
set incsearch " do incremental search
set smartcase " ...unless capital letters are used

" For regular expressions turn magic on
set magic

" file type specific settings
filetype on " enable file type detection
filetype indent on " automatically indent code
"filetype plugin on " load the plugins for specific file types

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set background=dark " dark background for console

" color scheme
colorscheme desert 
"colorscheme wombat256mod

" characters for displaying non-printable characters
set listchars=eol:$,tab:>-,trail:.,nbsp:_,extends:+,precedes:+

"set columns=132 lines=43 " Default window geometry

" tuning for gVim only
if has('gui_running')

  "set background=light " light background for GUI (conflicts with colorscheme!)
  colorscheme desert  
  
  "set columns=132 lines=43 " GUI window geometry

  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h15
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif

endif

" Always show the status line
set laststatus=2

" Format the status line
set statusline=
set statusline+=b:%n " Buffer number
set statusline+=\ %f " Filename (use %F for filepath)
set statusline+=%m   " Modified flag
set statusline+=%r   " Read only flag
set statusline+=%=   " Switch to the right side
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ [%{&fileformat}\]
"set statusline+=\ %y " [Filetype]
set statusline+=\ %p%% " Percentage 
set statusline+=\ \|\ %l:%c " Current line and column
set statusline+=\ 


" Highlight the Current Line
set cursorline
hi cursorline cterm=none term=none
"hi CursorLine guibg=#303000 ctermbg=234
hi CursorLine guibg=Grey25  " Color depends on the current colorscheme

" Highlight the Current Line in the current window only
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
   \ if line("'\"") > 0 && line("'\"") <= line("$") |
   \   exe "normal! g`\"" |
   \ endif
"Remember info about open buffers on close
set viminfo^=%


" GENERAL KEY MAPPINGS ====================================================================================

" Change the mapleader from \ to ,
let mapleader=","

" Turn the search results highlight off
nnoremap <leader><space> :nohlsearch <CR>

" Map <Space> to / (search)
"map <space> /

" Map Ctrl-<Space> to ? (backwards search)
"map <c-space> ?

" New tab
nnoremap <C-t> <Esc>:tabnew<CR>
nnoremap <leader>t <Esc>:tabnew<CR>
 
" Show or hide file explorer (do not use Ctrl-F!) 
nnoremap <leader>f <Esc>:Lex<CR>:vertical resize 30<CR>     

" Next/Previous buffer
map <leader>n :bnext<CR>
map <leader>p :bprevious<CR>
map <leader>, :bprevious<CR>

" Center to cursor after PageUp and PageDown
nnoremap <C-u> <C-u>zz 
nnoremap <C-d> <C-d>zz 

" Center to cursor after searching next/prev
nnoremap * *zz
nnoremap # #zz
nnoremap n nzz
nnoremap N Nzz

" C-c and C-v - Copy/Paste to system clipboard if Vim was compiled with clipboard support.
" Check clipboard support with: 'vim --version' 
" The text '-xterm_clipboard' (with a minus prefix) means it has no support. 
" To have Vim with clipboard support: uninstall Vim, install gVim and use its console Vim.
" ----------------------------------------------------------------------------------------
" copy works in visual mode!
" paste works in insert mode!
vmap <C-c> "+yi
imap <C-v> <esc>"+gpi

" Paste from system clipboard with Ctrl+I instead of Shift+Insert (gVim only???) 
map <C-i> <S-Insert>

" Remap 0 to first non-blank character
"map 0 ^

" Remaps for the first ans last characters
"map B ^ 
"map E $ 

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" FUNCTION KEY MAPPINGS ===================================================================================  

" press F4 to fix indentation in whole file; overwrites marker 'q' position
noremap <F4> mqggVG=`qzz
inoremap <F4> <Esc>mqggVG=`qzza


" press F8 to change colorschemes  
let s:swindex = 0
let s:swcolors =  []  
let s:swcolors += ['blue', 'darkblue', 'delek', 'desert', 'elflord']  
let s:swcolors += ['evening', 'industry', 'koehler', 'morning',] 
let s:swcolors += ['murphy', 'pablo', 'peachpuff', 'ron', 'shine'] 
let s:swcolors += ['slate', 'torte', 'zellner'] 

function! SwitchColor(swinc)
  let s:swindex += a:swinc
  let s:swindex = s:swindex % (len(s:swcolors))
  execute "colorscheme " . s:swcolors[s:swindex]
  redraw
  execute "colorscheme"
endfunction

map <F8> :call SwitchColor(1)<CR>
imap <F8>   <Esc>:call SwitchColor(1)<CR>

map <S-F8> :call SwitchColor(-1)<CR>
imap <S-F8> <Esc>:call SwitchColor(-1)<CR>


" press F12 to toggle showing the non-printable charactes
noremap <F12> :set list!<CR>
inoremap <F12> <Esc>:set list!<CR> 
