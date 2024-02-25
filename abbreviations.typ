#let all-theorems-abbreviated = {
  import "lecture-notes.typ" as lib

  for (kind, thm) in lib.all-theorems {
    (
      (kind): (name, ..exams, body) => {
        thm(name: name, exams: exams.pos(), ..exams.named(), body)
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
