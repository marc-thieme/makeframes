#import "../lecture-notes.typ": *

#let all-different-theorems = init-theorems("Satz", "Definition", "Note", "Lemma", "Korollar", "Proposition", "Beispiel", "Frage", "Aufgabe")

#for theorem in all-different-theorems [
#theorem[WS21][SS22][lorem ipsum][
  #lorem(50)
]
]
