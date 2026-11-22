#import "./template.typ": *
#import "@preview/gantty:0.5.1": *

#show: doc => kickoff(
  title: "TUDelft Aerospace building wake prediction with CFD and its effects for local wind measurements",
  author: "Ruben Vons",
  studentnumber: "6285880",
  supervisor1: "Clara Garcia Sanchez",
  supervisor2: "Themis Vargiemezis",
  // company: "Deltares",
  date: "2027-01-xx",
  doc,
)

#set heading(numbering: "1.")
#outline()
#pagebreak()
//---
#include "001-Introduction.typ"
#pagebreak()
#include "002-Related_work.typ"
#pagebreak()
#include "003-Research_questions.typ"
#pagebreak()
#include "004-Methodology.typ"
#pagebreak()
#include "005-Preliminary_results.typ"
#pagebreak()
#include "006-Time_planning.typ"
#pagebreak()
#include "007-Tools_and_datasets_used.typ"
#pagebreak()

#pagebreak()
#bibliography("../Thesis.bib", style: "apa")

#pagebreak()
#set heading(numbering: "A.1.1", supplement: [Appendix])
#counter(heading).update(0)
#include "008-Appendix.typ"