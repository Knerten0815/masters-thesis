#import "/utils/todo.typ": TODO

= Introduction
#TODO[
	Introduce the topic of your thesis, e.g. with a little historical overview:
]
- mass spectrums are used to derive molecular structural data
	- complex manual process _(is there a name for the process?)_
	- _is there actually another use case for MS?_
- Why is molecular structural data important:
		- metabolomics _(TODO: what is this actually?)_, natural products _(and this?)_, drug discovery
- How is molecular similarity used in this context:
	- properties of unknown moles can be derived from known moles
	- fingerprints, similarity maps
- Describe matchms @Huber2020, ms2deepscore @Huber2021, ChemSpaceExplorer
- Similarity of Spectra via distance in chemcical space
	- the molecular structure of spectra in the ChemSpace is known
	- molecular structure of similiar spectra can assist the process of finding the molecular strucutre to MS

== Problem
#TODO[
	Describe the problem that you like to address in your thesis to show the importance of your work. Focus on the negative symptoms of the currently available solution.
]
- Deriving the molecular structure from a MS is a complex manual process
- ChemSpaceExplorer outputs similiar spectra, but there is no intuitive explanation for similarity
	- the distances to the similiar spectra might help interpret the certainty of the model
	- but it does not explain why the model is certain
	- because it lacks feature importance of the input

== Motivation
#TODO[
	Motivate scientifically why solving this problem is necessary. What kind of benefits do we have by solving the problem?
]
- adding feature importance explains why the model thinks the spectra are similiar
- this can help interpret the model
- providing structural data from similiar spectra can assist the process of deriving the structure from the MS
- and lower the complexity of this process

== Objectives
#TODO[
	Describe the research goals and/or research questions and how you address them by summarizing what you want to achieve in your thesis, e.g. developing a system and then evaluating it.
]
- visualize which MS peaks were important, to find similiar spectra
- visualize the sub-structures these peaks are associated with in the similiar spectra
- visualize common sub-structures among the similiar spectra _(kinda done)_
- evaluate occurance of found sub-structures in the actual molecular structure of the MS
- (optional) evaluate the usefulness of the visualization
- (optional) generate a molecular structure of the MS based on the sub-structures found in the similiar spectra
	- and evaluate the correctness of this structure

== Outline
#TODO[
	Describe the outline of your thesis
]
This thesis is structured as follows:

*Chapter 2: Background* introduces the fundamental concepts of mass spectrometry, molecular structure analysis, and similarity measures in chemical space. It explains the process of deriving molecular structures from mass spectra and describes the technical foundations of tools like matchms, ms2deepscore, and ChemSpaceExplorer.

*Chapter 3: Related Work* presents existing approaches for molecular structure analysis, chemical similarity visualization, and feature importance in machine learning models for chemical analysis.

*Chapter 4: Requirements Analysis* outlines the functional and non-functional requirements for visualizing feature importance in mass spectrometry analysis and molecular structure derivation.

*Chapter 5: System Design* details the architecture and implementation of the visualization system, focusing on the integration with ChemSpaceExplorer and the methods for identifying and displaying important MS peaks and their associated molecular sub-structures.

*Chapter 6: Evaluation* assesses the effectiveness of the visualization system through:
- Validation of identified sub-structures against known molecular structures
- User studies on the interpretability of the visualizations

*Chapter 7: Summary and Future Work* concludes the thesis by summarizing the main contributions and discussing potential future improvements and applications.