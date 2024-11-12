#let dividers-as(divider-element) = it => {
  import "layout.typ": DIVIDE-IDENTIFIER
  show figure.where(kind: DIVIDE-IDENTIFIER): divider-element

  it
}
