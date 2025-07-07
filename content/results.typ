#import "../utils/todo.typ": TODO
#import "../utils/cite-marker.typ": CITE

= Results <results>

== Stacked Similarity Benchmark Results
@f_ssm_bench_sims shows that the means of all the similarity metrics decrease with more group members in the Stacked Similarity Map benchmark.
The mean CS of varying group sizes has less variation than other metrics with a standard deviation of 0.0024 across all $n$ (see @t_ssm_bench).
A detailed view of the CS benchmark results is provided in @f_ssm_bench_cs, which shows that the metric peaks at $n=3$, plateaus for $n=[4,5]$ and then decreases for $n>5$.
#figure(
  image("../figures/benchmarks/ssm_benchmark_corr.png", width: 100%),
  caption: [Correlation matrix for Stacked Similarity benchmark],
  placement: auto,
) <f_ssm_bench_corr>

#figure(
  table(
    columns: 6,
    align: (left, right, right, right, right, right, right),
    stroke: none,
    table.hline(),
    [], [query sim.], [MQW], [group sim.], [SGS], [CS],
    //[group sim. diff],
    table.hline(stroke: 0.5pt),
    [std], [0.032155], [0.011472], [0.035421], [0.009124], [0.002393],
    [min], [0.784824], [0.745276], [0.735464], [0.738398], [0.957548],
    [max], [0.880119], [0.779173], [0.840134], [0.763786], [0.964833],
    // [0.015155],
    table.hline(),
  ),
  caption: [Standard deviations, Minima and Maxima of the similarity metrics used in @f_ssm_bench_sims and the CS used in @f_ssm_bench_cs],
  placement: none,
)<t_ssm_bench>

#figure(
  image("../figures/benchmarks/ssm_benchmark_sims.png", width: 100%),
  caption: [The means of the similarity metrics for varying group sizes on the controlled dataset with similar samples. ],
  placement: auto,
) <f_ssm_bench_sims>

#figure(
  image("../figures/benchmarks/ssm_benchmark_cs.png", width: 100%),
  caption: [],
  placement: auto,
) <f_ssm_bench_cs>



== ChemSpaceExplorer Benchmark Results
@f_ssm_bench_sims shows comparable tendencies to the Stacked Similarity benchmark. All the mean similarity metrics decrease with increasing group size.
The mean ISF score for each sample was also measured in this benchmark and @f_ssm_bench_sims shows that its mean across varying $n$ closely follows the ground truth of the mean _query similarity_ (QS) across varying $n$.
The mean QS is also considerably lower than in the Stacked Similarity benchmark, where every analogue had a similarity of at least 0.7 to the query.
The lowest mean QS in the Stacked Similarity benchmark is $approx$ 0.78, while the highest mean QS in the ChemSpaceExplorer benchmark is $approx$ 0.36 (see @t_cse_bench and @t_ssm_bench).

_In contrast to the Stacked Similarity benchmark and the other similarity metrics of this benchmark, the CS increases monotonically for $n in [2,10]$ (see @f_cse_bench_cs)._


#figure(
  table(
    columns: 8,
    align: (left, right, right, right, right, right, right, right),
    stroke: none,
    table.hline(),
    [], [query sim.], [QMW], [group sim.], [SGS], [SQS], [ISF], [distance],
    table.hline(stroke: 0.5pt),
    [std], [0.029118], [0.007869], [0.135346], [0.050779], [0.036870], [0.028496], [0.002044],
    [min], [0.271683], [0.313382], [0.273916], [0.330557], [0.754254], [0.333411], [0.169333],
    [max], [0.359101], [0.335631], [0.687371], [0.476269], [0.861851], [0.418305], [0.175300],
    table.hline(),
  ),
  caption: [Standard deviations, Minima and Maxima of the similarity metrics used in @f_cse_bench_sims and the CS used in @f_cse_bench_cs],
  placement: none,
)<t_cse_bench>

#figure(
  image("../figures/benchmarks/cse_benchmark_sims.png", width: 100%),
  caption: [The means of the similarity metrics for varying group sizes on the ChemSpaceExplorer's analogue search results. ],
  placement: auto,
) <f_cse_bench_sims>

#figure(
  image("../figures/benchmarks/cse_benchmark_cs.png", width: 100%),
  caption: [The means of the similarity metrics for varying group sizes on the ChemSpaceExplorer's analogue search results. ],
  placement: auto,
) <f_cse_bench_cs>

== Dissimilarity Benchmark


== Objectives
#TODO[
  Derive concrete objectives / hypotheses for this evaluation from the general ones in the introduction.
]

== Results
#TODO[
  Summarize the most interesting results of your evaluation (without interpretation). Additional results can be put into the appendix.
]

== Findings
#TODO[
  Interpret the results and conclude interesting findings
]
This shows that the CS can be used to evaluate the ability of a group of analogues to infer molecular substructures to their query. In the Stacked Similarity benchmark, using high query-to-analogue similarities, 3 analogues were best fitted to infer the molecular structure of the query. In the ChemSpaceExplorer benchmark, where query-to-analogue similarities vary vastly, more analogues will increase this ability up to 10 analogues. It has to be further evaluated, if the CS starts to decrease for greater $n$, or if it converges to a maximum.

== Discussion
#TODO[
  Discuss the findings in more detail and also review possible disadvantages that you found
]

== Limitations
#TODO[
  Describe limitations and threats to validity of your evaluation, e.g. reliability, generalizability, selection bias, researcher bias
]
