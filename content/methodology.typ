#import "/utils/todo.typ": TODO
#import "../utils/cite-marker.typ": CITE
#import "../utils/fig-marker.typ": FIG
#import "../layout/colors.typ": *


= Methodology <methodology>
Similarity maps are heat maps highlighting atomic similarity relationships between two compounds as described in @simmaps_ch and  @simmaps_cite.
This chapter introduces Stacked Similarity Maps, that visually emphasize the atomic similarity relationships within a group of compounds of arbitrary size.
Aditionally, the Stacked Group Similarity metric and Stacked Query Similarity metric are described, that will be used in @results to benchmark the validity of the Stacked Similarity Map visualization technique.
Finally, the practical implementation is described in @implementation.

== Stacked Similarity Maps <ssm>
For a group of $n$ compounds ${C_1, C_2, ..., C_n}$, the pairwise atomic similarity weights between compounds $i$ and $j$ for atom $k$ are calculated as $w_(i,j)^((k))$, as described in @simmaps_ch, and stored in a matrix of weight vectors, where the diagonal is left empty #FIG[sim map matrix].

To generate the weights for the SSM, the atomic similarity weights of each compound are summed.
The stacked atomic similarity weight for atom $k$ in compound $i$ is:
$
  tilde(W)_i^((k)) = sum_(j=1, j!=i)^n w_(i,j)^((k))
$

$tilde(W)_i^((k))$ is standardized to the range of $[-1, 1]$ by dividing them by the highest absolute $tilde(W)_i^((k))$ where $m$ is the number of atoms in compound $i$:
$
  W_i^((k)) = tilde(W)_i^((k)) / max(|tilde(W)_i^((1))|, |tilde(W)_i^((2))|, ..., |tilde(W)_i^((m))|)
$ <m_stacked_atomic_weight>

$W_i^((k))$ is used to generate the SSM just like $w_(i,j)^((k))$ in a regular similarity map @simmaps_cite.
The SSM heatmap represents atomic similarity realationships within the group, where substructures marked green contribute to a high group similarity, while red areas contribute to a low group similarity #FIG[SSM].

== Stacked Group Similarity <sgs>
The Stacked Group Similarity (SGS) is a similarity metric derived from SSM weights for measuring the similarity within a group of compounds.
It will be used in comparison to state-of-the-art similarity metrics to test the validity of the SSM visualization technique.

The SGS is calculated by averaging the mean atomic weight of each compound in the group:
$
  "SGS" = 1/n sum_(i=1)^n frac(1, m_i) sum_(k=1)^(m_i) W_i^((k))
$ <m_sgs>

where $n$ is the number of compounds in the group and $m_i$ is the number of atoms in compound $i$.

Since the SSM weights $W_i^((k))$ are standardized to the range of $[-1, 1]$, the SGS also resides in that range.

If the similarity metric used to calculate the atomic similarity weights $w_(i,j)^((k))$ fulfills the criteria for a similarity metric described by @similarity, the SGS will fulfill them too.
It has to be said, that the SGS metric should not be used as a drop-in replacement for other similarity metrics, though.
It can not aggregate any more insight into the the group similarity relationship as its underlying metric, but will always be more computationally expensive.
A simple group similarity approach, that takes the mean of all similarities within the group, will be more insightful in almost all cases.
But the SGS is closely and intuitively intertwined with the SSM generation and can therefore be used to compare against the simpler group similarity approach, to test the validity of the visualization technique on a big dataset.

== Stacked Query Similarity <sqs>

The Stacked Query Similarity (SQS) measures how the similarity relationships within a group of compounds match the similarities of each member of the group to another single molecule (query).

For a group of $n$ compounds ${C_1, C_2, ..., C_n}$ and a query molecule $Q$, the pairwise atomic similarity weights between compound $i$ and $Q$ for atom $k$ are calculated as $w_(i,Q)^((k))$, as described in @simmaps_ch.

The query similarity weights $w_(i,Q)^((k))$ are subtracted from the corresponding stacked similarity weights $W_i^((k))$ resulting in the query weight differences:
$
  Delta_i^((k)) = W_i^((k)) - w_(i,Q)^((k))
$

Since both $w_(i,Q)^((k))$ and $W_i^((k))$ are in the range of $[-1,1]$, $Delta_i^((k))$ can take values in the range of $[-2, 2]$.

The absolute values of $Delta_i^((k))$ are scaled to the interval $[0,1]$ and inverted by subtracting them from 1:
$
  s_i^((k)) = 1 - (|Delta_i^((k))|)/2
$

The SQS for the entire group is calculated by averaging the mean scaled similarity value of each compound in the group:
$
  "SQS" = 1/n sum_(i=1)^n frac(1, m_i) sum_(k=1)^(m_i) s_i^((k))
$ <m_sqs>
where $n$ is the number of compounds in the group and $m_i$ is the number of atoms in compound $i$.

The lower the difference between the within-group similarity and the query-to-group similarities, the higher the SQS will be. That means if both values are high, the SQS will be high. The SQS will also be high, if both values are low.
Conversely, the SQS is low when there is a mismatch: high within-group similarity but low query-to-group similarities. This charecteristic is used to examine the analogue search of the ChemSpaceExplorer (see @explorer) and compare it to the ISF score (see @isf).

Cases where low within-group similarity are combined with high query-to-group similarity also cause a low SQS score. These cases would be very rare in practice, though.

== Benchmark <benchmark>

To evaluate the validity of Stacked Similarity Maps and the associated similarity metrics, *#text("THREE?", fill: colors.red)* distinct benchmark approaches were implemented. These benchmarks test different aspects of the SSM methodology against established similarity metrics and explore its behavior under various group compositions.

=== Dataset
The _compounds_ms2structures_ dataset @dataset used in @count_bits was created using training and evaluation data from MS2Deepscore @ms2deepscore as well as MassSpecGym @massspecgym. It contains 37,811 unique compounds and their molecular structures in SMILES format @smiles. 1000 queries with 10 similar analogues were sampled from that dataset. The analogues had a similarity of at least 0.7 to their query and the similarity was calculated using Ruzicka similarity @ruzicka @ruzicka2 of count-based Morgan9 fingerprints @morgan @morgan-count, as suggested by @count_bits.
To find out what the best default group size for the ChemSpaceExplorer's analogue search

=== Group Similarity Benchmark <group_benchmark>

This benchmark evaluates the Stacked Group Similarity (SGS) metric by comparing it against traditional group similarity measures computed from molecular fingerprints. This benchmark creates controlled datasets with known similarity relationships to test the metric's validity.

The benchmark process includes:

1. *Controlled Group Generation*: Groups of 10 molecules are selected from a large chemical database with predefined similarity ranges (0.0-0.15 Ruzicka similarity) to ensure diverse molecular structures within each group.

2. *Multiple Similarity Calculations*: For each group, both traditional fingerprint-based group similarities and SGS values are computed using Morgan9 fingerprints with 4096 bits.

3. *Comparative Analysis*: The SGS values are compared against mean pairwise Ruzicka similarities within each group to assess whether the SSM-derived metric captures similar trends in molecular similarity.

*FIGURE* shows the correlation between SGS and traditional group similarity measures across 1000 molecular groups.

=== Edge Case Analysis <edge_case_benchmark>

The third benchmark specifically examines the behavior of the SQS metric under challenging molecular similarity scenarios. This benchmark tests cases where groups have high internal similarity but low similarity to a query molecule, and vice versa.

The methodology involves:

1. *Targeted Group Selection*: Molecular groups are deliberately constructed to create specific similarity patterns:
  - High intra-group similarity with low query similarity
  - Low intra-group similarity with high query similarity
  - Mixed similarity patterns

2. *SQS Behavior Analysis*: The SQS metric's response to these edge cases is analyzed to understand its sensitivity and interpretability.

3. *Validation Against Expectations*: Results are compared against theoretical expectations based on the SQS formula to ensure the metric behaves predictably.

*TABLE* presents the SQS values for different edge case scenarios and their interpretation.

=== Stacked Query Similarity Benchmark <sqs_benchmark>

The primary benchmark evaluates how well the Stacked Query Similarity (SQS) metric correlates with established similarity measures in the context of chemical analogue search. This benchmark uses the ChemSpaceExplorer analogue search results to assess whether SSM-derived metrics provide meaningful insights into molecular similarity relationships.

The benchmark methodology follows these steps:

1. *Dataset Preparation*: Using a dataset of 1000 test spectra with known molecular structures, the ChemSpaceExplorer performs analogue searches to identify the top $n$ most similar compounds for each query molecule, where $n$ varies from 2 to 30 analogues.

2. *Stacked Similarity Map Generation*: For each group of analogues, stacked atomic similarity weights are computed using Morgan fingerprints with radius 9 and 2048 bits. The similarity threshold for fragment extraction is set to 0.2, and weights are standardized to the range $[-1, 1]$.

3. *Weight Difference Calculation*: For each analogue molecule in a group, the absolute differences between its stacked atomic weights and the query-to-analogue atomic weights are calculated and averaged to produce a query weight difference score.

4. *Correlation Analysis*: The query weight difference scores are compared against established similarity metrics including:
  - ISF (Ion Spectrum Fingerprint) scores from the ChemSpaceExplorer
  - Predicted molecular distances
  - Tanimoto similarities

The benchmark generates correlation coefficients and statistical significance tests to determine whether the SSM-derived metrics provide comparable or complementary information to existing similarity measures.

*TABLE* summarizes the correlation results across different group sizes.


== Implementation <implementation>
In the benchmark the Ruzicka similarity @ruzicka @ruzicka2 of count-based Morgan9 fingerprints @morgan @morgan-count is used, as suggested by @count_bits.


// #figure(image("\figures\Similarity Maps\Beispiel gute Matches\query_mol.png", width: 50%), caption: [A curious figure.]) <testfig>

// #figure(
//   table(
//     columns: 4,
//     [t], [1], [2], [3],
//     [y], [0.3s], [0.4s], [0.8s],
//   ),
//   caption: [Timing results],
// )<testtable>
