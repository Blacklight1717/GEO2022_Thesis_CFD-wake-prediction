#import "./template.typ": *
#import "@preview/gantty:0.5.1": *


#show: doc => kickoff(
  title: "My fantastic title",
  author: "Céline Dion",
  studentnumber: "123456",
  supervisor1: "Eva de Groot",
  supervisor2: "Piet Smit",
  // company: "Deltares",
  date: "2026-08-13",
  doc,
)


//---
#include "001-Introduction.typ"
#include "002-Related_work.typ"
#include "003-Research_questions.typ"
#include "004-Methodology.typ"
#include "005-Preliminary_results.typ"
#include "006-Time_planning.typ"
#include "007-Tools_and_datasets_used.typ"


#bibliography("refs.bib", style: "chicago-author-date")

#set heading(numbering: "A.1.1", supplement: [Appendix])
#counter(heading).update(0)
#include "008-Appendix.typ"