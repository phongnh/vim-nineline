if exists('g:loaded_vim_nineline') || !has('vim9script') || v:version < 900
    finish
endif

vim9script

g:loaded_vim_nineline = true

# Disable Vim Quickfix's statusline
g:qf_disable_statusline = 1

# ZoomWin
g:ZoomWin_funcref = function('nineline#zoomwin#Hook')

# Disable NERDTree statusline
g:NERDTreeStatusline = -1

augroup VimNinelineAutocmds
    autocmd!
    autocmd CmdwinEnter * set filetype=cmdline syntax=vim
augroup END

# For statusline and tabline expressions, use legacy autoload function syntax
set statusline=%!nineline#Statusline()
set tabline=%!nineline#tabline#Tabline()
