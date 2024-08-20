#import "styling.typ": break-page-after-chapters
#import "theorems.typ" : init-theorems, styles

#let zb = $dot.circle$
#let vs = $quad <--> quad$

#let induction-base() = linebreak(justify: true) + underline[_Base Case_] + [ : ]
#let induction-step(variable) = linebreak(justify: true) + [#underline[_Induction Step_] : $variable arrow.r.curve variable + 1$.]
#let induction-assume() = linebreak(justify: true) + underline[_Assume_] + [ : ]

#let separate() = line(length: 100%, stroke: (dash: "dashed", paint: gray, thickness: 0.2pt))


#let proof-styling(thm) = block(breakable: true, {
  let pfalsearams = lemmify.get-theorem-parameters(thm)
  emph[Proof.]
  [ ] + params.body
  h(1fr)
  box(scale(160%, origin: bottom + right, sym.square.stroked))
})

#let proof(body) = block(breakable: true, {
  emph[Proof.]
  [ ] + body
  h(1fr)
  box(scale(160%, origin: bottom + right, sym.square.stroked))
})

#let rules(body) = {
  show table: set align(center)
  set table(inset: 0.7em)

  // Insert the 0-space to avoid infinit recursion
  show regex("\biff\b"): (_) => [_if#h(0pt)f_]
  show regex("\bgdw\b"): (body) => [_gd#h(0pt)w_]
  show regex("\bGdw\b"): (body) => [_Gd#h(0pt)w_]
  show regex("\bAssume\b"): (body) => [_Assum#h(0pt)e_]

  body
}

#let project(title, professor, author, body) = {
  import "styling.typ" as styling
  let time = datetime.today().display("[day].[month].[year]")
  let abstract = []

  show: rules

  styling.note-page(title, author, professor, author, time, abstract, body)
}
