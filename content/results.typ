#import "../utils/todo.typ": TODO
#import "../utils/cite-marker.typ": CITE

= Results <results>

== Stacked Similarity Benchmark Results
@f_ssm_bench_sims shows that the means of all the similarity metrics decrease with more group members in the Stacked Similarity Map benchmark.
The violin plots show normal distributions around the means of the similarity metrics, that solidifies with increasing $n$.
The mean SQS of varying group sizes has less variation than the other metrics with a standard deviation of $approx$ 0.0024 across all $n$ (see @t_ssm_bench).
// A detailed view of the SQS benchmark results is provided in @f_ssm_bench_cs, which shows that the SQS peaks at $n=3$, plateaus for $n=[4,5]$ and then decreases for $n>5$.
Correlations between the metrics decrease across the board for increasing $n$, but stay high for Group- to Query Similarity and SGS to MQW. The latter increasing from $r=0.72$ to $r=0.76$ (see @f_ssm_bench_corr).

#figure(
  table(
    columns: 6,
    align: (left, right, right, right, right, right, right),
    stroke: none,
    table.hline(),
    [], [Query Sim.], [MQW], [Group Sim.], [SGS], [SQS],
    //[group sim. diff],
    table.hline(stroke: 0.5pt),
    [std], [0.032155], [0.011472], [0.035421], [0.009124], [0.002393],
    [min], [0.784824], [0.745276], [0.735464], [0.738398], [0.957548],
    [max], [0.880119], [0.779173], [0.840134], [0.763786], [0.964833],
    // [0.015155],
    table.hline(),
  ),
  caption: [Standard deviations, Minima and Maxima of the similarity metrics used in @f_ssm_bench_sims],
  placement: none,
) <t_ssm_bench>

#figure(
  image("../figures/benchmarks/ssm_benchmark_corr.png", width: 100%),
  caption: [Correlation matrix for the Stacked Similarity benchmark for $n=2$ and $n=10$. See supplemental material for correlation matrices of all $n$.],
  placement: auto,
) <f_ssm_bench_corr>

#figure(
  image("../figures/benchmarks/ssm_benchmark_violins.png", width: 100%),
  caption: [Violin plots showing the distribution for query similarity, MQW, group similarity, SGS and SQS across varying group sizes on the controlled dataset with similar samples. Black lines denote the median, while color coded lines denote maximum, $0.75$- and $0.25$-quantile, and minimum. The solid line shows the mean for each group size.],
  placement: auto,
) <f_ssm_bench_sims>



// #figure(
//   image("../figures/benchmarks/ssm_benchmark_cs.png", width: 50%),
//   caption: [],
//   placement: auto,
// ) <f_ssm_bench_cs>

#pagebreak()
== ChemSpaceExplorer Benchmark Results
@f_ssm_bench_sims and @f_scaled_sims show comparable tendencies to the Stacked Similarity benchmark.
All the mean similarity metrics decrease with increasing group size.
The mean ISF score for each sample was also measured in this benchmark and @f_ssm_bench_sims shows that its mean and distribution across varying $n$ follows the ground truth of the mean _query similarity_ (QS) with some positive offset across varying $n$.
The mean QS is also considerably lower than in the Stacked Similarity benchmark, where every analogue had a similarity of at least 0.7 to the query.
The lowest mean QS in the Stacked Similarity benchmark is $approx$ 0.78, while the highest mean QS in the ChemSpaceExplorer benchmark is $approx$ 0.36 (see @t_cse_bench and @t_ssm_bench).

_In contrast to the Stacked Similarity benchmark and the other similarity metrics of this benchmark, the SQS increases monotonically for $n in [2,10]$ (see @f_dissim_bench_sims)._

#figure(
  image("../figures/benchmarks/cse_benchmark_violins.png", width: 100%),
  caption: [The means of the similarity metrics for varying group sizes on the ChemSpaceExplorer's analogue search results.
    Visualization format as described in @f_ssm_bench_sims.],
  placement: auto,
) <f_cse_bench_sims>

#figure(
  table(
    columns: 8,
    align: (left, right, right, right, right, right, right, right),
    stroke: none,
    table.hline(),
    [], [Query Sim.], [MQW], [Group Sim.], [SGS], [SQS], [ISF], [Distance],
    table.hline(stroke: 0.5pt),
    [std], [0.029118], [0.007869], [0.135346], [0.050779], [0.036870], [0.028496], [0.002044],
    [min], [0.271683], [0.313382], [0.273916], [0.330557], [0.754254], [0.333411], [0.169333],
    [max], [0.359101], [0.335631], [0.687371], [0.476269], [0.861851], [0.418305], [0.175300],
    table.hline(),
  ),
  caption: [Standard deviations, Minima and Maxima of the similarity metrics used in @f_cse_bench_sims.], // and the SQS plot used in @f_dissim_bench_sims],
  placement: none,
) <t_cse_bench>


// #figure(
//   image("../figures/benchmarks/cse_benchmark_distance.png", width: 50%),
//   caption: [Mean distance ....  on the ChemSpaceExplorer's analogue search results. ],
//   placement: auto,
// ) <f_cse_bench_distance>

== Dissimilarity Benchmark
The group similarity and the SGS for the dissimilarity benchmark are the same as in the Stacked Similarity benchmark, because the dissimilarity benchmark uses the same analogue groups, but adds queries with low similarities ($<0.15$) to each of the group compounds.
The means and distributions of query similarity, MQW and SQS stay consistent across varying $n$.

#figure(
  image("../figures/benchmarks/dissim_benchmark_violins.png", width: 100%),
  caption: [The means of query similarity, MQW and SQS across varying group sizes for the dissimilarity benchmark.
    Visualization format as described in @f_ssm_bench_sims],
  placement: auto,
) <f_dissim_bench_sims>

#figure(
  grid(
    columns: 3,
    align: center,
    image("../figures/benchmarks/scaled_ssm_benchmark_sims.png", width: 100%),
    image("../figures/benchmarks/scaled_cse_benchmark_sims.png", width: 100%),
    image("../figures/benchmarks/scaled_dissim_benchmark_sims.png", width: 100%),
  ),
  caption: [The means of the similarity metrics for varying group sizes of all three benchmarks.],
  placement: auto,
) <f_scaled_sims>

== Qualitative assessment

#figure(
  image("../figures/benchmarks/simmap_sample_cse_140.png", width: 120%),
  caption: [A sample from the CSE benchmark, that shows high variance in group similarity and query similarity with increasing $n$ and the SQS reacting accordingly.],
  //placement: auto,
) <f_sample>

#figure(
  image("../figures/benchmarks/simmap_sample_hi_sim_23617.png", width: 120%),
  caption: [A sample from the SSM benchmark. The analogue group already shows a clear pattern with n=3. More highly similar analogues dont add meaningful visual information.],
  //placement: auto,
) <f_redundancy>

#pagebreak()
== Summary

This study evaluated Stacked Similarity Maps across three benchmarks with varying group sizes ($n = 2$ to $n = 10$) to assess the effect of group size on molecular similarity metrics.

*Stacked Similarity Benchmark:* All similarity metrics (query similarity, MQW, group similarity, SGS, and SQS) decreased with increasing group size. Query-to-analogue similarities ranged from 0.7 to 1.0. The SQS showed the least variation across group sizes with a standard deviation of 0.002393. SQS values peaked at $n=3$ with a mean of 0.964833 and decreased to 0.957548 at $n=10$. Correlations between metrics generally decreased with larger group sizes, except for Group-to-Query Similarity and SGS-to-MQW correlations.

*ChemSpaceExplorer Benchmark:* Most similarity metrics decreased with increasing group size, following the same pattern as the Stacked Similarity benchmark. However, the SQS increased monotonically from $n=2$ to $n=10$. Query-to-analogue similarities were considerably lower, ranging from 0.271683 to 0.359101. ISF scores followed the same trend as query similarity across all group sizes. The SQS showed higher variation (std = 0.036870) compared to the Stacked Similarity benchmark.

*Dissimilarity Benchmark:* Query-to-analogue similarities were consistently low (less than 0.15). The query similarity, MQW, and SQS remained stable across varying group sizes. Group similarity and SGS values were identical to the Stacked Similarity benchmark as the same analogue groups were used.

@f_scaled_sims demonstrates the contrasting behavior of similarity metrics across the three benchmarks, with the SQS showing opposing trends between high-similarity (Stacked Similarity) and low-similarity (ChemSpaceExplorer) conditions.

