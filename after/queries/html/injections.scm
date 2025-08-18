; Inject Haskell inside `{ ... }` segments within HTML (used by HSX bodies)
; Trims the surrounding braces so the Haskell parser gets only the expression
(
  (text) @injection.content
  (#match? @injection.content "^\s*\{[\s\S]*\}\s*$")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "haskell")
  (#set! injection.combined true)
)

(
  (attribute_value) @injection.content
  (#match? @injection.content "^\s*\{[\s\S]*\}\s*$")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "haskell")
  (#set! injection.combined true)
)

; Some HTML parsers represent unexpected braces as ERROR nodes; cover that too
(
  (ERROR) @injection.content
  (#match? @injection.content "^\s*\{[\s\S]*\}\s*$")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "haskell")
  (#set! injection.combined true)
)

; raw_text nodes (between tags) can also contain HSX expressions
(
  (raw_text) @injection.content
  (#match? @injection.content "^\s*\{[\s\S]*\}\s*$")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "haskell")
  (#set! injection.combined true)
)
