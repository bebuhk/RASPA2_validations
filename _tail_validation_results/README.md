# 2026-08-03 bene. tail correction validation

with these results i understood the tail correction.

## 1. simulations with test.cif (just one atom) and CH4_BB 

here i simulated a simple unitcell with just one atom and 10 ang cubic cell. the atom i gave LJ parameters sigma=1 and eps=10 (same for the adsorbate CH4_BB). when constructing a 333 supercell (sc), the tail correction becomes

```python
sigma = 1.0
eps = 10
rcut = 14
V_super = 1000*27
N_tot = (27 * 1 + 1)**2
I = (4/3) * eps * sigma**3 * (1/3*(sigma/rcut)**9 - (sigma/rcut)**3)  # K * A^3
per_pair_tail = 2*np.pi* I / V_super # = -1.1307607222082433e-06
# tail_total = N_pairs * (-1.1307607222082433e-06) = N_sites**2 * (-1.1307607222082433e-06)
```

when introducing more atoms (all same LJ params, no matter if adsorbate or framework, they are treated invariantly in raspa anyways), the single particle tail correction value increases with N^2. 

#### some notes

the number of pair interactions between N particles are depending on how you count them. if you draw them as points and connect them with arrows from each point to each other point, you can count a) double arrows: all interactions between different particles. b) double count double arrows (same but counting 1-2 AND 2-1) c) count # of arrows (single (i.e. self interactions) and double count same) and d) 

| N | N(N-1)/2 | N(N-1) | N(N+1)/2 | N^2 |
|---|---:|---:|---:|---:|
| N | $ \frac{1}{2}\sum_{i \neq j} u_{ij} = \sum_{i < j} u_{ij} = \sum_{i}^N \sum_{j}^{i-1}  u_{ij}$ | $\sum_{i \neq j} u_{ij}$ | N(N-1)/2 + N $\sum_{i \le j} u_{ij}$ | $\sum_{i}^N \sum_{j}^{N} u_{ij}$|
| 1 | 0 | 0 | 1 | 1 |
| 2 | 1 | 2 | 3 | 4 |
| 3 | 3 | 6 | 6 | 9 |
| 4 | 6 | 12 | 10 | 16 |
| 5 | 10 | 20 | 15 | 25 |
| 6 | 15 | 30 | 21 | 36 |
| 7 | 21 | 42 | 28 | 49 |
| count: | double arrows | double-count da | arrows (s/d) | arrowheads |

the right column is used in raspa. so if we got 3 identical particles, the tail correction for that sigma and eps according to 

$$\frac{8}{3}\pi\,\varepsilon\sigma^{3}
\left[\frac{1}{3}\left(\frac{\sigma}{r_c}\right)^{9}-\left(\frac{\sigma}{r_c}\right)^{3}\right]$$

which is multiplied with the density of the particles $$\rho = N / V$$.

so that the tail correction per particle is

$$u_{\text{tail}} = 2\pi\rho\int_{r_c}^{\infty} r^2\,u(r)\,\mathrm{d}r
= \frac{8}{3}\pi\rho\,\varepsilon\sigma^{3}
\left[\frac{1}{3}\left(\frac{\sigma}{r_c}\right)^{9}-\left(\frac{\sigma}{r_c}\right)^{3}\right]$$

and the total energy 

$$U_{\text{tail}} = N \cdot u_{\text{tail}}$$


(claude says this N^2 is an approximation cause the real number of pairs is N(N-1), but for large N is doesnt matter... see chat raspa->framework-only-gcmc)

## 2. simulations for RSM0016 and CH4 (in this folder) 

work in progress....

| system | tail-energy [K] | notes |
|---|---|---|
| RSM0016 (111) | -106.65947579 |  |
| RSM0016 (111) + 1 CH4| -149.92482068 | difference: -43.26534489000001 |
| RSM0016 (333)| -2879.80584621 |  |
| RSM0016 (333) + 1 CH4| -2919.73581935 | difference: -39.92997314000013 |

the differenct between the framework with one adsorbate and the framework alone is -149.92482068 - (-106.65947579) = -43.26534489000001. this value compramises the value of the tail correction for adsorbate-framework interaction AND the adsorbate-adsorbate interaction. for cDFT, we are only interested in the former, which is in this case -39.80169029 (computed directly, see ipynb.).


or for the 333 supercell the difference is only -2919.73581935 - (-2879.80584621)= -39.92997314000013 cause here the self (i.e. adsorbate-adsorbate) interaction is normalized by the value of the supercell (which is 27 times larger that the unit cell.) the difference in self interaction is 3.3353717499998794 K, hence the self-interaction term in the 333 simulation is -3.3353717499998794/26 = -0,1282835288. from here we get the tail correction for adsorbate-framework interaction as -39.92997314000013-(-0,1282835288) = -39,8016896112. 

#### some thoughts

this means that Vincent implementation of the tail correction is validated!

## 3. simulations for RSM0016 and CO2 (also in this folder)

| system | tail-energy [K] | notes |
|---|---|---|
| RSM0016 (111) | -106.65947579 |  |
| RSM0016 (111) + 1 CO2| -147.67313013 | difference: -41,01365434 |
| RSM0016 (333) | -2879.80584621 |  |
| RSM0016 (333) + 1 CO2| -2917.61349464 | difference: -37,80764843 |

hence, the difference between the differences (which contain s-f and f-f tail corrections) is -3,20600591. dividing by 26 gives = -0,1233079196 gives again the self interaction (ff) of the 333 supercell. so the s-f tail correction is -37,6843405104.


$$        I(\sigma_{ab}, \varepsilon_{ab})
        = \int_{r_c}^{\infty} r^2\, u_{ab}^{\mathrm{LJ}}(r)\, \mathrm{d}r
        = \frac{8}{3}\pi\varepsilon_{ab}\sigma_{ab}^{3}
          \left[\frac{1}{3}\left(\frac{\sigma_{ab}}{r_c}\right)^{9}
                - \left(\frac{\sigma_{ab}}{r_c}\right)^{3}\right]$$


$$U_{tail,RASPA} = N^2 \cdot \frac{8}{3}\pi\, \frac{1}{V} \,\varepsilon\sigma^{3}
\left[\frac{1}{3}\left(\frac{\sigma}{r_c}\right)^{9}-\left(\frac{\sigma}{r_c}\right)^{3}\right] =  N^2 \cdot I(\sigma, \varepsilon)$$

so that 

$$U_{tail,RASPA} = \sum_i^N \sum_j^N \cdot I(\sigma_{ij}, \varepsilon_{ij})$$

and 

$$U_{tail,s-f} = 2 \cdot \sum_i^{N_s} \sum_j^{N_f} \cdot I(\sigma_{ij}, \varepsilon_{ij})$$