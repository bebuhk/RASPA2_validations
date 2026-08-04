# GCMC simulation from Vincent to reproduce Vext (incl Tailcorrection) of cDFT (or vice versa)

Bene 2026-07-30

Vincent sent this on 30.7.26 (and probably did this 2 years ago before publishing his paper.) (foldes was named "RSM0158").

he did not manage to exactly reproduce the tail correction (i think).


## 2.8.26: Validated tail-correction

In *_tail_validation_results*, the computation of the tail-correction in RASPA is derived and the contribution decomposed to retrieve the part from fluid-solid interactions relevant for cDFT.


# General Tutorial

## Choose the adsorbate(s) molecule(s)

### Single site

in *CH4_test.def* -> define name for each group (here *CH4_BB*).

*pseudo_atoms.def* defines the charges (and mass,...)

in *force_field_mixing_rules.def*, the LJ parameters of each group (e.g. *CH4_BB*) must be defined.