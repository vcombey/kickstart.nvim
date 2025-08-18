if &l:filetype ==# 'haskell'
  syntax include @HASKELL syntax/haskell.vim
  syntax region hsxHaskell matchgroup=Delimiter start=/{/ end=/}/ contains=@HASKELL keepend containedin=ALL
endif
