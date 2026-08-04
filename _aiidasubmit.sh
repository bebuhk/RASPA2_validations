#!/bin/bash
exec > _scheduler-stdout.txt
exec 2> _scheduler-stderr.txt


 

export RASPA_DIR=/home/vdufour/aiida2/aiida-lsmo-codes/data/raspa
export DYLD_LIBRARY_PATH=/home/vdufour/aiida2/aiida-lsmo-codes/lib/raspa_4467e14_ubu18
export LD_LIBRARY_PATH=/home/vdufour/aiida2/aiida-lsmo-codes/lib/raspa_4467e14_ubu18


'/home/vdufour/aiida2/aiida-lsmo-codes/bin/simulate_4467e14_ubu18' 'simulation.input'   

 

 
