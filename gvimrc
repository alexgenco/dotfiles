if filereadable("~/.vimrc")
  so ~/.vimrc
endif

colorscheme molokai
"colorscheme solarized
set guifont=Courier_New:h16

set cursorline

" for mapping ctrlp to CMD-t
macmenu &File.New\ Tab key=<D-S-t>