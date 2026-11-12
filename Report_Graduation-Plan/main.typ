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
= Introduction

An introduction in which the relevance of the project and its place in the
context of geomatics is described, along with a clearly-defined problem
statement.

// #lorem(100)

// #lorem(100)

//---
= Related work

A related work section in which the relevant literature is presented and
linked to the project.


//---
= Research questions

The research questions are clearly defined, along with the scope (ie what you
will not be doing).
To help you define a "good" research question, read #link("https://geomatics.
bk.tudelft.nl/geo2022/templates/Research-Questions_WS-handout.pdf")[this document].


//--
= Methodology

Overview of the methodology to be used.


//--
= Preliminary results

If you have preliminary results (and you should!), you can show them here.
This shows that you have actually started the work and you have not only been reading.
Don't forget to cite papers #cite(<Aurenhammer12>)#cite(<Voronoi08>)


//--
= Time planning

Having a Gantt chart is probably a better idea than just a list.
This one here is just taken from #link("https://typst.app/universe/package/gantty/")[gantty].

#let gantt_yaml = yaml("gantt.yaml")
#figure(
  gantt(gantt_yaml)
)


//-- 
= Tools and datasets used

Since specific data and tools have to be used, it's good to present these
concretely, so that the mentors know that you have a grasp of all aspects of the project.


#bibliography("refs.bib", style: "chicago-author-date")