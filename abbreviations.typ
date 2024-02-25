#let all-theorems-abbreviated = {
  import "lecture-notes.typ" as lib

  for (kind, thm) in lib.all-theorems {
    (
      (kind): (name, ..exams, body) => {
        assert.eq(exams.named(), (:))
        thm(name: name, exams: exams.pos(), body)
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
