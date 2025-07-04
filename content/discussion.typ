#import "../utils/todo.typ": TODO
#import "../utils/cite-marker.typ": CITE
#import "../utils/fig-marker.typ": FIG
#import "../layout/colors.typ": colors

= Discussion <discussion>
#TODO[
  This chapter includes the status of your thesis, a conclusion and an outlook about future work.
]

== Status
#TODO[
  Describe honestly the achieved goals (e.g. the well implemented and tested use cases) and the open goals here. if you only have achieved goals, you did something wrong in your analysis.
]

=== Realized Goals
#TODO[
  Summarize the achieved goals by repeating the realized requirements or use cases stating how you realized them.
]

=== Open Goals
#TODO[
  Summarize the open goals by repeating the open requirements or use cases and explaining why you were not able to achieve them. Important: It might be suspicious, if you do not have open goals. This usually indicates that you did not thoroughly analyze your problems.
]
==== Analogue Sampling
Unfortantely it was not possible to sample groups with more than 10 analogues from the _ms2structures_ dataset, without compromising on the number of query samples or the minimum query-to-analogue similarity. Selecting 16 or 12 analogues for each query would reduce the sample size to 529 or 836 queries respectively. @dataset also features _biostructures_combined_ with 730,464 unique compounds, which could support sampling larger analogue groups, potentially with increased similarities too. The bottleneck was not the selection of analogues itself, but rather the calculation of the 730,464x730,464 matrix, used to look up compound similarities. The 16 GB RAM of the machine used to compute the similarity matrix could barely handle the task on the _ms2structures_ dataset. This would have required a machine with enormous RAM or rewriting the code to only partially compute, save and load the matrix, which would have gone beyond the scope of this thesis.

Sampling larger groups could fortify the findings of this thesis, since it appears that *#text("WHAT???", colors.red)* plateaus at a group size of 10.
Sampling with a query-to-analogue similartity of 0.75 or 0.8, could also result in a more robust baseline assumption of similarity, since similarities of 0.7 might show similar substructures but can still include considerale areas of dissimilarity (see #FIG[Sim map example of query, 0.7 and 0.8 sim compounds]), that could have significant impact on the atomic-level comparison of Stacked Similarity Maps.

== Conclusion
#TODO[
  Recap shortly which problem you solved in your thesis and discuss your *contributions* here.
]

== Future Work
#TODO[
  Tell us the next steps (that you would do if you have more time). Be creative, visionary and open-minded here.
]
