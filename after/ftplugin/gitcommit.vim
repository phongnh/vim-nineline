vim9script

setlocal statusline=%<[Commit\ Message]%=%(%{&spell?nineline#Spelllang():''}\ %)%4l:%-3c\ %P
