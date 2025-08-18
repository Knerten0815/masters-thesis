#import "../utils/todo.typ": TODO
#import "../utils/cite-marker.typ": CITE

= Related Work<related-work>
// #TODO[
//   Describe related work regarding your topic and emphasize your (scientific) contribution in contrast to existing approaches / concepts / workflows. Related work is usually current research by others and you defend yourself against the statement: “Why is your thesis relevant? The problem was al- ready solved by XYZ.” If you have multiple related works, use subsections to separate them.
// ]
== Similarity maps <simmaps_ch>
// #TODO[heatmap erklären]
The weights can be generated using any similarity metric on any fingerprint that enables the mapping of individual bits back to their corresponding atoms or substructures @simmaps_cite.
```typc
ref_fp = calculate_fingerprint(ref_mol)
this_fp = calculate_fingerprint(this_mol)
weights = []
orig_simil = dice_similarity(ref_fp, this_fp)
for atom in this_mol.get_atoms():
    new_fp = calculate_fingerprint_without_atom
            (this_mol, atom)
    new_simil = dice_similarity(ref_fp, new_fp)
    weight = orig_simil - new_simil
    weights.append(weight)
```@simmaps_cite

== ChemSpaceExplorer <explorer>
// - ChemSpaceExplorer (@ms2query?)
// - analogue search
Ms2Query? @ms2query ?

To find analogues, the ChemSpaceExplorer embeds the query spectrum in a high-dimensional chemical space, using ms2deepscore @ms2deepscore (see @ms2deepscore_chapter).
This chemical space was build by embedding spectra from molecular databases such as #CITE[] also using ms2deepscore.
and selects the nearest neighbours in this space #CITE[NN technique].

== Integrated Similarity Flow <isf>
In the ChemSpaceExplorer the Integrated Similarity Flow (ISF) attempts to address these limitations by ranking analogues based on their query distance weighted by their tanimoto similarity to each other.
However, while the ISF shows great capabilities of ranking the analogues based on confidence of the model, this confidence is not communicated to the user intuitively.
The concept of the ISF score reduces complex relationships to a single metric, requiring users to either trust it or gain an understanding of clustering techniques and how they are used.
One gap so far seems to be the ability to explain and illustrate the similarities between molecular substances.

== Introduction

The prediction and visualization of molecular substructures from mass spectrometry (MS) data represents a fundamental challenge at the intersection of analytical chemistry, computational chemistry, and machine learning. This chapter provides a comprehensive review of the relevant literature spanning six interconnected research areas: mass spectrometry-based structure identification, molecular similarity and fingerprints, chemical space representations, visualization methods, machine learning applications, and benchmarking approaches. These diverse fields converge to enable the transformation of spectral data into structural insights, forming the theoretical foundation for this thesis.

== Mass Spectrometry in Metabolomics and Structure Identification

=== Foundational Approaches and Evolution

Mass spectrometry has emerged as the predominant analytical technique for metabolomics, offering unparalleled sensitivity and throughput for small molecule analysis @Collins2021 @Liebal2020. Traditional approaches to compound identification relied heavily on spectral library matching, where experimental MS/MS spectra are compared against reference spectra using similarity metrics such as cosine similarity. However, these methods face a fundamental limitation: only approximately 2.5% of known natural products have reference spectra in public libraries like the Global Natural Products Social Molecular Networking (GNPS) platform, leaving the vast majority of metabolites unidentifiable through direct matching @Boecker2017.

This identification bottleneck led to the development of computational methods following three main paradigms: combinatorial fragmenters that systematically break molecular bonds to explain fragmentation patterns, spectrum prediction methods that generate theoretical spectra from molecular structures @Allen2014, and structure inference approaches that transform spectra into molecular fingerprints for database searching. Among these, the structure inference paradigm has proven most successful for practical applications.

=== Modern Computational Tools

The field underwent a revolutionary transformation with the introduction of CSI:FingerID by @Duehrkop2015, which established a new paradigm for computational metabolomics. CSI:FingerID combines fragmentation tree computation with machine learning to predict molecular fingerprints directly from MS/MS spectra. The method first computes fragmentation trees using combinatorial optimization to explain parent-fragment relationships, then employs support vector machines trained on extensive spectral libraries to predict molecular fingerprints—binary vectors encoding structural features. These predicted fingerprints enable searching of comprehensive molecular structure databases, achieving 5.4-fold more unique identifications compared to previous methods.

Building on this foundation, @ms2deepscore introduced MS2DeepScore, employing a Siamese neural network architecture to predict structural similarity between compounds directly from MS/MS spectral pairs. The network processes binned spectra through identical base networks to create 200-dimensional spectral embeddings, with cosine similarity between embeddings predicting Tanimoto scores. This approach achieves a root mean squared error of approximately 0.15 for Tanimoto score prediction, substantially outperforming classical spectral similarity measures. The method's Monte-Carlo dropout implementation provides crucial uncertainty quantification, enabling filtering of unreliable predictions.

@ms2query addresses the critical need for reliable analogue searching in mass spectral libraries by integrating multiple machine learning-based similarity predictors with precursor mass information. The system combines Spec2Vec @spec2vec and MS2DeepScore similarity measures through a random forest model, achieving 35% recall rate with average Tanimoto scores of 0.63 for analogues while providing a 7.5-fold speed improvement over traditional methods.

COSMIC (Confidence Of Small Molecule IdentifiCations), developed by @Hoffmann2021, tackles the essential problem of distinguishing correct from incorrect structure annotations in in silico methods. By combining statistical calibration with machine learning classification, COSMIC provides confidence scores between 0 and 1 for ranking annotations, enabling false discovery rate estimation for high-throughput analysis. The method has successfully processed over 20,000 LC-MS/MS datasets, annotating 1,715 novel structures and identifying 315 molecular structures absent from the Human Metabolome Database.

== Molecular Similarity and Fingerprints

=== Theoretical Foundations

Molecular fingerprints serve as the fundamental representation linking mass spectrometry data to chemical structures. As emphasized by @similarity, molecular similarity is inherently subjective and context-dependent, with the "best" representation depending on the specific goals of comparison. This theoretical framework underlies all applications of fingerprints in mass spectrometry-based structure prediction.

Three main types of molecular fingerprints dominate the field. Morgan/circular fingerprints (ECFPs) @morgan encode circular environments around each atom up to a specified radius, creating a "bag of fragments" representing local molecular environments. These fingerprints, particularly ECFP4 and ECFP6 variants, excel at capturing detailed substructural information for small molecules but show decreased performance with molecular complexity. Path-based fingerprints generate fragments by following linear paths through the molecular graph, effectively capturing molecular topology and connectivity patterns. Count-based fingerprints, as described by @count_bits, extend binary representations to integer counts, tracking the frequency of structural features rather than just presence/absence, providing enhanced discrimination for molecules with repetitive motifs @morgan-count.

=== Similarity Measures and Applications

The Tanimoto coefficient remains the gold standard for molecular similarity calculations, defined as the intersection over union of fingerprint bits. With a well-established threshold of 0.85 for significant similarity, it has proven effective across multiple applications despite some size-dependent biases. Alternative measures include the Dice coefficient, cosine similarity, and the Ruzicka coefficient @ruzicka @ruzicka2 for count-based fingerprints.

In mass spectrometry applications, fingerprints enable several critical functions. CSI:FingerID demonstrates how predicted fingerprints can guide database searching, while MS2DeepScore shows that structural similarities can be learned directly from spectral data. The MSEI pipeline combines multiple approaches for structural identification using random forests for direct fingerprint prediction, while MSNovelist generates novel structures from MS/MS spectra by combining fingerprint prediction with neural networks.

== Chemical Space and Structural Representations

=== Molecular Notation Systems

The computational representation of molecular structures forms the foundation for all machine learning approaches in mass spectrometry. SMILES (Simplified Molecular Input Line Entry System) @smiles provides a compact, human-readable linear notation averaging 15 bytes per molecule compared to 612 bytes for Molfile formats. Despite its efficiency, SMILES faces challenges with canonicalization varying between software implementations and difficulties representing organometallic compounds. InChI (International Chemical Identifier) offers a standardized, hierarchical representation with guaranteed uniqueness but sacrifices human readability and can produce very long strings for large molecules.

Graph-based representations, encoding atoms as nodes and bonds as edges, have become increasingly important with the rise of graph neural networks. These representations naturally capture molecular topology through adjacency matrices and feature vectors, enabling sophisticated machine learning approaches that respect molecular structure.

=== Chemical Space Navigation

@chemical_space extensive work on chemical space enumeration reveals the vast scope of possible molecules—estimated at over 10^60 organic molecules below 500 Da. The GDB-17 database alone contains 166.4 billion molecules up to 17 atoms, systematically generated following chemical stability rules. This immense space requires efficient navigation methods, including molecular quantum numbers (MQNs) that define a 42-dimensional descriptor space for rapid similarity searching.

Modern navigation tools range from traditional fingerprint-based similarity searching to advanced methods like FTrees for fuzzy pharmacophore matching and generative models for AI-driven exploration of novel chemical regions @chemical_space2. Major databases like PubChem (>100 million compounds) and ZINC (>37 billion enumerated compounds) provide extensive but still sparse sampling of theoretical chemical space, with significant bias toward drug-like molecules and limited representation of novel scaffolds.

=== Challenges in Diversity Representation

Representing molecular diversity presents multiple challenges. The graph model struggles with delocalized bonding, tautomeric equilibria, and stereochemistry representation. Scale challenges arise as memory requirements increase quadratically with molecule size, while the vast theoretical space contrasts sharply with limited synthetic accessibility—the "needle in a haystack" problem. Data quality issues compound these challenges, with different SMILES representations for the same molecule across databases and inconsistent stereochemistry handling.

== Visualization Methods in Cheminformatics

=== Similarity Maps and Fingerprint Visualization

@simmaps_cite introduced similarity maps as a groundbreaking visualization strategy for understanding molecular fingerprints and machine learning model predictions. Their approach calculates atomic weights by removing bits corresponding to each atom and measuring the resulting similarity difference. This method works with various fingerprint types including atom pairs, circular fingerprints, and extended-connectivity fingerprints, and extends naturally to machine learning models by substituting similarity differences with predicted-probability differences. The open-source implementation using RDKit has become a standard tool in the field.

Modern extensions have integrated similarity mapping with graph neural networks and multi-objective molecule generation, while web-based implementations enable real-time exploration of similarity relationships. These visualizations reveal which molecular features contribute most to similarity assessments or model predictions, providing crucial insights for structure-activity relationship studies @Matveieva2021 @Sheridan2019.

=== Data Visualization in Metabolomics Workflows

@Mildau2024 comprehensive framework establishes visualization as essential throughout the untargeted metabolomics workflow. From raw data processing with chromatogram visualization and peak detection plots, through statistical analysis with volcano plots and heatmaps, to spectral analysis with mirror plots and network visualizations, each stage requires specific visualization approaches. The integration of GUI-based tools like MZmine and MetaboAnalyst with script-based workflows in R and Python enables both accessibility and customization.

Molecular networking approaches, particularly Feature-based Molecular Networking (FBMN) and Ion Identity Molecular Networking (IIMN), organize MS/MS features by spectral similarity, creating visual representations of chemical relationships. Dimensionality reduction techniques like t-SNE @JMLR:v9:vandermaaten08a and UMAP project high-dimensional spectral data to interpretable 2D spaces, while interactive dashboards enable real-time exploration of statistical results with chemical context.

=== Interactive Visualization Technologies

Modern molecular visualization leverages both established platforms and emerging web technologies. Tools like PyMOL and UCSF ChimeraX provide sophisticated 3D molecular visualization, while browser-based solutions using WebGL enable platform-independent access. Chemical space visualization tools such as TMAP handle million-compound datasets through tree-based representations, while ChemPlot and MolCompass provide comprehensive frameworks for chemical space exploration with multiple dimensionality reduction methods.

== Machine Learning Applications

=== Neural Network Architectures for MS Data

The application of deep learning to mass spectrometry has revolutionized structure prediction capabilities. MS2DeepScore's Siamese neural network architecture processes spectral pairs through identical base networks, creating 200-dimensional embeddings that capture chemical relationships. The network employs sophisticated training strategies including balanced sampling to address the highly unbalanced distribution of structural similarities in training data, and extensive data augmentation through peak removal, intensity variations, and noise addition.

Beyond Siamese networks, various architectures have found applications in MS-based structure prediction. Convolutional neural networks excel at raw spectral data processing, with architectures like UwU-net adapted for high-channel MS imaging data. Recurrent neural networks, particularly LSTM variants, capture temporal dependencies in spectral data and find applications in peptide sequencing. Graph neural networks directly process molecular graphs for spectrum prediction, with architectures like MoMS-Net incorporating motif-based information for superior performance. Transformer networks leverage attention mechanisms for processing sequential MS data, offering superior handling of long-range dependencies compared to RNNs.

=== Training Challenges and Solutions

Machine learning applications in mass spectrometry face unique challenges. Unbalanced datasets, where most spectrum pairs have low structural similarity, require sophisticated sampling strategies. Limited training data in specialized domains necessitates transfer learning and data augmentation techniques specific to MS data. Computational efficiency becomes critical when processing large spectral libraries, leading to embedding-based approaches that enable fast similarity calculations.

Interpretability remains a crucial concern, addressed through various explainable AI techniques. SHAP (SHapley Additive exPlanations) @Ancona2019 has become the most widely used method for feature contribution calculation in mass spectrometry applications. Attention mechanisms in transformer-based models naturally provide interpretability by highlighting important spectral regions and molecular substructures. Uncertainty quantification through Monte-Carlo dropout and ensemble methods enables assessment of prediction reliability, critical for safety-sensitive applications @Utkin2019.

== Benchmarking and Evaluation

=== The MassSpecGym Framework

@massspecgym introduced MassSpecGym as the first comprehensive benchmark for molecule discovery and identification from MS/MS data. With 231,000 high-quality labeled MS/MS spectra representing 29,000 unique molecular structures, it defines three fundamental challenges: de novo molecular structure generation, molecule retrieval, and spectrum simulation. The benchmark's novel generalization-demanding split based on Maximum Common Edge Subgraph (MCES) distances @Duesbury2018 ensures no molecules have MCES distance less than 10 between different folds, preventing data leakage more effectively than traditional approaches.

Current baseline results reveal the challenging nature of MS/MS annotation, with zero top-1 accuracy for de novo generation across all methods and state-of-the-art molecule retrieval achieving only 14.64% hit rate at rank 1. These results highlight substantial opportunities for methodological improvements.

=== Evaluation Best Practices

Robust evaluation requires careful attention to data splitting strategies, with scaffold-based, time-based, and chemical similarity-based approaches each serving different validation goals @Gatto2015. Statistical methods including paired tests with multiple comparison corrections and bootstrap confidence intervals ensure reliable performance comparisons. Common pitfalls include subtle data leakage through preprocessing before splitting, selection bias in test set construction, and incomplete documentation hindering reproducibility.

The importance of diverse test sets cannot be overstated, requiring balanced representation across chemical scaffolds, molecular properties, instrumental platforms, and experimental conditions @Kretschmer2024. Future directions point toward standardized evaluation protocols, multi-modal integration, and continuous benchmarking through community initiatives.

== Integration and Future Perspectives

The convergence of these research areas creates unprecedented opportunities for molecular structure prediction from mass spectrometry data. Modern approaches integrate multiple representations—from molecular fingerprints to graph neural networks—with sophisticated visualization methods that bridge computational predictions and chemical interpretation. The success of tools like CSI:FingerID and MS2DeepScore demonstrates the power of combining classical cheminformatics concepts with modern machine learning.

However, significant challenges remain. The vast chemical space remains sparsely sampled, limiting the generalization of current methods. Interpretability of complex models requires continued development of explainable AI techniques tailored to chemical applications. Standardization across platforms, evaluation protocols, and data formats remains incomplete, hindering systematic progress assessment.

For the specific challenge of predicting and visualizing molecular substructures from mass spectrometry, this literature review reveals several key insights. First, the choice of molecular representation—whether SMILES, fingerprints, or graphs—fundamentally impacts prediction performance. Second, visualization methods must serve dual purposes: enabling human interpretation of complex models while revealing chemical insights. Third, robust benchmarking frameworks like MassSpecGym are essential for driving methodological improvements. Finally, the integration of multiple approaches, from spectral similarity prediction to chemical space navigation, offers the most promising path forward.

As this field continues to evolve, the synthesis of established cheminformatics principles with cutting-edge machine learning and visualization technologies will be crucial for advancing our ability to decode molecular structures from mass spectrometry data, ultimately accelerating discovery in metabolomics, natural products research, and drug development.
