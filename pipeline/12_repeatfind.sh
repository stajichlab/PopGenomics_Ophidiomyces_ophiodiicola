#!/usr/bin/bash
#SBATCH -p batch -N 1 -n 24 --mem 64gb --out logs/RM_find.log
module load RepeatModeler/2.0.1
CPU=1
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi
NAME=genome/Ophidiomyces_ophiodiicola_AN0400001
BuildDatabase -name $NAME $NAME.fasta

RepeatModeler -database $NAME -pa $CPU  -LTRStruct
