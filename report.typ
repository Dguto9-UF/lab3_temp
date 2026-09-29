#import "@preview/k-mapper:1.4.0": *

#set enum(numbering: "a.")

#set page(
  paper: "us-letter",
  margin: (top: 2.3in),
  header: [
    #grid(
      columns: (1fr, 1fr),
      image("images/ecelogo.png", height: 0.8in),
      align(right)[
        Dillon Gutowski \
        9/27/2026 \
        #strong(text(fill: rgb("1F497D"))[EEL3701C - Fall 2026])
      ]
    )
  ],
  numbering: (current, total) => [Page #current],
  number-align: right
)

#set text(
  font: "Helvetica",
  size: 12pt,
)

#show heading: set text(fill:rgb("1F497D"))

#show heading.where(level: 1): it => [
  #align(center)[
    #strong(it.body)
  ]
  #v(0.5em)
]

#show heading.where(level: 2): it => [
  #strong(it.body)
  #v(-0.75em)
  #line(length: 100%, stroke: rgb("1F497D"))
]

= Lab 3: Sequential Logic and Counters
== Requirements Not Met
N/A

== Problems Encountered

== Applications

#pagebreak()

#let nt(con) = $overline(#con) #h(0.1em)$

#let truth_table(incolumns, outcolumns, ..cells) = {
  let table_cells = incolumns + (table.vline(stroke: 3pt + gray),) + outcolumns + cells.pos().map(val => {
    if val == 0 {
      table.cell(fill: black, align(center)[#text(fill:white)[0]])
    } else if val == 1 {
      table.cell(fill: white, align(center)[1])
    } else if val == "X" {
      table.cell(fill: gray, align(center)[X])
    }
    else {
      val
    }
  })
  text(font: "JetBrainsMono NF", table(columns: incolumns.len() + outcolumns.len(), ..table_cells))
}

#let kmap_2x2(x_lab, y_lab, x0y0, x1y0, x0y1, x1y1) = {
  let empty = table.cell(stroke:none)[]
  let head(n) = table.cell(stroke:none)[#n]
  let content(n) = if n == 0 {
    table.cell(align: center, fill: black)[#text(fill: white, font: "JetBrainsMono NF")[#n]]
  } else if n == 1 {
    table.cell(align: center)[#text(font: "JetBrainsMono NF")[#n]]
  }
  let nt(n) = overline(n)
  let table_cells = (empty,head(nt(x_lab)),head(x_lab),head(nt(y_lab)),content(x0y0),content(x1y0),head(y_lab),content(x0y1),content(x1y1)) 
  table(columns: 3, ..table_cells)
}
#let kmap_4x4(x1_lab, x2_lab, y1_lab, y2_lab, groups,
              x0y0, x1y0, x2y0, x3y0,
              x0y1, x1y1, x2y1, x3y1,
              x0y2, x1y2, x2y2, x3y2,
              x0y3, x1y3, x2y3, x3y3,
              ) = {
  let group_color(x, y) = {
    for group in groups {
      let coords = group.at(0)
      let color = group.at(1)
      for coord in coords {
        if coord.at(0) == x and coord.at(1) == y {
          return color
        }
      }
    }
    return black
  }
  let empty = table.cell(stroke:none)[]
  let head(n) = table.cell(stroke:none)[#n]
  let content(n, x, y) = table.cell(align: center + horizon, fill: group_color(x, y))[#text(fill: white, font: "JetBrainsMono NF")[#n]]
  let nt(n) = overline()[#n #h(0.1em)]
  let s(a, b) = stack(a, b, spacing: 5pt)
  let table_cells = (
    empty,head(nt(x1_lab) + nt(x2_lab)),head(nt(x1_lab) + x2_lab),head(x1_lab + x2_lab),head(x1_lab + nt(x2_lab)),
    head(s(nt(y1_lab), nt(y2_lab))),content(x0y0, 0, 0),content(x1y0, 1, 0),content(x2y0, 2, 0),content(x3y0, 3, 0),
    head(s(nt(y1_lab), y2_lab)),content(x0y1, 0, 1),content(x1y1, 1, 1),content(x2y1, 2, 1),content(x3y1, 3, 1),
    head(s(y1_lab, y2_lab)),content(x0y2, 0, 2),content(x1y2, 1, 2),content(x2y2, 2, 2),content(x3y2, 3, 2),
    head(s(y1_lab, nt(y2_lab))),content(x0y3, 0, 3),content(x1y3, 1, 3),content(x2y3, 2, 3),content(x3y3, 3, 3),
  ) 
  table(columns: 5, ..table_cells)
}

#let kmap_2x4(x1_lab, x2_lab, y1_lab, groups,
               x0y0, x1y0, x2y0, x3y0,
               x0y1, x1y1, x2y1, x3y1,
               ) = {
  let group_color(x, y) = {
    for group in groups {
      let coords = group.at(0)
      let color = group.at(1)
      for coord in coords {
        if coord.at(0) == x and coord.at(1) == y {
          return color
        }
      }
    }
    return black
  }
  let empty = table.cell(stroke: none)[]
  let head(n) = table.cell(stroke: none, align: center + horizon)[#n]
  let content(n, x, y) = table.cell(
    align: center + horizon,
    fill: group_color(x, y),
  )[#text(fill: white, font: "JetBrainsMono NF")[#n]]
  let nt(n) = overline()[#n #h(0.1em)]
  let table_cells = (
    empty, head(nt(x1_lab) + nt(x2_lab)), head(nt(x1_lab) + x2_lab), head(x1_lab + x2_lab), head(x1_lab + nt(x2_lab)),
    head(nt(y1_lab)), content(x0y0, 0, 0), content(x1y0, 1, 0), content(x2y0, 2, 0), content(x3y0, 3, 0),
    head(y1_lab),     content(x0y1, 0, 1), content(x1y1, 1, 1), content(x2y1, 2, 1), content(x3y1, 3, 1),
  )
  table(columns: 5, ..table_cells)
}
#let nstt(incolumns, outcolumns, ..cells) = {
  let table_cells = incolumns + (table.vline(stroke: 3pt + gray),) + outcolumns + cells.pos().map(val => table.cell(align: center)[#val])

  text(font: "JetBrainsMono NF", table(
    columns: incolumns.len() + outcolumns.len(),
    fill: (_, y) => if calc.odd(y) { luma(180) } else { white },
    ..table_cells,
  ))
}

== Pre-Lab Questions
+ *When implementing an SR latch, what happens when both S=1 and R=1?*\
  When implementing a NOR SR latch, when both S=1 and R=1, both $Q$ and $nt(Q)$ will be 0. Generally, though, this behavior is dependent on implementation and not strictly defined.
+ *What is the purpose of the Clk signal?*\
  The `Clk` signal acts as a rising-edge trigger for updating the SR flip-flop, causing it to be a synchronous component. That is, rather than updating immediately with the inputs, it updates when the `Clk` is pulsed.
+ *What is the difference between a SR flip-flop and a SR latch?*\
  An SR latch is an asynchronous component, the state of which changes immediately with its inputs. An SR flip-flop is a synchronous version of this, where the inputs only propogate through the circuit and affect the outputs on the rising edge of a clock pulse.
+ *Put a NOT gate in front of the S input of the SR flip-flop, then connect the input of that gate to the R input of the flip-flop so that S and R are always at opposite logic levels. What is the relationship between this single input and the output Q?*\
  When this input is high and the clock is pulsed, Q will be driven low, since S will be low and R will be high. When this input is low, Q will be driven high since S will be high and R will be low.
+ *Now do the same thing, except put the NOT gate in front of R instead. What is the relationship between the single input and Q?*\
  Now, when the input is high and the clock is pulsed, Q will be driven high, and when the input is low and the clock is pulsed, Q will be driven low. This is the behavior of a D flip-flop.
+ *What are don't-care entries in an NSTT and why are they useful when simplifying logic?*\
+ *Why do we need flip-flops to build a counter? Why can't we build one with only combinational logic?*\
+ *Describe D, SR, JK, and T flip-flops: what inputs does each use, and how does Q change on a clock edge for each?*\
=== Part 1: SR latch & SR flip-flop
=== Part 2: 2-bit counter
#nstt(
  ("Q1", "Q0", "GO(H)"), ("Q1+", "Q0+"),
  0, 0, 0, "X", "X",
  0, 0, 1, "X", "X",
  0, 1, 0, 0, 1,
  0, 1, 1, 1, 1,
  1, 0, 0, 1, 0,
  1, 0, 1, 0, 1,
  1, 1, 0, 1, 1,
  1, 1, 1, 1, 0
)
*D0*
#karnaugh(
  "4x2",
  labels: ("GO(H)", "Q0", "Q1"),
  manual-terms: (
    "X", 0, 1, 1,
    "X", 1, 1, 0
  ),
  implicants: ((2, 3), (4, 5),),
  corner-implicants: true,
)
#let rc(n, color) = rect(stroke: 2pt + color, radius: 5pt)[#n]
$rc(nt(Q_1), #blue) + rc("GO(H)" nt(Q_0), #green) + rc(nt("GO(H)")Q_0, #red)$\
$=nt(Q_1) + ("GO(H)" xor Q_0)$

*J1*
#karnaugh(
  "4x2",
  labels: ("GO(H)", "Q0", "Q1"),
  manual-terms: (
    "X", "X", 0, "X",
    "X", "X", 1, "X",
  ),
  implicants: ((4, 6),),
)

$rc("GO(H)", #red)$

*K1*
#karnaugh(
  "4x2",
  labels: ("GO(H)", "Q0", "Q1"),
  manual-terms: (
    "X", 0, "X", 0,
    "X", 1, "X", 0,
  ),
  implicants: ((4, 5),)
)
$rc("GO(H)"nt(Q_0), #red)$
=== Part 3: 3-bit bidirectional counter with output logic
#nstt(
  ("Q2","Q1","Q0","F(H)"),("Q2+","Q1+","Q0+","Y3","Y2","Y1","Y0"),
  0, 0, 0, 0,    1, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 1,    0, 0, 1, 0, 0, 0, 0,
  0, 0, 1, 0,    0, 0, 0, 0, 0, 0, 0,
  0, 0, 1, 1,    0, 1, 1, 0, 0, 0, 0,
  0, 1, 0, 0,    "X", "X", "X", "X", "X", "X", "X",
  0, 1, 0, 1,    "X", "X", "X", "X", "X", "X", "X",
  0, 1, 1, 0,    0, 0, 1, 0, 0, 0, 0,
  0, 1, 1, 1,    1, 1, 0, 0, 0, 0, 0,
  1, 0, 0, 0,    1, 1, 0, 0, 0, 0, 0,
  1, 0, 0, 1,    0, 0, 0, 0, 0, 0, 0,
  1, 0, 1, 0,    "X", "X", "X", "X", "X", "X", "X",
  1, 0, 1, 1,    "X", "X", "X", "X", "X", "X", "X",
  1, 1, 0, 0,    0, 1, 1, 0, 0, 0, 0,
  1, 1, 0, 1,    1, 0, 0, 0, 0, 0, 0,
  1, 1, 1, 0,    "X", "X", "X", "X", "X", "X", "X",
  1, 1, 1, 1,    "X", "X", "X", "X", "X", "X", "X",
)

*D0*
#karnaugh(
  "4x4",
  labels: ("Q2", "Q1", "Q0", "F"),
  manual-terms: (
    0, 1, 0, 1,
    "X", "X", 1, 0,
    0, 0, "X", "X",
    1, 0, "X", "X",
  ),
  implicants: ((1, 3),),
  horizontal-implicants: ((4, 14),)
)
$rc(F nt(Q_2) nt(Q_1),#red) + rc(nt(F) Q_1,#green)$

*T1*
#karnaugh(
  "4x4",
  labels: ("Q2", "Q1", "Q0", "F"),
  manual-terms: (
    0, 0, 0, 1,
    "X", "X", 1, 0,
    1, 0, "X", "X",
    0, 1, "X", "X",
  ),
  vertical-implicants: ((3, 11),),
  horizontal-implicants: ((8,10),),
  implicants: ((6, 14),(13,15))
)
$rc(Q_0 F nt(Q_1),#teal) + rc(Q_0 nt(F) Q_1,#red) + rc(nt(F) nt(Q_1) Q_2,#blue) + rc(F Q_1 Q_2,#green)$\
$= Q_0(F xor Q_1) + Q_2(F dot.o Q_1)$\
*J2*
#karnaugh(
  "4x4",
  labels: ("Q2", "Q1", "Q0", "F"),
  manual-terms: (
    1, 0, 0, 0,
    "X", "X", 0, 1,
    "X", "X", "X", "X",
    "X", "X", "X", "X",
  ),
  implicants: ((0,8),(5,15)),
)
$rc(nt(Q_0) nt(F), #red) + rc(F Q_1, #green)$

*K2*
#karnaugh(
  "4x4",
  labels: ("Q2", "Q1", "Q0", "F"),
  manual-terms: (
    "X", "X", "X", "X",
    "X", "X", "X", "X",
    0, 1, "X", "X",
    1, 0, "X", "X",
  ),
  vertical-implicants: ((9,3),),
  horizontal-implicants: ((4,14),)
)
$rc(nt(F) Q_1, #red) + rc(F nt(Q_1), #green)$\
$= F xor Q_1$

#truth_table(
  ("Q2", "Q1", "Q0"), ("Y3", "Y2", "Y1", "Y0"),
  0, 0, 0,   0, 1, 0, 0,
  0, 0, 1,   0, 1, 0, 1,
  0, 1, 0,   "X", "X", "X", "X",
  0, 1, 1,   1, 0, 1, 0,
  1, 0, 0,   0, 0, 1, 0,
  1, 0, 1,   "X", "X", "X", "X",
  1, 1, 0,   1, 0, 1, 1,
  1, 1, 1,   "X", "X", "X", "X",
)

*Y0*
#karnaugh(
  "2x4",
  labels: ("Q2", "Q1", "Q0"),
  manual-terms: (0, 1, "X", 0, 0, "X", 1, "X"),
  implicants: ((6,2),),
  vertical-implicants: ((1,5),)
)
$rc(nt(Q_0) Q_1,#red) + rc(Q_0 nt(Q_1),#green)$\
$= Q_0 xor Q_1$

*Y1*
#karnaugh(
  "2x4",
  labels: ("Q2", "Q1", "Q0"),
  manual-terms: (0, 0, "X", 1, 1, "X", 1, "X"),
  implicants: ((2,7),(6,5)),
)
$rc(Q_1, #red) + rc(Q_2, #green)$

*Y2*
#karnaugh(
  "2x4",
  labels: ("Q2", "Q1", "Q0"),
  manual-terms: (1, 1, "X", 0, 0, "X", 0, "X"),
  implicants: ((0,1),),
)
$rc(nt(Q_2) nt(Q_1), #red)$
$= nt(Y_1)$

*Y3*
#karnaugh(
  "2x4",
  labels: ("Q2", "Q1", "Q0"),
  manual-terms: (0, 0, "X", 1, 0, "X", 1, "X"),
  implicants: ((3,6),),
)
$rc(Q_1, #red)$
