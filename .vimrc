""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" important                                                     {{{1
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
VAMActivate argumentative
VAMActivate AutoTag
VAMActivate BBCode
VAMActivate camelcasemotion
VAMActivate Closing_Brackets
VAMActivate Emmet
VAMActivate eunuch
VAMActivate fugitive
VAMActivate LaTeX-Suite_aka_Vim-LaTeX
VAMActivate localrc
VAMActivate Modeliner
"VAMActivate rainbow_parentheses
"VAMActivate Rainbow_Parenthesis
"VAMActivate Rainbow_Parentheses_Improved
VAMActivate Rename%1928
VAMActivate racket
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
VAMActivate vim-textobj-quote
VAMActivate github:rhysd/committia.vim
VAMActivate github:ctrlpvim/ctrlp.vim
VAMActivate github:fidian/hexmode
VAMActivate github:junegunn/rainbow_parentheses.vim
VAMActivate github:robertmeta/nofrils
VAMActivate github:wesQ3/vim-windowswap
VAMActivate git:https://bitbucket.org/kisom/eink.vim.git

" plugins obsoleted by v8.0
if version < 800
  VAMActivate visual-increment
endif

runtime! ftplugin/man.vim
runtime! macros/matchit.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" moving around, searching and patterns                         {{{1
"""

" CDC = Change to Directory of Current file
command! CDC cd %:p:h
command! LCDC lcd %:p:h

" list of directory names used for file searching
" <https://youtu.be/XA2WjJbmmoM>
set path+=**

" ignore case when using a search pattern
set ignorecase

" override 'ignorecase' when pattern has upper case characters
set smartcase

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" tags                                                          {{{1
"""

" search for tags file in current directory and up
set tags+=./tags;

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" displaying text                                               {{{1
"""

" display as much of the last line as possible instead of '@'
set display+=lastline

" show the line number for each line
set number

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" syntax, highlighting and spelling                             {{{1
"""

syntax enable

" highlight current line
highlight CursorLine cterm=NONE ctermbg=17 guibg=lightcyan
set cursorline

" highlight column 70
set colorcolumn=70

" highlight characters from column 81 onwards
highlight OverLength ctermbg=darkyellow guibg=Pink
match OverLength /\%81v.*\%133v/

" highlight characters from column 133 onwards
highlight OverOverLength ctermbg=darkred guibg=LightRed
2match OverOverLength /\%133v.\+/

" enable spell checking for text-based filetypes
autocmd FileType tex setlocal spell
autocmd FileType gitcommit setlocal spell

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" multiple windows                                              {{{1
"""

" make all windows the same size when adding/removing windows
set noequalalways

" a new window is put right of the current one
set splitright

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" multiple tab pages                                            {{{1
"""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" terminal                                                      {{{1
"""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" using the mouse                                               {{{1
"""

" enable mouse mode
set mouse=a
if &term =~ '^screen' || &term =~ '^xterm'
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" GUI                                                           {{{1
"""

" highlight the line numbers grey
highlight LineNr guibg=Gray guifg=DarkRed

" vim-gitgutter sign column
highlight GitGutterAdd guibg=#558855 guifg=White ctermfg=2
highlight GitGutterChange guibg=#939355 guifg=White ctermfg=3
highlight GitGutterDelete guibg=#aa6060 guifg=White ctermfg=1
highlight GitGutterChangeDelete guibg=#9e7a5a guifg=White ctermfg=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" printing                                                      {{{1
"""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" messages and info                                             {{{1
"""

" show (partial) command keys in the status line
set showcmd
"
" show cursor position below each window
set ruler

" For vim files, :help is more useful than `man`
autocmd FileType vim setlocal keywordprg=:help

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" selecting text                                                {{{1
"""

" don't automatically interact with the system clipboard
set clipboard=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" editing text                                                  {{{1
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
""" tabs and indenting                                            {{{1
"""

" improved indenting (keeps selection)
xnoremap > >gv
xnoremap < <gv

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
""" folding                                                       {{{1
"""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" diff mode                                                     {{{1
"""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" mapping                                                       {{{1
"""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" reading and writing files                                     {{{1
"""

" keep a backup after overwriting a file
set backup

" patterns that specify for which files a backup is not made
set backupskip+=/dev/shm/*
set backupskip+=/scratch/*

" copy a backup, not move
set backupcopy=yes

" prefer to store backup files in ~/.vimtmp/bak
set backupdir=~/.vimtmp/bak//,.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" the swap file                                                 {{{1
"""

" prefer to store swp files in ~/.vimtmp/swp
set dir=~/.vimtmp/swp//,.,/var/tmp,/tmp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" command line editing                                          {{{1
"""

" prefer to store undo history in ~/.vimtmp/undo
set undodir=~/.vimtmp/undo//,.,/var/tmp,/tmp

" command-line completion shows a list of matches
set wildmenu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" executing external commands                                   {{{1
"""

" Vim-LaTeX compile to PDF
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='dvi,pdf'

" Use biber instead of bibtex
let g:Tex_BibtexFlavor='biber'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" running make and jumping to errors                            {{{1
"""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" language specific                                             {{{1
"""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" multi-byte characters                                         {{{1
"""
set encoding=utf-8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" various                                                       {{{1
"""

" Use <F3> to invoke CtrlP instead of the default <C-p>
let g:ctrlp_map = '<F3>'

" For Rainbow_Parentheses_Improved
let g:rainbow_active = 0

" Emmet
" activate only for HTML and XML, and only for normal mode
let g:user_emmet_mode='n'
let g:user_emmet_leader_key='<Leader>e'
let g:user_emmet_install_global = 0
autocmd FileType html,xml EmmetInstall

""" Credits go to Doug Ireton for inspiring the layout of this .vimrc
""" <https://web.archive.org/web/20161129224221/http://dougireton.com/blog/2013/02/23/layout-your-vimrc-like-a-boss/>
""" See :options for details.

" vim: set fdm=marker :
