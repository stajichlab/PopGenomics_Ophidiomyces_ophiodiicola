#!/usr/bin/bash
#SBATCH -p short -N 1 -n 8 --mem 8gb --out logs/rm_classify_blast.log -J blastxRM
CPU=8
module load ncbi-blast/2.11.0+
DB=/srv/projects/db/Swissprot/2020_12/uniprot_sprot.fasta
QUERY=lib/consensi.fa.classified
blastx -query $DB -db $DB -task blastx -out $QUERY.BLASTX.tab -max_intron_length 750 -outfmt 6 -evalue 1e-5 -num_threads $CPU
