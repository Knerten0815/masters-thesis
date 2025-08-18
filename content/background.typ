#import "../utils/todo.typ": TODO
#import "../utils/cite-marker.typ": CITE

= Background <background>
// #TODO[
//   Describe each proven technology / concept shortly that is important to understand your thesis. Point out why it is interesting for your thesis. Make sure to incorporate references to important literature here.
// ]
// #TODO[vielleicht noch Visualisierungen von Mols / Heatmaps? Wie werden Moleküle normalerweise dargestellt?]

== Mass Spectrometry
// #TODO[
//   This section would summarize the results of mass spectrometry using definitions, historical overviews and pointing out the most important aspects of mass spectrometry for this thesis.
// ]
// #TODO[hier Grafiken von Spektren rein, mass-to-charge-ratio (m/z), was sagt ein Peak aus etc.]
The MS/MS process involves three key steps: first, the sample is ionized and specific precursor ions of interest are selected based on their mass-to-charge ratio in the first mass analyzer.
Second, these selected precursor ions are fragmented using methods such as collision-induced dissociation (CID), where ions collide with an inert gas, or electron capture dissociation (ECD).
Finally, the resulting fragment ions are analyzed in a second mass analyzer, producing a fragmentation pattern or "product spectrum" that serves as a molecular fingerprint.


== Molecular Structure and Molecular Similarity <similarity_chapter>
// #TODO[
//   This section would summarize the concepts of molecular structure and molecular similarity using definitions, historical overviews and pointing out the most important aspects of of molecular structure and molecular similarity for this thesis.
// ]
// #TODO[hier auch visualisierung von Molekülen rein]
// - fingerprints, especially count based Morgan Fingerprints @morgan @morgan-count
// - similarity measures, especially Tanimoto/Ruzicka/Tversky @ruzicka @ruzicka2
Determining whether two compounds are similar is not a trivial question, as molecular similarity can be assessed from multiple perspectives depending on the specific application context.
Structural similarity may focus on shared functional groups or molecular scaffolds, while physicochemical similarity considers properties such as molecular weight or polarity.
And even when focusing on structural similarity, researchers may prioritize different structural features such as aromatic ring systems, or aliphatic chain length for determining similiar molecules @similarity.

To address this complexity, various computational approaches have been developed, including molecular fingerprints that encode structural features as binary or count-based vectors, descriptor-based methods that quantify specific molecular properties, and machine learning techniques that learn similarity relationships from spectral or structural data @similarity.
Ultimately these approaches try to quantify the multidimensional concept of similarity to a single scalar value that is the used as a metric in comaparing two compounds.
While this facilitates database queries and machine learning applications, this dimensionality reduction inevitably leads to information loss.

== ms2deepscore and ms2Query <ms2deepscore_chapter>
// #TODO[This section would summarize the tools matchMS, ms2deepscore and ChemSpaceExplorer using definitions, historical overviews and pointing out the most important aspects of these tools.
// ]
// #TODO[hier kurz erklären, was spectral embeddings sind.]
// - ms2deepscore @ms2deepscore
// - ms2Query @ms2query
// - chemical space @similarity @chemical_space

For instance, ms2deepscore's Siamese network architecture enables direct Tanimoto score prediction from spectrum pairs with root mean squared error values around 0.15, while its integration with matchms facilitates seamless workflow integration alongside Spec2Vec embeddings.
For example, ms2deepscore represents a supervised deep learning approach that trains a Siamese neural network to predict structural similarity scores directly from MS/MS spectrum pairs, achieving root mean squared errors of approximately 0.15 for Tanimoto score predictions.
This technique is integrated within the matchms Python library for mass spectra processing and can be combined with Spec2Vec, an unsupervised machine learning method that learns fragment relationships through Word2Vec-inspired algorithms.
While Spec2Vec identifies structural similarities by analyzing peak co-occurrences across large spectral datasets without requiring known chemical structures, ms2deepscore leverages annotated training data to predict specific structural similarity metrics, making both approaches complementary tools for different analytical scenarios in computational metabolomics.
