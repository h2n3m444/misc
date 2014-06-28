execute pathogen#infect()
set t_Co=256

"Disable beep
set noeb vb t_vb=
au GUIEnter * set vb t_vb=

"Copy filename to clipboard
set clipboard=unnamed

let mapleader=","

nmap <Leader>cf :let @*=expand("%")<CR>
nmap <Leader>cff :let @*=expand("%:p")<CR>

cmap P4e !p4 edit %
cmap P4r !p4 revert %
cmap P4l !p4 login
"vi -t IO_EXPDR_REG_GP0"
"Open Vim at TAG works with CTAGS and current cscope"

"Control-n, Control-p in Insertion Mode for auto completion menu"
" set wildmode=longest,list,full
" set wildmenu
"Some modification to auto completion menu"

"To change two vertically split windows to horizonally split
"    ^Wt^WK
"Horizontally to vertically:
"    ^Wt^WH
"where ^W means hit Ctrl-W. Explanations:
"    ^Wt     makes the first (topleft) window current
"    ^WK     moves the current window to full-width at the very top
"    ^WH     moves the current window to full-height at far left

set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set cindent         " Auto-indent mode understands most TMM indentation styles.
set tw=80           " Auto-wrap a bit before column 80.
set expandtab       " Expand tabs to spaces.
set softtabstop=4   " Use soft tabs, indenting at 4 spaces.

"set paste           " When pasting code into a vim session, the paste option
set nopaste         " disables all text-formatting, and allows you to paste
                    " literal text.  Nopaste disables.
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set nobackup
set noswapfile
retab               " The retab command will explicitly convert all tabs in
                    " the current buffer to soft-tabs.
set pastetoggle=<F2>
nmap <F3> :set invnumber<CR> 
nmap <F4> :TagbarToggle<CR>

set list
" set listchars=trail:.,extends:#,nbsp:.
set listchars=tab:>-,trail:~,extends:>,precedes:<

" set dictionary+=/usr/share/dict/words
set complete-=k complete+=k " acknow<CTRL-N><CTRL-N>

" you can change the color used for the line numbers.
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
hi Search cterm=NONE ctermfg=lightblue ctermbg=darkgrey

"(2) By default, Vim displays the current line of each minimized file, which
"(to me) isn't much help and takes up too much screen real estate. I use this
"line in my .vimrc: 
set wmh=0

"Map normal mode space to 'zz' which center the screen at cursor
nmap <space> zz

"No keypressing -- focus-follows-mouse for gvim, in _gvimrc 
"set mousefocus
"set mouse=a

"minibufexpl
"http://www.vim.org/scripts/script.php?script_id=159
"let g:miniBufExplMapWindowNavVim = 1 
"let g:miniBufExplMapWindowNavArrows = 1 
"let g:miniBufExplMapCTabSwitchBufs = 1 
"let g:miniBufExplModSelTarget = 1 
"noremap <silent> <F2> :TMiniBufExplorer<CR>

noremap <A-left> :bprevious<CR>
noremap <A-Right> :bnext<CR>
noremap <A-Up> <C-w>w
noremap <A-Down> <C-w>p

nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

set fileformat=unix

"Overload Copy
"noremap <C-c> "+y
"noremap <C-v> "+p
"noremap y "+y
"noremap p "+p
"noremap Y "+Y
"noremap P "+P
"noremap d "+d
"noremap dd "+dd

" FIX colorscheme's messed up tab menu color
hi Pmenu        cterm=none ctermfg=White     ctermbg=Black
hi PmenuSel     cterm=none ctermfg=Black     ctermbg=DarkGreen
hi PmenuSbar    cterm=none ctermfg=none      ctermbg=Green
hi PmenuThumb   cterm=none ctermfg=DarkGreen ctermbg=DarkGreen

"This autocmd changes the window-local current directory to be the same as the directory of the current file. 
"This doesn't work for cscope which only creates a DB file in the home directory
"Once present directory change, we lose scope of that DB file
"autocmd BufEnter * silent! lcd %:p:h

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim           
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE: 
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE: 
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
"    if filereadable("cscope.out")
"        cs add cscope.out  
    " else add the database pointed to by environment variable 
"    elseif $CSCOPE_DB != ""
"        cs add $CSCOPE_DB
"    endif

    " show msg when any other cscope db added
    set cscopeverbose  


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.  
    "

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>	

    nmap <C-\><C-\>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\><C-\>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\><C-\>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\><C-\>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\><C-\>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\><C-\>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-\><C-\>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-\><C-\>d :scs find d <C-R>=expand("<cword>")<CR><CR>	


    " Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout 
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout 
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100

endif

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

let g:tagbar_autofocus = 1

let g:airline_theme='simple'
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_detect_iminsert=0
let g:airline_inactive_collapse=1

let g:airline#extensions#tagbar#enabled = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

let g:airline#extensions#ctrlp#show_adjacent_modes = 1

"let g:bufferline_echo = 0
"let g:airline#extensions#bufferline#enabled = 1 "plugin disabled

set laststatus=2

