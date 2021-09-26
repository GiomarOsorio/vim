" Vim settings and mappings
" You can edit them as you wish

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

autocmd FileType coffee,javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType html,htmldjango,xhtml,haml setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
autocmd FileType sass,scss,css setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120

" turn relative line numbers on
set rnu
set number

"set autoreload
set autoread

" remove ugly vertical lines on window division
set fillchars+=vert:\ 

" set leader key
nnoremap <SPACE> <Nop>
let mapleader=" " 

"source nvim config
nnoremap <silent><leader>1 :source ~/.config/nvim/init.vim \| :PlugInstall<CR>

" tab navigation mappings
map tt :tabnew<CR>
map <tab> :tabn<CR>
"imap <leader>n <ESC>:tabn<CR>
map <leader><tab> :tabp<CR>
"imap <leader>p <ESC>:tabp<CR>

" window navigation mappings
nmap <leader>l <C-W><C-L><ESC>
imap <leader>l <ESC><C-W><C-L><ESC>   
nmap <leader>h <C-W><C-H><ESC>
imap <leader>h <ESC><C-W><C-H><ESC>   
nmap <leader>k <C-W><C-K><ESC>
imap <leader>k <ESC><C-W><C-K><ESC>
nmap <leader>j <C-W><C-J><ESC>
imap <leader>j <ESC><C-W><C-J><ESC>   

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" integrated terminal
" open new split panes to right and below
"set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
nnoremap <leader>t :tabnew \| :terminal<CR> 
" scroll foat Windows
if has('nvim-0.4.3') || has('patch-8.2.0750')
    nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
endif
