#import "/utils/todo.typ": TODO
#import "../utils/cite-marker.typ": CITE
#import "../utils/fig-marker.typ": FIG


= Methodology <methodology>
// #TODO[documents the design and implementation of the implemented techniques to represent similarity relationships among analogue compounds. This chapter describes the algorithmic approach for visualizing mutual similarities between analogues, includes technical considerations and how the visualization techniques integrate into the ChemSpaceExplorer application.]
Similarity maps are heat maps highlighting atomic similarity relationships between two compounds as described in @simmaps_ch and  @simmaps_cite.
This chapter introduces Stacked Similarity Maps, that visually emphasize the atomic similarity relationships within a group of compounds of arbitrary size.
Aditionally, the Stacked Group Similarity metric and Stacked Query Similarity metric are described, that will be used in @results to benchmark the validity of the Stacked Similarity Map visualization technique.
Finally, the practical implementation is described in @implementation.

== Stacked Similarity Maps <ssm>
For a group of $n$ compounds ${C_1, C_2, ..., C_n}$, the pairwise atomic similarity weights between compounds $i$ and $j$ for atom $k$ are calculated as $w_(i,j)^((k))$, as described in @simmaps_ch, and stored in a matrix of weight vectors, where the diagonal is left empty #FIG[sim map matrix].

To generate the weights for the SSM, the atomic similarity weights of each compound are summed.
The stacked atomic similarity weight for atom $k$ in compound $i$ is:
$
  W_i^((k, "raw")) = sum_(j=1, j!=i)^n w_(i,j)^((k))
$

$W_i^((k, "raw"))$ is standardized to the range of $[-1, 1]$ by dividing them by the highest absolute $W_i^((k))$ where $m$ is the number of atoms in compound $i$:
$
  W_i^((k)) = W_i^((k, "raw")) / max(|W_i^((1))|, |W_i^((2))|, ..., |W_i^((m))|), W_i^((k)) in [-1, 1]
$<m_stacked_atomic_weight>

The complete SSM weight vector for compound $i$ contains the stacked weights for all its atoms:
$
  bold(W)_i = [W_i^((1)), W_i^((2)), ..., W_i^((m))]
$<m_ssm_weight_vector>

$W_i^((k))$ is used to generate the SSM just like $w_(i,j)^((k))$ in a regular similarity map @simmaps_cite.
The SSM heatmap represents atomic similarity realationships within the group, where substructures marked green contribute to a high group similarity, while red areas contribute to a low group similarity #FIG[SSM].

== Stacked Group Similarity <sgs>
The Stacked Group Similarity (SGS) is a similarity metric derived from SSM weigths for measuring the similarity within a group of compounds.
It will be used in comparison to state-of-the-art similarity metrics to test the validity of the SSM visualization technique.

The SGS is the mean of all elements in the weight vectors $bold(W)_i$ for all compounds:

$
  "SGS" = 1/n sum_(i=1)^n "mean"(bold(W)_i)
$<m_sgs>

where $n$ is the number of compounds in the group.

Since the SSM weights $W_i^((k))$ are standardized to the range of $[-1, 1]$, the SGS also resides in that range.

If the similarity metric used to calculate the atomic similarity weights $w_(i,j)^((k))$ fulfills the criteria for a similarity metric described by @similarity, the SGS will fulfill them too.
It has to be said, that the SGS metric should not be used as a drop-in replacement for other similarity metrics, though.
It can't aggregate any more insight into the the group similarity relationship as its underlying metric, but will always be more computationally expensive.
A simple group similarity approach, that takes the mean of all similarities within the group, will be more insightful in almost all cases.
But the SGS is closely and intuitively intertwined with the SSM generation and can therefore be used to compare against the simpler group similarity approach, to test the validity of the visualization technique on a big dataset.

== Stacked Query Similarity <sqs>

The Stacked Query Similarity (SQS) measures how the similarity relationships within a group of compounds match the similarities of each member of the group to another single molecule (query).

For a group of $n$ compounds ${C_1, C_2, ..., C_n}$ and a query molecule $Q$, the pairwise atomic similarity weights between compound $i$ and $Q$ for atom $k$ are calculated as $w_(i,Q)^((k))$, as described in @simmaps_ch.

// ...existing code...
The query similarity weights $w_(i,Q)^((k))$ are subtracted from the corresponding stacked similarity weights $W_i^((k))$ resulting in the query weight differences:
$
  d_i^((k, "raw")) = W_i^((k)) - w_(i,Q)^((k))
$

Since both $w_(i,Q)^((k))$ and $W_i^((k))$ are in the range of $[-1,1]$, $d_i^((k, "raw"))$ can take values in the range of $[-2, 2]$.

The absolute values of $d_i^((k))$ are scaled to the interval $[0,1]$ and inverted by subtracting them from 1:
$
  s_i^((k)) = 1 - (|d_i^((k))|)/2
$

The SQS for the entire group is calculated as the mean of all scaled similarity values:
$
  "SQS" = 1/n sum_(i=1)^n "mean"(bold(s)_i)
$<m_sqs>

where $n$ is the number of compounds in the group, $bold(s)_i = [s_i^((1)), s_i^((2)), ..., s_i^((m_i))]$ and $m_i$ is the number of atoms in compound $i$.

The SQS achieves high values when both the internal group similarity and the query-to-group similarities are high. Conversely, the SQS is low when both the internal group similarity and query-to-group similarities are low. The SQS will also be low when there is a mismatch: high internal group similarity but low query similarities, or vice versa. While low group similarity combined with high query similarity is theoretically possible, it is very unlikely in practice.

This metric can be used to search databases for query-analogue groups that exhibit specific similarity patterns and to assess the quality of clustering algorithms.
The SQS is compared to the ChemSpaceExplorer's ISF score (see @isf) as well as the mean similarities of each group member to the query.
// ...existing code...
// The query similarity weights $w_(i,Q)^((k))$ are subtracted from the corresponding stacked similarity weights $W_i^((k))$ resulting in the query weight differences $d_i^((k))$.
// Since $w_(i,Q)^((k))$ and $W_i^((k))$ are in the range of [-1,1], $d_i^((k, "raw"))$ can take on values in the range of [-2, 2].
// The absolute values of $d_i^((k, "raw"))$ are then scaled to the interval of [0,1] and inverted by subracting them from 1 to achieve SQS.

When the similarity of query to the group is high, and the similarity inside the group is high, the SQS is high to. When the similarity of query to the group is low, and the similarity within the group is low, the SQS is low too! The SQS will be low, when the similarity inside the group is high, but the similarities to the query are not, or vice versa. Low group similarity but high query similarity is theretically possible but very unlikely in practical though. The metric could be used to search databases for query-analogue groups fitting this description and use it to assess the the quality of clustering algorithms.
The SQS is compared to the ChemSpaceExplorer's ISF score (see @isf) as well as the mean similarities of each member to the query.


#figure(image("\figures\Similarity Maps\Beispiel gute Matches\query_mol.png", width: 50%), caption: [A curious figure.]) <testfig>

#figure(
  table(
    columns: 4,
    [t], [1], [2], [3],
    [y], [0.3s], [0.4s], [0.8s],
  ),
  caption: [Timing results],
)<testtable>



== Implementation <implementation>
In the benchmark the Ruzicka similarity #CITE[RUZICKA] of count-based Morgan9 fingerprints #CITE[Morgan] is used, as suggested by @count_bits.
