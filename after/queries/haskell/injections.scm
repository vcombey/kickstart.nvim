; Treat [hsx| ... |] quasiquotes as HTML for highlighting
(
  (quasiquote
    (quoter) @quoter
    (quasiquote_body) @injection.content
    (#match? @quoter "^hsx$")  ; only when the quoter is `hsx`
  )
  (#set! injection.language "html")
)
