" Scrolling. Text selection.
set mouse=a

" disable command-t for non-os x systems for the time being
" if !has('mac')
"   let g:pathogen_disabled = ['command-t']
" endif

" delimitmate is stupid and broken
let g:pathogen_disabled = ['delimitmate']

" pathogen magic
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" reset leader (default \)
let mapleader=","

" screw vi
set nocompatible

" Add the g flag to search/replace by default
set gdefault

" Show the filename in the window titlebar
set title

set number
set ruler
syntax on

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Be able to arrow key and backspace across newlines
set backspace=eol,start,indent
set whichwrap=bs<>[]

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Status bar
set laststatus=2

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" Command-T configuration
let g:CommandTMaxHeight=20

if has("autocmd")
  " Remember last location in file
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
  
  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
endif

function s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

" make uses real tabs
au FileType make set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

au BufRead,BufNewFile *.txt call s:setupWrapping()

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Make NERDCommenter match TextMate's commenting shortcut
map <Leader>/ <plug>NERDCommenterToggle

" screw help
map <F1> :nohl<CR>
imap <F1> <ESC>:nohl<CR> i

" OMG -- for when you forget to sudo vim ...
" ...actually wtf it totally doesn't work
" cmap w!! %!sudo tee > /dev/null %

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Use modeline overrides
set modeline
set modelines=10

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" Delete line with CTRL-K
map  <C-K>      dd
imap <C-K>      <C-O>dd

" Format the current paragraph according to
" the current 'textwidth' with CTRL-J:
nmap <C-J>      gqap
vmap <C-J>      gq
imap <C-J>      <C-O>gqap

" Tabs
map <Leader>tp :tabp<CR>
map <Leader>tn :tabnext<CR>

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Show (partial) command in the status line
set showcmd

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

if has("autocmd")
	" language-specific indentation settings
	autocmd FileType c,cpp				      setlocal ts=4 sts=4 sw=4 et tw=80 nowrap
	autocmd FileType sh,csh,tcsh,zsh	  setlocal ts=4 sts=4 sw=4 et
	autocmd FileType php,javascript,css	setlocal ts=4 sts=4 sw=4 et
	autocmd FileType text,txt,mkd		    setlocal ts=4 sts=4 sw=4 et tw=80 wrap

  autocmd FileType html,xhtml,xml		  setlocal ts=2 sts=2 sw=2 et
	autocmd FileType ruby,eruby,yaml	setlocal ts=2 sts=2 sw=2 et
	autocmd FileType scm,sml,lisp			    setlocal ts=2 sts=2 sw=2 et tw=80 nowrap

	" language-specific general settings
	autocmd FileType php noremap <C-M> :w!<CR>:!php %<CR>		" run file
	autocmd FileType php noremap <C-L> :w!<CR>:!php -l %<CR>	" check syntax
endif

syntax enable "Enable syntax hl
"set background=dark
set t_Co=256
if has("gui_running") || $TERM=="xterm-256color"
    set t_Co=256
    set guioptions-=T
    colorscheme sunburst
    set nonu
    "highlight OverLength ctermbg=209 ctermfg=0 guibg=#592929
    "match OverLength /\%81v.\+/
else "Had to do this in order to continue to allow syntax highlighting on non-
     "xterm-256color and non-GUI vims.  On OS X, the entire file flashes
     "if this is not set.
    set t_Co=256
    colorscheme sunburst
    set nonu
    "highlight OverLength ctermbg=red ctermfg=black
    "match OverLength /\%81v.\+/
endif

set number

" Making without 'Press enter to continue.'
:ab maker make<CR><CR>

" Quick compiling
nmap ;; :wa\|maker<cr>

imap jj <Esc>

command Rtrim call <SID>RightTrim()
function <SID>RightTrim()
  :% s/\s*$//g
  nohl
endfunction

" Map double-tap Esc to clear search highlights
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

set pastetoggle=<F2>
map - :NERDTreeToggle<CR>

" write files you opened without the necessary permissions with :w!!
cmap w!! %!sudo tee > /dev/null %

autocmd BufNewFile,BufRead *.scss             set ft=scss

vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **<left><left><left><left>

map <leader>n :cn<cr>
map <leader>p :cp<cr>

noremap <leader>t :CommandT<cr>

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>

" Smart paste
imap <Leader>v <C-O>:set paste<CR><C-r>*<C-O>:set nopaste<CR>

