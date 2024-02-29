#let all-theorems-abbreviated = {
  import "lecture-notes.typ" as lib

  for (kind, thm) in lib.all-theorems {
    (
      (kind): (body-or-name, ..exams) => {
        let named-args = exams.named()
        if exams.pos() == () {
          thm(exams: exams.pos(), ..named-args, body-or-name)
        } else {
          let (..exams, body) = exams.pos()
          thm(name: body-or-name, exams: exams, ..named-args, body)
        }
      },
    )
  }
}
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
) = all-theorems-abbreviated
