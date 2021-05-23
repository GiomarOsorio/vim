" Start ======================================================================
source $HOME/.config/nvim/config/start.vim

" Configuration ==============================================================
" Gruvbox --------------------------------------------------------------------
source $HOME/.config/nvim/config/plug/gruvbox.vim
" NERDTree -------------------------------------------------------------------
source $HOME/.config/nvim/config/plug/nerdtree.vim
" Signify --------------------------------------------------------------------
source $HOME/.config/nvim/config/plug/vim-signify.vim
" Airline --------------------------------------------------------------------
source $HOME/.config/nvim/config/plug/airline.vim
" Tagbar ---------------------------------------------------------------------
source $HOME/.config/nvim/config/plug/tagbar.vim
" COC ------------------------------------------------------------------------
source $HOME/.config/nvim/config/plug/coc.vim
" Fzf ------------------------------------------------------------------------
source $HOME/.config/nvim/config/plug/fzf.vim

" General --------------------------------------------------------------------
source $HOME/.config/nvim/config/general.vim

if vim_plug_just_installed
    echo "reload to install coc extensions"
    :source $MYVIMRC
endif 
