#import "../lecture-notes.typ": *

#show: project.with("Graph Theory", "Prof. Dr. Martin", "Marc Thieme")

#let w17(..tasks) = [WS17:#(tasks.pos().map(str).join(","))]
#let w19(..tasks) = [WS19:#(tasks.pos().map(str).join(","))]
#let s20(..tasks) = [SS20:#(tasks.pos().map(str).join(","))]
#let w21(..tasks) = [WS21:#(tasks.pos().map(str).join(","))]
#let s22(..tasks) = [SS22:#(tasks.pos().map(str).join(","))]

// Summary for exam preparation

= Theorems
#theorem(
  name: "Hall",
  exams: w19(4),
)[
  Let $G$ be a bipartite graph with partite sets $A$ and $B$. Then $G$ has a
  matching containing all vertices of $A$ if and only if $|N(S)|>=|S|$ for all $S subset.eq A$.
]
== Hlel
#theorem(
  name: "König",
  exams: (w19(5), w21(2)),
)[
  Let $G$ be bipartite. The size of the largest matching is the same as the size
  of a smallest vertex cover.
]
=== Hlel
#theorem(
  name: "Min degree path",
  exams: s20(2),
)[
  If a graph $G$ has minimum degree $delta(G) >= 2$, then $G$ has a path of length
  $delta(G)$ and a cycle with at least $delta(G) + 1$ vertices.
]
#lemma(name: "Extremal number for cycles", exams: w21(5))[
  Every graph $G$ with $|E(G)| > |G|$ contains a cycle.
]
#proposition(
  name: "Dirac",
  exams: w17(1, 7),
)[
  Every graph with $n>=3$ vertices and minimum degree at least $n/2$ has a
  Hamiltonian cycle.
]
#corollary(name: "Tutte's", exams: w17(1))[
  A graph $G$ has a perfect matching
  $q(G - S) <= |S| quad forall S subset.eq V$\
  where $q(G-S)$ denotes the number of odd components of $G - S$
]

= Theorems from other fields
#remark(
  name: "Pigeonhole Principle",
  exams: w17(6),
)[
  When $m$ items are put into $n$ containers with $m>n$, then at least one
  container receives more than one item.
]
#theorem(name: "Probability", exams: s20(6))[
  $
    PP(A sect B) = PP(A) + PP(B) - PP(A union B) = PP(A|B) dot PP(B)
  $
]
#theorem(name: "Linearity of expectation", exams: w21(7))[
  $E[alpha X + Y] = alpha E[X] + E[Y]$
]
#theorem(name: "Max of random variables", exams: w19(6))[
  $PP(max{X, Y} < c) = PP(X < c, Y < c)$
]

= Definitions
#definition(
  name: "L-list-colorable",
  exams: w17(3),
)[
  Let $L(v) subset.eq NN$ be a list of colors for each vertex $v in V$. We say
  that $G$ is _L-list-colorable_ if there is a coloring $c : V -> NN$ such that
  $c(v) in L(v)$ for each $v in V$ and adjacent vertices receive different colors.
]
#definition(
  name: "k-list-colorable",
  exams: w17(3),
)[
  Let $k in NN$. We say that $G$ is _k-list-colorable_ if $G$ is _L-list-colorable_
  for each list $L$ with $|L(v)| = k quad forall_(v in V)$.
]
#notation(name: "Vertex and Edge sets")[
  We use $E(G)$ do denote its edge set and $V(G)$ to denote its vertex set.
]
#definition(
  name: "Eulerian tour",
  exams: w17(7),
)[
  An _eulerian_ tour is a closed walk that traverses every edge exactly once.
]
#definition(name: "Eulerian", exams: w17(7))[
  A graph is _eulerian_ if it contains an eulerian tour.
]
#definition(
  name: "Connectivity",
  exams: s20(4),
)[
  The maximum $k$ for which $G$ is connected is called its connectivity $kappa(G)$.
]

= Aufgaben
#example(
  name: "Chromatic Number, Planar Graph with girth 6",
  exams: w19(3),
)[
  Let G be a planar graph of girth at least 6. Prove that the chromatic number of
  G is at most three
]
#proof[
  We shall use induction on |V (G)|, with trivial base cases |V (G)| = 1, 2. Now,
  let G be a planar graph of girth at least 6 with n := |V (G)| > 2, and suppose
  the result holds for smaller values of n. We may assume that G is 2-connected:
  otherwise, we apply the induction hypothesis to the blocks of G. We claim that G
  contains a vertex of degree at most 2. Indeed, suppose that G has m edges, and $l$ faces
  and observe that
  $
    2m = ∑_(i∈N) i · f_i
  $
  where fi denotes the number of faces with precisely i edges in their boundary.
  This holds since G is 2-connected, and therefore every edge lies on the boundary
  of precisely two faces (a result from lecture). Since G has girth 6, we note
  that ∑ i∈N i · fi ≥ 6$l$, and therefore $l$ ≤ m/3.\
  Now, Euler’s formula implies that 2 = n − m + $l$ ≤ n − 2m/3, and so we obtain
  $
    m ≤ 3n/2 − 3.
  $Since ∑ v∈V (G) deg(v) = 2m < 3n, there must exist a vertex of degree at most
  2. Let v be a vertex of degree at most two. Then G − v is still planar with
  girth at least 6, so by induction there is a 3-coloring of G − v. Giving v a
  color not appearing in its neighborhood, we obtain a 3-coloring of G, completing
  the proof.
]

#example(
  name: "Fan Lemma",
  exams: s20(2),
)[
  One particular consequence of Menger’s theorem is the fan lemma: If k ≥ 1 is an
  integer and G is a k-connected graph, then for every U ⊂ V (G) with |U | = k and
  every x ∈ V (G) \ U there exists a collection of k paths from x to U that only
  have the vertex x in common. Use the fan lemma to prove that for every integer k
  ≥ 2, any k-connected graph of order at least 2k contains a cycle of length at
  least 2k.
]
#proof[
  Consider a longest cycle C. If V (C) = V (G), then we are done since |V (G)| ≥
  2k by assumption. Otherwise, we may choose a vertex x ∈ V (G) \ V (C). Since G
  is k-connected, every vertex of G has degree at least k ≥ 2. In particular, this
  implies that G contains a cycle of length at least k + 1 (by considering a
  longest path). Thus, |V (C)| ≥ k + 1. We now aim to apply the fan lemma. Pick a
  subset U ⊂ V (C) of size k. The fan lemma implies that there are k paths P1, . .
  . , Pk from x to U that only have the vertex x in common. For each path Pi, let
  si denote the first vertex in Pi that intersects V (C). In particular, the
  vertices s1, . . . , sk are pairwise distinct. Without loss of generality,
  assume they are arranged as s1, s2, . . . , sk clockwise along C. We claim that
  si and si+1 are not consecutive on C for any i = 1, . . . , k (computed modulo
  k). Indeed, fix vertices si and si+1. If they are consecutive along C, then the
  cycle xPi+1si+1CsiPix (following C clockwise) is longer than C, a contradiction.
  It follows that there is at least one vertex between si and si+1, and hence |V
  (C)| ≥ 2k as required.
]

