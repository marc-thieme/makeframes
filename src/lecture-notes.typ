#import "styling.typ": break-page-after-chapters
#let project
#let (
  theorem,
  corollary,
  lemma,
  definition,
  example,
  remark,
  proposition,
  notation,
  proof,
) = {
  let theorem-color = red.lighten(70%)
  let kind-color-map = (
    "theorem": theorem-color,
    "lemma": theorem-color.rotate(200deg).lighten(30%),
    "definition": theorem-color.rotate(95deg),
    "remark": theorem-color.rotate(30deg).saturate(5%),
    "example": gray.lighten(60%),
    "corollary": theorem-color.rotate(150deg),
    "proposition": theorem-color.rotate(60deg),
    "notation": theorem-color.rotate(280deg),
  )

  import "../external/lemmify/src/export-lib.typ" as lemmify

  let colored_styling_exams(thm) = block(
    breakable: true,
    {
      let params = lemmify.get-theorem-parameters(thm)
      let number = (params.numbering)(thm, false)
      let color = params.tags.color
      let exams = params.tags.at("exams", default: ())

      let namebox
      if params.name != none {
        namebox = box(inset: .5em, fill: color, stroke: color, params.name)
        namebox
      }

      if type(exams) != array {
        exams = (exams,)
      }
      for exam in exams {
        // The " " to have text in original font size so the size of the box is correct
        box(inset: .5em, stroke: color, " " + text(size: 9pt, exam))
      }
      h(1fr)
      box(inset: .5em)[#params.kind-name #number]

      v(0pt, weak: true)
      block(width: 100%, inset: 1em, stroke: color + 1pt, params.body)
    },
  )

  let proof_styling(thm) = block(breakable: true, {
    let params = lemmify.get-theorem-parameters(thm)
    emph[Proof.]
    [ ] + params.body
    h(1fr)
    box(scale(160%, origin: bottom + right, sym.square.stroked))
  })

  let init-theorem-kinds(lang: "de") = {
    let (..theorems, theorem-rules) = lemmify.default-theorems(
      style: colored_styling_exams,
      proof-style: proof_styling,
      tags: (exams: (), color: white),
      lang: "de",
    )

    theorems.notation = lemmify.theorem-kind(
      "Notation",
      group: "LECTURE-NOTES-CUSTOM-GROUP",
      style: colored_styling_exams,
      tags: (exams: (), color: white),
    )

    for (kind, theorem) in theorems.pairs() {
      let colored-theorem = theorem.with(color: kind-color-map.at(kind, default: white))
      theorems.insert(kind, colored-theorem)
    }

    return (..theorems, theorem-rules: theorem-rules)
  }
  let (..theorems-and-proof, theorem-rules) = init-theorem-kinds()

  let _project(title, professor, author, body) = {
    import "styling.typ" as styling
    let time = datetime.today().display("[day].[month].[year]")
    let abstract = []

    show table: set align(center)
    set table(inset: 3mm)

    // Insert the 0-space to avoid infinit recursion
    show regex("\biff\b"): (body) => [_if#h(0pt)f_]
    show regex("\bAssume\b"): (body) => [_Assum#h(0pt)e_]

    show: theorem-rules

    styling.note-page(title, author, professor, author, time, abstract, body)
  }
  project = _project
  theorems-and-proof
}
