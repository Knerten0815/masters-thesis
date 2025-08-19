#import "../utils/todo.typ": TODO
#import "../utils/cite-marker.typ": CITE

= Related Work<related-work>
// #TODO[
//   Describe related work regarding your topic and emphasize your (scientific) contribution in contrast to existing approaches / concepts / workflows. Related work is usually current research by others and you defend yourself against the statement: “Why is your thesis relevant? The problem was al- ready solved by XYZ.” If you have multiple related works, use subsections to separate them.
// ]
== Similarity maps <simmaps_ch>
// #TODO[heatmap erklären]
=== Similarity Maps and Fingerprint Visualization

@simmaps_cite introduced similarity maps as a groundbreaking visualization strategy for understanding molecular fingerprints and machine learning model predictions.
Their approach calculates atomic weights by removing bits corresponding to each atom and measuring the resulting similarity difference (see @l_weights).
This method works with various fingerprint types including atom pairs, circular fingerprints, and extended-connectivity fingerprints, and extends naturally to machine learning models by substituting similarity differences with predicted-probability differences.
The weights can be generated using any similarity metric on any fingerprint that enables the mapping of individual bits back to their corresponding atoms or substructures.

#figure(
  ```typc
  ref_fp = calculate_fingerprint(ref_mol)
  this_fp = calculate_fingerprint(this_mol)
  weights = []
  orig_simil = tanimoto_similarity(ref_fp, this_fp)
  for atom in this_mol.get_atoms():
      new_fp = calculate_fingerprint_without_atom
              (this_mol, atom)
      new_simil = tanimoto_similarity(ref_fp, new_fp)
      weight = orig_simil - new_simil
      weights.append(weight)
  ```,
  caption: [Pseudo-code for calculating similarity map weights after @simmaps_cite],
  //placement: auto,
) <l_weights>

The generated heat maps show intuitively which substructures contribute to high similarity measure and which substructures show signs of dissimilarity (see )
The open-source implementation using RDKit has become a standard tool in the field.

== ChemSpaceExplorer <explorer>
// - ChemSpaceExplorer (@ms2query?)
// - analogue search
//Ms2Query? @ms2query ?

To find analogues, the ChemSpaceExplorer embeds the query spectrum in a high-dimensional chemical space, using ms2deepscore @ms2deepscore (see @ms2deepscore_chapter).
This chemical space was build by embedding spectra from molecular databases and selects the nearest neighbours in this space.

== Integrated Similarity Flow <isf>
In the ChemSpaceExplorer the Integrated Similarity Flow (ISF) attempts to address these limitations by ranking analogues based on their query distance weighted by their tanimoto similarity to each other.
However, while the ISF shows great capabilities of ranking the analogues based on confidence of the model, this confidence is not communicated to the user intuitively.
The concept of the ISF score reduces complex relationships to a single metric, requiring users to either trust it or gain an understanding of clustering techniques and how they are used.
One gap so far seems to be the ability to explain and illustrate the similarities between molecular substances.

