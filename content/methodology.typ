#import "../utils/todo.typ": TODO
#import "../utils/cite-marker.typ": CITE
#import "../utils/fig-marker.typ": FIG
#import "../layout/colors.typ": *

= Methodology <methodology>
Similarity maps are heat maps highlighting atomic similarity relationships between two compounds as described in @simmaps_ch and  @simmaps_cite.
This chapter introduces Stacked Similarity Maps (SSM), that visually emphasize the atomic similarity relationships within a group of compounds of arbitrary size.
The following sections describe the Stacked Group Similarity (SGS) metric and Stacked Query Similarity (SQS), that will be used in @results in the quantitative analysis of the Stacked Similarity Map visualization technique.
//Finally, the practical implementation is described in @implementation.

== Stacked Similarity Maps <ssm>
// #TODO[Würde wie bei den Metriken kurz erwähnen, wozu die SSMs sind.]
For a group of $n$ compounds ${C_1, C_2, ..., C_n}$, the pairwise atomic similarity weights between compounds $i$ and $j$ for atom $k$ are calculated as $w_(i,j)^((k))$, as described in @simmaps_ch, and stored in a matrix of weight vectors, where the diagonal is left empty (see @f_algo).

#figure(
  image("../figures/sim map algo.png", width: 120%),
  caption: [Visualization of SQS, SSM and SGS algorithms.],
  placement: auto,
) <f_algo>

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
The SSM heatmap represents atomic similarity realationships within the group, where substructures marked green contribute to a high group similarity, while red areas contribute to a low group similarity (see @f_algo).

== Stacked Group Similarity <sgs>
The Stacked Group Similarity (SGS) is a similarity metric derived from SSM weights _for measuring the similarity within a group of compounds._
It will be used in comparison to state-of-the-art similarity metrics to test the validity of the SSM visualization technique.

The SGS is calculated by averaging the mean atomic weight of each compound in the group:
$
  "SGS" = 1/n sum_(i=1)^n frac(1, m_i) sum_(k=1)^(m_i) W_i^((k))
$ <m_sgs>

where $n$ is the number of compounds in the group and $m_i$ is the number of atoms in compound $i$.

Since the SSM weights $W_i^((k))$ are standardized to the range of $[-1, 1]$, the SGS also resides in that range.

If the similarity metric used to calculate the atomic similarity weights $w_(i,j)^((k))$ fulfills the criteria for a similarity metric described by @similarity, the SGS will fulfill them too.
It has to be said, that the SGS metric should not be used as a drop-in replacement for other similarity metrics.
It can not aggregate any more insight into the the group similarity relationship as its underlying metric, but will always be more computationally expensive.
A simple group similarity approach, that takes the mean of all similarities within the group, will be more insightful in almost all cases.
But the SGS is closely and intuitively intertwined with the SSM generation and can therefore be used to compare against the simpler group similarity approach, to test the validity of the visualization technique on a big dataset.

== Stacked Query Similarity <sqs>

The Stacked Query Similarity (SQS) measures _how the similarity relationships within a group of compounds match the similarities of each member of the group to another single molecule (query)._

For a group of $n$ compounds ${C_1, C_2, ..., C_n}$ and a query molecule $Q$, the pairwise atomic similarity weights between compound $i$ and $Q$ for atom $k$ are calculated as $w_(i,Q)^((k))$, as described in @simmaps_ch.
With the mean query weights (MQW) described as:
$
  "MQW" = 1/n sum_(i=1)^n frac(1, m_i) sum_(k=1)^(m_i) w_(i,Q)^((k))
$ <m_mqw>

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

_The lower the difference between the within-group similarity and the query-to-group similarities, the higher the SQS will be._ That means if both values are high, the SQS will be high. The SQS will also be high, if both values are low.
Conversely, the SQS is low when there is a mismatch: high within-group similarity but low query-to-group similarities. This characteristic is used to examine the analogue search of the ChemSpaceExplorer (see @explorer) and compare it to the ISF score (see @isf).

Cases where low within-group similarity are combined with high query-to-group similarity also cause a low SQS score.

== Quantitative Analysis <benchmark>

To evaluate the validity of Stacked Similarity Maps and the associated similarity metrics, three distinct benchmark approaches were implemented. These benchmarks test different aspects of the SSM methodology against established similarity metrics and explore its behavior under various group compositions.

=== Dataset
The _ms2structures_ dataset @dataset used in @count_bits was created using datasets from MS2Deepscore @ms2deepscore and MassSpecGym @massspecgym.
It contains 37,811 unique compounds and their molecular structures represented as SMILES @smiles.
1000 spectra with $n=10$ similar analogues were sampled from that dataset.
The analogues had a similarity of at least 0.7 to their query, which was calculated using Ruzicka similarity @ruzicka @ruzicka2 of count-based Morgan9 fingerprints @morgan @morgan-count, as suggested by @count_bits.
For analogue groups with $n<10$, only the most similar $n$ compounds from the analogue set were selected. This assures comparability among the sets, in the sense that the smaller sets share all their members with corresponding larger sets.

To find out the best default group size for the ChemSpaceExplorer's analogue search, these sample 1000 spectra were used as queries in the analogue search benchmark.

=== Stacked Similarity Map Benchmark <ssm_benchmark>
For the SSM benchmark, the SGS (@sgs), MQW and SQS (@sqs) were calculated for groups of two to ten analogues per query.
Aditionally, the query similarity (QS), the mean of all query-to-analogue similarities, and the group similarity (GS), the mean of all analogue-to-analogue similarities, were calculated, to compare against the MQW and SGS respectively.

=== Dissimilarity Benchmark <edge-bench>
The second benchmark specifically examines the behavior of the SQS metric under the aspect of dissimilarity.
For one case, the query and ten "analogues" are selected randomly from the _ms2structures_ dataset.
In another case, the ten similar compounds from the SSM benchmark are coupled with a random query from _ms2structures_, that exhibits a similarity of less than 0.15 to all members of the group. The results of ths benchmark will be used to examine the behaviour on samples with high group similarity but low query similarity.
#figure(
  image("../figures/benchmarks/simmap_sample_cse_140.png", width: 120%),
  caption: [A sample from the CSE benchmark, that shows high variance in group similarity and query similarity with increasing $n$ and the SQS reacting accordingly.],
  placement: auto,
) <f_sample>
=== ChemSpaceExplorer Benchmark <cse_benchmark>
The ChemSpaceExplorer benchmark evaluates how well the SQS metric correlates with established similarity measures.
It uses the ChemSpaceExplorer's analogue search results to assess whether SSM-derived metrics provide meaningful insights into the retrieved analogue groups.
Using a dataset of 1000 sample spectra with known molecular structures, the ChemSpaceExplorer performs analogue searches to identify the top $n$ most similar compounds for every query spectrum, where $n$ varies from 2 to 10 analogues.
For each group of analogues, SGS, MQW, SQS,  _query similarity_ and _group similarity_ is calculated like in the SSM benchmark.
The metrics are compared against established similarity metrics including:
- ISF scores from the ChemSpaceExplorer (@isf)
- Predicted molecular distances from the ChemSpaceExplorer
- Ruzicka similarities

The benchmark generates correlation coefficients and statistical significance tests to determine whether the SSM-derived metrics provide comparable or complementary information to existing similarity measures.


== Implementation

The Stacked Similarity Maps methodology was implemented as a Python module (`similarity_maps.py`) and integrated into the ChemSpaceExplorer codebase. The implementation leverages the RDKit cheminformatics library for molecular fingerprint generation and visualization.

The module provides several key functions:
- `get_group_similarity_map_weights()`: Calculates stacked similarity weights for groups of molecules
- `get_similarity_map_weights()`: Generates pairwise similarity weights between reference and probe molecules
- Visualization functions for rendering similarity maps as SVG or byte sources
- Support for multiple fingerprint types (Morgan, Atom Pairs, Topological Torsions, RDKit fingerprints)

The `FingerprintFunction` class encapsulates fingerprint parameters and provides a unified interface for different fingerprint algorithms, enabling flexible experimentation with various molecular representations. @l_usage demonstrates typical usage of the module for generating Stacked Similarity Maps from a group of molecular analogues.

#figure(
  ```python
  from ms_chemical_space_explorer.similarity_maps import (
      generate_mols, get_group_similarity_map_weights,
      get_similarity_map_svg_source, FingerprintFunction
  )

  # Define molecular analogues as SMILES strings
  smiles = ["CC(=O)N1CCC[C@H]1C(=O)O",
            "NCC(=O)N(C1)C(CC1)C(O)=O",
            "CCC(=O)N1CCCC1C(=O)O"]

  # Generate RDKit molecule objects
  analogues = generate_mols(smiles)

  # Configure fingerprint parameters
  fp_function = FingerprintFunction()
  fp_function.fingerprint = "MORGAN"
  fp_function.morgan_radius = 9
  fp_function.fp_type = "count"

  # Calculate stacked similarity weights
  analogue_weights = get_group_similarity_map_weights(
      analogues, fp_function)

  # Generate SVG visualizations
  svg_sources = []
  for analogue, weight in zip(analogues, analogue_weights):
      svg = get_similarity_map_svg_source(
          analogue, weight, size=(400, 400))
      svg_sources.append(svg)
  ```,
  caption: [Typical usage of the similarity maps module for generating Stacked Similarity Maps from molecular analogues],
  placement: bottom,
) <l_usage>

The implementation follows the mathematical formulations described in @ssm and @sgs, providing the computational foundation for the benchmarking studies presented in @results. The module is accessible through the ChemSpaceExplorer's REST API endpoint `/similarity_maps`, enabling web-based access to the visualization functionality.
