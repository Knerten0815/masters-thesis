#import "/utils/todo.typ": TODO
#import "../utils/cite-marker.typ": CITE
#import "../utils/fig-marker.typ": FIG


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

The lower the difference between the within-group similarity and the query-to-group similarities, the higher the SQS will be. That means if both values are high, the SQS will be high, and it will also be high, if both values are low.
Conversely, the SQS is low when there is a mismatch: high within-group similarity but low query-to-group similarities. This charecteristic is used to examine the analogue search of the ChemSpaceExplorer (see @explorer) and compare it to the ISF score (see @isf).

Cases where low within-group similarity are combined with high query-to-group similarity also cause a low SQS score. These cases would be very rare in practice, but the SQS could also be used to search databases for such cases.


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
