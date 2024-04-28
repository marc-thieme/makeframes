#set heading(numbering: "1.1.1")

= low-emphasize elements
Sometimes, we like to make a categorical point which doesn't have the same weight 
as our normal theorems. 
This todo adds elements which are visually less distinct 
and spacious as the current design.
== Considerations
Make them a subkind of the normal ones?
```typst
definition.small[Inifinite Primes][...]
```
or entirely separate from
```typst
let (small-definition,) = init-small-theorems(...)
```
The former is probably more desired because it increases consistency in colors etc. 
We would still need to figure out how the numbering would work in this case.

= external color gradient handle <externalize-color-gradient>
Sometimes, we want to group theorems with common/different kinds but at the same time,
we want the color gradient to go over all of them. 
For this, we should figure out a way to externlize this. Maybe with a counter.
However, this isn't trivial as we need to figure out how many colors there will be used in total
before we can do any calculations.

= decentralize theorem definitions
Right now, we define theorems as groups through the `init-theorems` call, grouped together
by their color-gradient and kind. 
However, this is fairly arbitrary. A more flexible system would have one `init-theorem` call
for each theorem kind.
The color gradient would need to be externalized. See @externalize-color-gradient.

= make color calculation respect predefined colors
The color gradient calculated should generate colors which are plenty distinct from colors 
given by the user.
