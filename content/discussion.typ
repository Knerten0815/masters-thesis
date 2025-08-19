#import "../utils/todo.typ": TODO
#import "../utils/cite-marker.typ": CITE
#import "../utils/fig-marker.typ": FIG
#import "../layout/colors.typ": colors

= Discussion <discussion>
// #TODO[
//   This chapter includes the status of your thesis, a conclusion and an outlook about future work.
// ]

== Findings
// #TODO[
//   Interpret the results and conclude interesting findings
// ]
The results reveal a fundamental dependence of Stacked Similarity Map performance on the similarity distribution within analogue groups, challenging the assumption that more analogues always improve structural inference.

=== Similarity-Dependent Optimal Group Size
The opposing trends in SQS across benchmarks indicate that optimal group size is not universal but depends on query-to-analogue similarity levels.
In high-similarity scenarios (Stacked Similarity benchmark), the SQS peaked at $n=3$ and declined thereafter, suggesting that additional highly similar compounds introduce redundant information.// that dilutes the signal. This finding aligns with information theory principles where redundant data can reduce the signal-to-noise ratio in molecular feature extraction #CITE[].

Conversely, in the ChemSpaceExplorer benchmark with lower and more diverse similarities, the monotonic increase in SQS up to $n=10$ suggests that diverse analogues compensate for individual limitations. When individual compounds provide incomplete structural information due to lower similarity, larger groups aggregate partial information to improve overall inference capability provided by the SSMs.

=== Metric Stability and Reliability
The remarkably low standard deviation of SQS in the Stacked Similarity benchmark (0.002393) compared to the ChemSpaceExplorer benchmark (0.036870) demonstrates that the metric exhibits greater stability under controlled conditions with high similarities. This stability indicates that SQS is a reliable metric for evaluating structural inference when working with highly similar molecular sets.

//=== Validation Through Correlation Analysis

=== Chemical Space Evaluation Capability
The contrasting behavior of SQS across different similarity contexts demonstrates that this metric can effectively distinguish between scenarios where analogues provide meaningful structural information versus those where they introduce noise.
This capability positions Stacked Similarity Maps as a valuable tool for chemical space exploration and analogue selection strategies.
However, as mentioned in @problem they should not be used

// === Methodological Considerations
// The consistent behavior of query similarity, MQW, and SQS in the Dissimilarity benchmark validates the robustness of these metrics when analogues provide minimal structural information. This stability is crucial for automated systems that must handle diverse datasets with varying quality.

// The ISF score validation in the ChemSpaceExplorer benchmark strengthens confidence in the ground truth relationships between similarity metrics and actual structural inference performance, supporting the use of these metrics as proxies for molecular understanding.

== Limitations
// #TODO[
//   Describe limitations and threats to validity of your evaluation, e.g. reliability, generalizability, selection bias, researcher bias
// ]
=== Analogue Sampling
Unfortantely it was not possible to sample groups with more than 10 analogues from the _ms2structures_ dataset, without compromising on the number of query samples or the minimum query-to-analogue similarity. Selecting 16 or 12 analogues for each query would reduce the sample size to 529 or 836 queries respectively. @dataset also features _biostructures_combined_ with 730,464 unique compounds, which could support sampling larger analogue groups, potentially using higher similarity thresholds too. The bottleneck was not the selection of analogues itself, but rather the calculation of the 730,464x730,464 matrix, used to look up compound similarities. The 16 GB RAM of the machine used to compute the similarity matrix could barely handle the task on the _ms2structures_ dataset. This would have required a machine with enormous RAM or rewriting the code to only partially compute, save and load the matrix, which would have gone beyond the scope of this thesis.

=== No Human Evaluation

A significant limitation of this work is the absence of human subject evaluation to validate the claimed "intuitiveness" of Stacked Similarity Maps. While the computational benchmarks demonstrate the technical functionality and context-dependent behavior of the visualization technique, they cannot assess whether practicing chemists and mass spectrometry analysts actually find the visualizations intuitive, interpretable, or useful for their research workflows.

User studies are particularly crucial for visualization techniques because the ultimate goal is to augment human decision-making and pattern recognition capabilities. Without empirical evidence from domain experts, several critical questions remain unanswered: Do the color-coded similarity patterns in SSMs actually help researchers identify meaningful molecular relationships? Can users correctly interpret the distinction between high and low group similarity scenarios? Does the visualization reduce cognitive load compared to examining individual similarity maps or numerical similarity scores?

The lack of human validation limits the generalizability of claims about visualization effectiveness and represents a gap between computational performance and practical utility in real-world chemical analysis contexts.


== Conclusion
// #TODO[
//   Recap shortly which problem you solved in your thesis and discuss your *contributions* here.
// ]

// This thesis successfully addressed the primary research objective of evaluating how group size affects Stacked Similarity Map performance across different similarity contexts. The comprehensive benchmark evaluation revealed critical insights into optimal analogue selection strategies while highlighting areas requiring further investigation.
// This thesis addressed the fundamental question of how group size affects molecular similarity assessment and structural inference capability in Stacked Similarity Maps.
The research challenged the conventional assumption that larger analogue groups universally improve molecular understanding by demonstrating that optimal group size depends critically on the similarity distribution within analogue sets.

=== Key Contributions

*Introduced Stacked Similarity Maps:* //Validated SQS as a robust metric for evaluating structural inference capability, demonstrating its sensitivity to meaningful similarity differences while maintaining stability under controlled conditions. The metric's behavior patterns provide insights into when analogues contribute meaningful versus redundant information.
_This should be more about the Viz Tech, and that it works proven by the metrics, than about the metrics itself!_
_Metric Validation:_ Established SQS as a reliable metric for assessing structural inference capability, with validation through ISF score correlation and consistent behavior across controlled conditions. *FALSCH!!!* The metric demonstrated appropriate sensitivity to similarity context while maintaining stability in controlled scenarios.

*Methodological Framework:* Developed a comprehensive benchmarking approach that can be applied to evaluate other molecular similarity methods and datasets. The three-benchmark design (controlled high-similarity, diverse low-similarity, and dissimilarity scenarios) provides a template for systematic evaluation of molecular similarity tools.

_Benchmark Development:_ Successfully implemented three distinct benchmark scenarios (Stacked Similarity, ChemSpaceExplorer, and Dissimilarity) that systematically evaluate group size effects across different similarity distributions. Each benchmark was designed to isolate specific aspects of molecular similarity and structural inference.

*Similarity Context Analysis:* Demonstrated that optimal group size is not universal but depends critically on query-to-analogue similarity distributions. This finding challenges existing assumptions in cheminformatics and provides practical guidance for analogue selection.

// *Computational Implementation:* Developed robust computational workflows for similarity matrix calculation, analogue sampling, and metric evaluation that can handle large molecular datasets within reasonable computational constraints.

_Context-Dependent Optimization:_ Established that optimal group size varies with similarity context - small groups (n=3) for high-similarity scenarios and larger groups (up to n=10) for diverse, lower-similarity datasets. This finding provides actionable guidance for analogue selection in cheminformatics applications.

*Software Implementation:* Developed and integrated a comprehensive Python module (`similarity_maps.py`) into the ChemSpaceExplorer codebase, providing reusable functionality for generating Stacked Similarity Maps with support for multiple fingerprint algorithms and visualization formats.

These contributions advance both the theoretical understanding of molecular similarity and its practical applications in drug discovery, virtual screening, and chemical space analysis. The findings provide evidence-based recommendations for optimizing analogue selection strategies across different chemical contexts.


== Future Work
// #TODO[
//   Tell us the next steps (that you would do if you have more time). Be creative, visionary and open-minded here.
// ]

The findings open several promising avenues for advancing molecular similarity assessment and chemical space exploration methodologies.

=== Adress Limitations

*Large-Scale Group Analysis:* Future work should extend the analysis to group sizes beyond n=10 using high-performance computing resources or distributed computing approaches. Understanding the complete trajectory of SQS performance with increasing group size would inform practical limits for analogue selection and reveal whether performance eventually plateaus or decreases.

*Enhanced Similarity Frameworks:* Investigation with higher similarity thresholds (0.75 or 0.8) could establish more robust baseline assumptions for high-similarity scenarios. Additionally, systematic optimization of similarity thresholds across different molecular classes could provide context-specific recommendations.

*Alternative Molecular Representations:* Evaluation with diverse molecular descriptors beyond Morgan fingerprints, including 3D pharmacophores, quantum chemical descriptors, and graph neural network embeddings, would test the generalizability of the similarity-dependent optimization principles.

=== Methodological Extensions
*Real Interpretability* _query spectrum peaks should directly highlight which Atoms or substructures in the analogues they correspond too. As well as show the anlogues spectra in a mirror plot. While molecular structure carries the most information, the input stays a spectrum and the the confidence interpretation should respect that.
  Researchers experienced in the process of annotating spectra can be supportet the best this way and check if the analgue prediction makes sense, based on the query spectra_

*Dynamic Group Selection:* Develop adaptive algorithms that automatically determine optimal group size based on the similarity distribution of available analogues, eliminating the need for manual threshold selection.

*Multi-Objective Optimization:* Integrate additional criteria beyond structural inference capability, such as chemical diversity, synthetic accessibility, or biological activity prediction, to provide holistic analogue selection recommendations.

*Real-Time Applications:* Implement the findings in interactive chemical space exploration tools that provide real-time optimization suggestions based on user queries and available molecular databases.

=== Human-Centered Validation

*User Study Design:* Conduct comprehensive user studies with practicing mass spectrometry analysts, medicinal chemists, and metabolomics researchers to empirically validate the intuitiveness and effectiveness of Stacked Similarity Maps. Such studies should employ task-based evaluations where participants interpret SSM visualizations to make structural predictions, with performance measured against ground truth molecular structures.

*Comparative Usability Assessment:* Design controlled experiments comparing SSM visualizations against traditional approaches (individual similarity maps, numerical similarity tables, molecular structure grids) to quantify improvements in interpretation speed, accuracy, and user confidence. These studies would provide crucial evidence for the claimed benefits of group-based similarity visualization.

*Interactive Interface Development:* Develop and evaluate interactive interfaces that allow users to manipulate group sizes, similarity thresholds, and fingerprint parameters in real-time, studying how domain experts adapt these parameters for different analytical scenarios. Understanding user preferences and workflows would inform optimal default settings and interface design principles.

*Training and Adoption Studies:* Investigate learning curves and training requirements for SSM interpretation, particularly for novice users, to develop educational resources and assess the technique's accessibility across different expertise levels in the chemical sciences.

=== Broader Applications

*Cross-Domain Validation:* Apply the methodology to other molecular types (biologics, natural products, materials) and different application domains (toxicology, environmental chemistry, materials science) to establish broader applicability.

*Integration with Machine Learning:* Investigate how these findings integrate with modern machine learning approaches for molecular property prediction and drug design, potentially improving training set selection strategies.

*Experimental Validation:* Collaborate with experimental groups to validate the computational findings through structure-activity relationship studies, providing real-world evidence for the optimal group size recommendations.

=== Open Goals
// #TODO[
//   Describe honestly the achieved goals (e.g. the well implemented and tested use cases) and the open goals here. if you only have achieved goals, you did something wrong in your analysis.
// ]

*Extended Group Size Analysis:* The computational limitations prevented evaluation of group sizes beyond n=10, leaving questions about long-term trends in SQS performance unanswered. Whether SQS continues to improve, plateaus, or eventually decreases with larger groups in diverse similarity contexts remains unknown.

// *Similarity Threshold Optimization:* The study used fixed similarity thresholds without systematic optimization. Investigation of how different threshold selections affect optimal group size recommendations would strengthen the practical applicability of the findings.

*Alternative Similarity Metrics:* The analysis relied primarily on Morgan fingerprint-based similarities. Evaluation with alternative molecular descriptors (3D pharmacophores, quantum chemical descriptors, or graph-based similarities) could reveal whether the findings generalize across different molecular representations.

*Real-World Validation:* While the benchmarks provide controlled evaluation environments, validation with actual drug discovery projects or experimental structure-activity relationships would strengthen the practical relevance of the findings.
