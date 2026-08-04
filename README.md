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

## ...

tbc

## run simulation

```bash run.sh```

should output something like

```
_cell_length_a: 4.016800
_cell_length_b: 9.566050
_cell_length_c: 9.551720
_cell_length_alpha: 87.725570
_cell_length_beta: 101.961050
_cell_length_gamma: 101.938210
_symmetry_space_group_name_Hall: P 1 found space group: 1
_symmetry_space_group_name_H-M: P 1 found space group: 1
space group found from symmetry elements: 1 (nr elements: 1)
End reading cif-file
Writing Crash-file!: 0
```

and creates the folders CrashRestart/,
Movies/,
Output/,
Restart/,
and VTK/
(all in gitignore). Most important simulation results are in the test file

**Output/System_0/output_FRAMEWORK_X.X.X_Temp_29806.3.data**

(e.g. **Output/System_0/output_RSM0016_1.1.1_298.150000_29806.3.data**).

Here you find for example the Tail correction energy:

Tail-correction energy:                                    -147.67313013.