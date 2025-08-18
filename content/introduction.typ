#import "../utils/todo.typ": TODO
#import "../utils/cite-marker.typ": CITE
#import "../utils/fig-marker.typ": FIG



= Introduction <introduction>
// #TODO[
//   Introduce the topic of your thesis, e.g. with a little historical overview:
// ]
Mass spectrometry (MS) is a widely used analytical technique in chemistry and biology to identify and quantify molecules based on their mass-to-charge ratio.
The technique was first developed in the early 20th century @mass-spectrometry @mass-spectrometry2 and has evolved significantly over the years.
A variant of this technique is tandem mass spectrometry (MS/MS) @tandem-ms, which uses two or more mass analyzers in sequence to provide detailed structural information about molecules.
This approach provides greater specificity than single-stage mass spectrometry: while regular MS reveals molecular weight, MS/MS shows how molecules break apart, enabling the distinction between isomers that share the same mass but have different structures. #CITE[]
Today, MS is used in various fields, including proteomics, metabolomics, drug discovery, clinical diagnostics, and environmental analysis, to study the composition of substance samples and identify unknown compounds @Workman2024.

One of the key challenges in MS is the interpretation of the acquired data, which often requires expert knowledge and sophisticated algorithms to derive meaningful information from the raw measurements.#CITE[next cite might be enough. But maybe split it up better]
Recent advances in computational metabolomics have led to several machine learning and data visualization techniques to automate and improve the interpretation process @Workman2024 @Yates2009 @Collins2021 @Wu2025 @Liebal2020.
A recent project at University of Applied Sciences Düsseldorf called ChemSpaceExplorer aims to enhance the analysis of MS data by providing a visual representation of chemical space, allowing researchers to explore and compare mass spectra in a chemcical space.
The ChemSpaceExplorer can be used to upload query spectra with unknown molecular structure and find analogue spectra with known molecular structure, visualizing query and analogues in its representation of a 2D chemical space (see @f_screenshot).
In this context, analogue spectra refer to mass spectra that exhibit structural similarity to the query spectrum, suggesting that the corresponding compounds share similar molecular features or substructural elements that result in comparable fragmentation patterns (see @similarity_chapter).
The application furthermore visualizes the molecular structures of the analogues, which should help researchers in deriving the _unknown_ molecular structure of their uploaded query spectra.

// This thesis aims to solve a specific problem the ChemSpaceExplorer project is facing, which is picking a reasonable amount of analogues to return and estimating how similiar a group of analogue compounds is to the query compound.
#figure(
  image("../figures/CSE_Screenshot.jpeg", width: 100%),
  caption: [Screenshot of the ChemSpaceExplorer application: In the center lies the chemical space, visualized as a cluster of compounds. It is clustered by similarity, so that similar compounds are closeby while unsimilar compounds are further apart. Highlighted in red are the analogues to the uploaded query spectra. When a compound is selected by the user, its molecular structure and other metadata is shown on the right.],
  placement: top,
) <f_screenshot>

== Problem <problem>
// #TODO[
//   Describe the problem that you like to address in your thesis to show the importance of your work. Focus on the negative symptoms of the currently available solution.
// ]
// Eine perfekte Lösung für den ChemSpaceExplorer wäre es, das Query Spektrum in der Datenbank zu finden und seine molekulare Struktur darzustellen.
// Die Wahrscheinlichkeit, das ein hochgeladenes Spektrum bereits in der Datenbank existiert, ist jedoch verschwindend gering.
// Durch die Größe der Datenbank, ist es allerdings gar nicht so unwahrscheinlich eine Gruppe von ähnlichen Molekülen zu finden, und stattdessen deren molekulare Struktur anzuzeigen.
// Weisen die Analogen gemeinsame Substrukturen auf, liegt es Nahe, dass diese Substrukturen auch im Query Spektrum auftauchen.
// Weisen die Analogen keinerlei Gemeinsamkeiten auf, sind
// #TODO[Nochmal besser das Problem rausstellen und auf die Forschungslücke hinweisen.
//   Also warum ist es ein Problem und warum sollte ein "reasonable amoun"t
//   ausgegeben werden?]
//Determining whether two compounds are similar is not a trivial question (see @similarity_chapter).
// Structural similarity may focus on shared functional groups or molecular scaffolds, while physicochemical similarity considers properties such as molecular weight or polarity.
// And even when focusing on structural similarity, researchers may prioritize different structural features such as aromatic ring systems, or aliphatic chain length for determining similiar molecules @similarity.

// To address this complexity, various computational approaches have been developed, including molecular fingerprints that encode structural features as binary or count-based vectors, descriptor-based methods that quantify specific molecular properties, and machine learning techniques that learn similarity relationships from spectral or structural data @similarity.
// Ultimately these approaches try to quantify the multidimensional concept of similarity to a single scalar value that is the used as a metric in comaparing two compounds.
// While this facilitates database queries and machine learning applications, this dimensionality reduction inevitably leads to information loss.
//This challenge becomes particularly pronounced when comparing multiple molecules to assess collective similarity within the group.

//This challenge is evident in the ChemSpaceExplorer application, which constructs a chemical space using spectral embeddings @ms2deepscore.
When querying a spectrum against reference spectra, the ChemSpaceExplorer retrieves nearest neighbors based on embedding proximity.
However, the compounds in the chemical space are not evenly distributed - some regions are tightly clustered while others are sparsely populated.
When a query falls within a dense cluster, its nearest neighbors typically exhibit high similarity and some shared substructures.
This enables reliable inference of potential substructural elements present in the query compound (see #FIG[Good pick]).

// #TODO[Würde noch stärker mit reinbringen, dass Ähnlichkeit zw. 2 Spektren (Query+Reference spectra) über Ähnliche Substrukturen abgebildet werden können.]
If the query resides in a sparse region though, its neighbours may span significant distances in chemical space with less structural commonalities (see #FIG[low GS]).
_This disparity should be communicated to the user, as it directly impacts the confidence in structural predictions derived from the analogue set._

Another factor influencing reliability of analogue predictions, is when the retrieved group of analogues is highly similar to each other, but not to the query spectrum.
In this case, the user might be misled into thinking that the analogues are structurally similar to the query compound, when in fact they are not (see #FIG[high GS but low QS]).

It becomes clear, that both the similarity of analogues to the query, as well as the similarities within the analogue group, are essential to _confidently_ infer structural information from the analgoue group.
// #TODO[Better describe t-SNE dimensionality reduction, add figures]
The clustering of the ChemSpaceExplorer already helps users to interpret the models confidence, as they can see the density of compounds in specific areas as well as all the distances of the compounds to each other (see #FIG[the 3 figs of cases above] and @f_screenshot).
Additional to that, the molecular structures of the analogues are shown as a 2D plot when they are selected (see @f_screenshot), from which users can infer structural similarities between the query and the analogues.
However molecular similarity is highly dependent on the choice of the molecular fingerprint and similarity metric @count_bits and it is not always clear which substructures lead to a high similarity score exactly.
Alongside to showing the spatial distribution of analogues relative to the query spectrum, _a visualization technique that explicitly illustrates relationships among analogues might alleviate this issue._

Another challenge in presenting a group of analogue molecule to a query molecule is picking the right group size.
On one hand, the more analogues with a similar structure can be observed, the more information on the structure of the query can be infered.
On the other hand, every additional nearest neighbour added to the analogue group has less similarity to the query, thus lowering the overall similarity of the group.
Also displaying too many molecules, when the similarity among the group is consistently high, will at some point lead to redundant information #FIG[one of the similarity benchmark query figs].
// _One goal of this thesis is to pick a reasonable amount of analogues, which balances these criteria, for the ChemSPaceExplorer to display._

// #TODO[Introduce Fingerprints]

== Motivation <motivation>
// #TODO[Hier könnte noch mehr rein zur Forschungslücke. Wie werden in ChemInformatics Ähnlichkeiten visualisiert? Gibt es andere Ansätze etc.]
// scaffold trees? https://pubs.acs.org/doi/10.1021/ci600338x
Improving the visualization and interpretation of molecular similarity in mass spectrometry represents a critical scientific need for several compelling reasons.
// #TODO[Würde ich als erstes Argument anführen:]
_Effective visualization of structural relationships among analogues offers guidance for elucidating unknown compound structures_ @vis_is_nice1 @vis_is_nice2 @vis_is_nice3 @vis_is_nice4 @vis_is_nice5.
When researchers can visually identify consistent structural patterns across multiple similar spectra, they gain valuable insights into potential substructural elements present in query compounds.

// #TODO[Würde das Argument eher weiter runter setzen. Viel wichtiger ist denen die visuelle Interpretierbarkeit der Ergebnisse.]
// Second, enhancing interpretability of similarity models enables researchers to better understand the algorithmic basis of compound relationships, revealing potential biases or limitations in the underlying machine learning mechanisms.
// This interpretable framework provides essential context for evaluating confidence in structural predictions.

_Intuitive representation of chemical space density and similarity distributions significantly reduces cognitive load for analysts navigating complex datasets_ @vis_is_nice6 @vis_is_nice8 @vis_is_nice7.
By making relationship patterns immediately apparent rather than requiring extensive manual comparison of individual structures, researchers can focus their expertise on interpreting the biological or chemical significance of observed similarities.

Collectively, these improvements would transform spectra analysis from a primarily expert-driven process to a more accessible, efficient, and reliable analytical methodology.

== Objectives <objectives>
// #TODO[Falls du Forschungsfragen hast, kannst du die hier mit reinpacken.]
This thesis aims to enhance the interpretation of molecular similarity in the ChemSpaceExplorer through improved visualization techniques. The primary objectives are:

+ *Develop an intuitive visual representation* of the similarity relationship of an unknown compound to a group of analogue molecules.

// + *Design methods to quantify and visualize density variations* in chemical space, enabling analysts to assess confidence levels in returned analogues based on neighborhood characteristics.

// + *Create algorithms for adaptive selection of analogues* that account for local density variations in chemical space, ensuring that presented compounds offer meaningful structural insights regardless of the query spectrum's location.

+ *Evaluate the visualization approach* and compare it to other group similarity metrics.

+ *Integrate into the ChemSpaceExplorer backend*, enhancing its capability to support structural elucidation of unknown compounds.

The research will focus on algorithmic development and visualization design, with evaluation based on computational validation against known molecular structures and objective performance metrics compared to existing approaches. Through these objectives, this thesis aims to transform the presentation of molecular similarity from abstract numerical values to rich, interpretable visual representations that leverage human pattern recognition capabilities while maintaining scientific rigor.

// === Notes
// What is a good default for the amount of analogues returned by the analogue search in the ChemSpaceExplorer?

// 1. Define good:
//   1. + "every" query to analogue similarity is above 0.7 (but not 1)
//   1. + similarities calculated based off @count_bits sim suggestions
//   - Define "every":
//     - 1000 query analogue groups
// + Under these criteria, validate:
//   // 2. + clustering: distances in chem space
//   //   - query to analogue distances should be lower than ???
//   2. 2. analogue similarities to query infers analogue within-group similarity
//     - analogue to analogue similarities should be higher than 0.48 (0.57)
// //  - analogue to analogue distances should be lower than ??? (if 2.1 is proven)
// + validate SSM vis technique, for cases in which 1.1 - 1.3 is true
//   - SQS should be above 0.95 in 95% of all queries
//   - SQS should be below 0.5 for querys mismatching similar group
//   - abs(SGS - group sim) is <= 0.05 for 95% of queries
//   - compare to 2.2. results
// // + validate ISF score
// //   - mean ISF score should be above 0.65 (0.71)

== Outline <outline>
This thesis is structured as follows:

*@background* introduces the core concepts of mass spectrometry and molecular similarity assessment. It covers embedding techniques for chemical space representation, with focus on the ChemSpaceExplorer and ms2deepscore embeddings, similarity metrics, and the challenges of interpreting multidimensional molecular relationships.

*@related-work* examines existing approaches for visualizing chemical similarity and molecular relationships. It analyzes current methods for representing group similarity and visualization techniques that support structural elucidation.

*@methodology* documents the design and implementation of the implemented techniques to represent similarity relationships among analogue compounds. This chapter describes the algorithmic approach for visualizing mutual similarities between analogues, includes technical considerations and how the visualization techniques integrate into the ChemSpaceExplorer application.
// #TODO[Normalerweise ist die Struktur so:
//   Results: nur Ergebnisse beschreiben, keine Einordnung
//   Discussion: Einordnung der Ergebnisse, Bedeutung und Relevanz, hier werten
//   Conclusion: Zusammenfassen der Contrib, Limitationen, Future Research]
*@results* assesses the effectiveness of the developed visualization techniques through:
- Comparative analysis against existing similarity metrics
- Quantitative evaluation using benchmark molecular datasets
- Qualitative assessment of visualization interpretability

*@discussion* summarizes the contributions, discusses limitations of the approach, and outlines directions for future research in molecular similarity visualization.
