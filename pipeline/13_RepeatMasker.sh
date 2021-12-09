#!/usr/bin/bash
#SBATCH -p short -N 1 -n 48 --out logs/RM_run.log --mem 64gb

module load RepeatMasker
DB=lib/all_repeats.fungi_curated.fa
#DB=genome/Ophidiomyces_ophiodiicola_AN0400001-families.fa
QUERY=genome/Ophidiomyces_ophiodiicola_AN0400001.fasta
BASE=$(basename $QUERY .fasta)
OUTDIR=$(dirname $QUERY)
CPU=4
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi
CPU=$(expr $CPU / 4)
echo "CPU=$CPU"
RepeatMasker -e rmblast -s -pa $CPU  -gff -lib $DB $QUERY > $OUTDIR/$BASE.RM.out
