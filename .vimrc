""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" important
"""

" force vim behaviour
set nocompatible

" filetypes
filetype plugin on
filetype indent on

" use xterm behaviour
behave xterm

" vim-addon-manager (VAM) setup
" <https://github.com/MarcWeber/vim-addon-manager>
fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'

  " Force your ~/.vim/after directory to be last in &rtp always:
  " let g:vim_addon_manager.rtp_list_hook = 'vam#ForceUsersAfterDirectoriesToBeLast'

  " most used options you may want to use:
  " let c.log_to_buf = 1
  " let c.auto_install = 0
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif

  " This provides the VAMActivate command, you could be passing plugin names, too
  call vam#ActivateAddons([], {})
endfun
call SetupVAM()

" activate plugins
VAMActivate abolish
VAMActivate AutoTag
VAMActivate BBCode
VAMActivate camelcasemotion
VAMActivate Closing_Brackets
VAMActivate LaTeX-Suite_aka_Vim-LaTeX
VAMActivate Modeliner
VAMActivate rainbow_parentheses
VAMActivate Rename%1928
VAMActivate repeat
VAMActivate Scratch
VAMActivate Solarized
VAMActivate surround
VAMActivate Tabular
VAMActivate The_NERD_Commenter
VAMActivate vim-fake
VAMActivate vim-gitgutter
"VAMActivate vimlatex
VAMActivate vimproject
VAMActivate vim-signature
VAMActivate visual-increment
VAMActivate github:rhysd/committia.vim
VAMActivate github:ctrlpvim/ctrlp.vim
VAMActivate github:fidian/hexmode

runtime! ftplugin/man.vim
runtime! macros/matchit.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" moving around, searching and patterns
"""

" CDC = Change to Directory of Current file
command! CDC cd %:p:h
command! LCDC lcd %:p:h

" ignore case when using a search pattern
set ignorecase

" override 'ignorecase' when pattern has upper case characters
set smartcase

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" tags
"""

" search for tags file in current directory and up
set tags+=./tags;

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" displaying text
"""

" display as much of the last line as possible instead of '@'
set display+=lastline

" show the line number for each line
set number

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" syntax, highlighting and spelling
"""

syntax enable

" highlight current line
highlight CursorLine cterm=NONE ctermbg=17 guibg=lightcyan
set cursorline

" highlight column 70
set colorcolumn=70

" highlight characters from column 81 onwards
highlight OverLength ctermbg=darkblue guibg=LightBlue
match OverLength /\%81v.*\%132v/

" highlight characters from column 133 onwards
highlight OverOverLength ctermbg=darkred guibg=LightRed
match OverOverLength /\%133v.\+/

" highlight spelling mistakes for TeX documents
autocmd FileType tex setlocal spell

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" multiple windows
"""

" make all windows the same size when adding/removing windows
set noequalalways

" a new window is put right of the current one
set splitright

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" multiple tab pages
"""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" terminal
"""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" using the mouse
"""

" enable mouse mode
set mouse=a
if &term =~ '^screen' || &term =~ '^xterm'
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" GUI
"""

" highlight the line numbers grey
highlight LineNr guibg=Gray guifg=DarkRed

" vim-gitgutter sign column
highlight GitGutterAdd guibg=#558855 guifg=White ctermfg=2
highlight GitGutterChange guibg=#939355 guifg=White ctermfg=3
highlight GitGutterDelete guibg=#aa6060 guifg=White ctermfg=1
highlight GitGutterChangeDelete guibg=#9e7a5a guifg=White ctermfg=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" printing
"""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" messages and info
"""

" show (partial) command keys in the status line
set showcmd
"
" show cursor position below each window
set ruler

" For vim files, :help is more useful than `man`
autocmd FileType vim setlocal keywordprg=:help

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" selecting text
"""

" also use primary selection
set clipboard=unnamed,autoselect

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" editing text
"""

" break undo sequence for destructive insert mode commands
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" make Y work like C and D
nnoremap Y y$

set omnifunc=syntaxcomplete#Complete

set dictionary+=/usr/share/dict/words

" delete newlines in insert mode (sane backspace)
set backspace=indent,eol,start

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" tabs and indenting
"""

" improved indenting (keeps selection)
vnoremap > >gv
vnoremap < <gv

" expand <Tab> to spaces in Insert mode
set expandtab

" copy the indent of the previous line
set autoindent
set copyindent

" use 2 spaces for each step of (auto)indent
set shiftwidth=2

" inserting tabs inserts 4 spaces
set softtabstop=4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" folding
"""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" diff mode
"""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" mapping
"""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" reading and writing files
"""

" keep a backup after overwriting a file
set backup

" prefer to store backup files in ~/.vimtmp/bak
set backupdir=~/.vimtmp/bak,.

" copy a backup, not move
set backupcopy=yes

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" the swap file
"""

" prefer to store swp files in ~/.vimtmp/swp
set dir=~/.vimtmp/swp,.,/var/tmp,/tmp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" command line editing
"""

" prefer to store undo history in ~/.vimtmp/undo
set undodir=~/.vimtmp/undo,.,/var/tmp,/tmp

" command-line completion shows a list of matches
set wildmenu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" executing external commands
"""

" Vim-LaTeX compile to PDF
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='dvi,pdf'

" Use biber instead of bibtex
let g:Tex_BibtexFlavor='biber'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" running make and jumping to errors
"""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" language specific
"""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" multi-byte characters
"""
set encoding=utf-8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" various
"""

" Use <F3> to invoke CtrlP instead of the default <C-p>
let g:ctrlp_map = '<F3>'

""" Credits go to Doug Ireton for inspiring the layout of this .vimrc
""" <http://dougireton.com/blog/2013/02/23/layout-your-vimrc-like-a-boss/>
""" See :options for details.
