"Pathogen setup
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()



filetype plugin on
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'

au BufWritePost *.tex silent call Tex_RunLaTeX()
au BufWritePost *.tex silent !pkill -USR1 xdvi.bin
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf='xelatex -interaction=nonstopmode $*'

syntax on
set noerrorbells visualbell t_vb= "Shut the hell up, vim
set mouse=a             "Enable mouse interaction
set nofoldenable        "Disable folding

"set tabstop=4
"set expandtab
"set sw=4
setglobal modeline

set t_Co=256
colorscheme Tomorrow-Night


"Mappings
nmap <C-e> :e#<CR>
map <C-n> :NERDTreeToggle<CR>
"Turn on spell check with F8
map <F8> :setlocal spell! spelllang=en_au<CR>

"Ctrl-P
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'

let NERDTreeIgnore = ['\.pyc$']
