#!/usr/bin/bash
#SBATCH -p short -N 1 -n 8 --mem 8gb --out logs/rm_classify.log
CPU=8
module load fasta
DB=/srv/projects/db/Swissprot/2020_12/uniprot_sprot.fasta
QUERY=lib/consensi.fa.classified
fasty36 -E 1e-3 -T $CPU -m 8c $QUERY $DB > $QUERY.FASTA.tab
