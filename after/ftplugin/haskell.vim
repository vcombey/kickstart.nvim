if exists('b:hsx_syntax_loaded') | finish | endif
let b:hsx_syntax_loaded = 1
syntax include @HSXHTML syntax/html.vim
syntax include @HSXHASK syntax/haskell.vim
syntax region hsxBlock matchgroup=Delimiter start=/\[hsx\|/ end=/\|\]/ contains=@HSXHTML,hsxHaskellExpr keepend transparent
syntax region hsxHaskellExpr matchgroup=Delimiter start=/{/ end=/}/ contains=@HSXHASK keepend contained containedin=hsxBlock
