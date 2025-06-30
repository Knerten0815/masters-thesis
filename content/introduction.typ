#import "/utils/todo.typ": TODO
#import "../utils/cite-marker.typ": CITE

= Introduction <introduction>
// #TODO[
//   Introduce the topic of your thesis, e.g. with a little historical overview:
// ]
Mass spectrometry (MS) is a widely used analytical technique in chemistry and biology to identify and quantify molecules based on their mass-to-charge ratio. The technique was first developed in the early 20th century @mass-spectrometry @mass-spectrometry2 and has evolved significantly over the years. Today, MS is used in various fields, including proteomics, metabolomics, and environmental analysis, to study the composition of substance samples and identify unknown compounds. One of the key challenges in MS is the interpretation of the acquired data, which often requires expert knowledge and sophisticated algorithms to derive meaningful information from the raw measurements. In recent years, machine learning and data visualization techniques have been increasingly applied to MS data analysis to automate and improve the interpretation process @Workman2024 @Yates2009 @Collins2021 @Wu2025 @Liebal2020. _*[Example ms2deepscore and its use in matchms and maybe Spec2Vec?]*_ The ChemSpaceExplorer project at University of Applied Sciences Düsseldorf aims to enhance the analysis of MS data by providing a visual representation of chemical space, allowing researchers to explore and compare mass spectra in a more intuitive way. The ChemSpaceExplorer returns a group of analogue spectra to a query spectrum based on their ms2deepscore @ms2deepscore embeddings, which represent the spectra in a high-dimensional chemical space. The spectra are visualized in a 2D space using t-SNE, where similar spectra are placed closer together. The molecular structure of the analogues is vizualized, which helps researchers in deriving the molecular structure of their query spectrum. This thesis aims to solve a specific problem the ChemSpaceExplorer project is facing, which is picking a reasonable amount of analogues to return and estimating how similiar a group of analogue compounds is to the query compound.


== Problem <problem>
// #TODO[
//   Describe the problem that you like to address in your thesis to show the importance of your work. Focus on the negative symptoms of the currently available solution.
// ]
Molecular similarity represents a multidimensional concept that defies simple quantification. Depending on the analytical context, researchers may prioritize different structural features such as aromatic ring systems, aliphatic chain length, or specific functional groups. While reducing molecular similarity to scalar values facilitates database queries and machine learning applications, this dimensionality reduction inevitably sacrifices information richness. This limitation becomes particularly pronounced when comparing multiple molecules to assess collective similarity within the group.

This challenge is evident in the ChemSpaceExplorer application, which constructs a chemical space using ms2deepscore embeddings @ms2deepscore. When querying a spectrum against this space, the system retrieves nearest neighbors based on embedding proximity. However, the compounds in the chemical space are not evenly distributed - some regions are tightly clustered while others are sparsely populated. When a query falls within a dense cluster, its nearest neighbors typically exhibit high similarity. This enables reliable inference of potential substructural elements present in the query compound. If the query resides in a sparse region though, its neighbours may span significant distances in chemical space with less structural commonalities. This disparity should be communicated to the user, as it directly impacts the confidence in structural predictions derived from the analogue set. Another case of difficult to distinguish confidence in the analogue predictions, is when the retrieved group of analogues is highly similar to each other, but not to the query spectrum. In this case, the user might be misled into thinking that the analogues are structurally similar to the query compound, when in fact they are not. *ADD FIGS OF CHEMSPACE VISUALIZING THESE CASES!*

#TODO[Better describe t-SNE dimensionality reduction, add figures]
In the ChemSpaceExplorer, a query and its analogues are visualized as 2D points in the t-SNE visualization. This already helps users to interpret the models confidence, as they can see the density of compounds in this area as well as all the distances of the compounds to each other. *ADD CHEMSPACE EXPLORER FIG??* Additional to that, the molecular structures of the analogues are shown as a 2D plot when they are selected. From that users can infer structural similarities between the query and the analogues. However molecular similarity is highly dependent on the choice of fingerprint and similarity metric #CITE[] and it is not always clear which substructures lead to a high similarity score.
The Integrated Similarity Flow (ISF) attempts to address these limitations by ranking analogues based their query distance weighted by their similarity to each other.  *REFERENCE THE SAME FIG AS BEFORE?* *ADD ISF FORMULA* However, while the ISF shows great capabilities of ranking the analogues based on confidence of the model, this confidence is not communicated to the user intuitively. The concept of the ISF score reduces complex relationships to a single metric and requires users to just trust it, or gain understanding of clustering techniques and the metrics usage of them. What is needed is an visualization technique that explicitly illustrates similarity relationships among compounds and their spatial distribution relative to the query spectrum.


== Motivation <motivation>
// #TODO[
//   Motivate scientifically why solving this problem is necessary. What kind of benefits do we have by solving the problem?
// ]
Improving the visualization and interpretation of molecular similarity in mass spectrometry represents a critical scientific need for several compelling reasons. First, enhancing interpretability of similarity models enables researchers to better understand the algorithmic basis of compound relationships, revealing potential biases or limitations in the underlying machine learning mechanisms. This interpretable framework provides essential context for evaluating confidence in structural predictions. Second, effective visualization of structural relationships among analogues offers crucial guidance for elucidating unknown compound structures—a fundamental challenge in analytical chemistry. When researchers can visually identify consistent structural patterns across multiple similar spectra, they gain valuable insights into potential substructural elements present in query compounds. Third, intuitive representation of chemical space density and similarity distributions significantly reduces cognitive load for analysts navigating complex datasets. By making relationship patterns immediately apparent rather than requiring extensive manual comparison of individual structures, researchers can focus their expertise on interpreting the biological or chemical significance of observed similarities. Collectively, these improvements would transform spectra analysis from a primarily expert-driven process to a more accessible, efficient, and reliable analytical methodology.

== Objectives <objectives>
// #TODO[
//   Describe the research goals and/or research questions and how you address them by summarizing what you want to achieve in your thesis, e.g. developing a system and then evaluating it.
// ]
This thesis aims to enhance the interpretation of molecular similarity in mass spectrometry data analysis through improved visualization techniques. The primary objectives are:

+ *Develop an intuitive visual representation* of the similarity relationship of an unknown compound to a group of analogue molecules picked by a deep learning model.

// + *Design methods to quantify and visualize density variations* in chemical space, enabling analysts to assess confidence levels in returned analogues based on neighborhood characteristics.

// + *Create algorithms for adaptive selection of analogues* that account for local density variations in chemical space, ensuring that presented compounds offer meaningful structural insights regardless of the query spectrum's location.

+ *Evaluate the visualization approach* and compare it to other group similarity metrics.

+ *Integrate into the ChemSpaceExplorer backend*, enhancing its capability to support structural elucidation of unknown compounds.

The research will focus on algorithmic development and visualization design, with evaluation based on computational validation against known molecular structures and objective performance metrics compared to existing approaches. Through these objectives, this thesis aims to transform the presentation of molecular similarity from abstract numerical values to rich, interpretable visual representations that leverage human pattern recognition capabilities while maintaining scientific rigor.

=== Notes
What is a good default for the amount of analogues returned by the analogue search in the ChemSpaceExplorer?

1. Define good:
  1. + "every" query to analogue similarity is above 0.7 (but not 1)
  1. + similarities calculated based off @count_bits sim suggestions
  - Define "every":
    - 1000 query analogue groups
+ Under these criteria, validate:
  // 2. + clustering: distances in chem space
  //   - query to analogue distances should be lower than ???
  2. 2. analogue similarities to query infers analogue within-group similarity
    - analogue to analogue similarities should be higher than 0.48 (0.57)
//  - analogue to analogue distances should be lower than ??? (if 2.1 is proven)
+ validate SSM vis technique, for cases in which 1.1 - 1.3 is true
  - SQS should be above 0.95 in 95% of all queries
  - SQS should be below 0.5 for querys mismatching similar group
  - abs(SGS - group sim) is <= 0.05 for 95% of queries
  - compare to 2.2. results
// + validate ISF score
//   - mean ISF score should be above 0.65 (0.71)

== Outline <outline>
This thesis is structured as follows:

*@background* introduces the core concepts of mass spectrometry and molecular similarity assessment. It covers embedding techniques for chemical space representation, with focus on the ChemSpaceExplorer and ms2deepscore embeddings, similarity metrics, and the challenges of interpreting multidimensional molecular relationships.

*@related-work* examines existing approaches for visualizing chemical similarity and molecular relationships. It analyzes current methods for representing group similarity and visualization techniques that support structural elucidation.

*@methodology* documents the design and implementation of the implemented techniques to represent similarity relationships among analogue compounds. This chapter describes the algorithmic approach for visualizing mutual similarities between analogues, includes technical considerations and how the visualization techniques integrate into the ChemSpaceExplorer application.

*@results* assesses the effectiveness of the developed visualization techniques through:
- Comparative analysis against existing similarity metrics
- Quantitative evaluation using benchmark molecular datasets
- Qualitative assessment of visualization interpretability

*@discussion* summarizes the contributions, discusses limitations of the approach, and outlines directions for future research in molecular similarity visualization.
