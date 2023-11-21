" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'luk400/vim-jukit'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Use ctrl-[hjkl] to select the active split
" https://stackoverflow.com/questions/6053301/
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
