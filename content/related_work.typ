#import "/utils/todo.typ": TODO
#import "../utils/cite-marker.typ": CITE


= Related Work<related-work>
#TODO[
  Describe related work regarding your topic and emphasize your (scientific) contribution in contrast to existing approaches / concepts / workflows. Related work is usually current research by others and you defend yourself against the statement: “Why is your thesis relevant? The problem was al- ready solved by XYZ.” If you have multiple related works, use subsections to separate them.
]
== Similarity maps <simmaps_ch>
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
- ChemSpaceExplorer (@ms2query?)
- analogue search

== Integrated Similarity Flow <isf>
