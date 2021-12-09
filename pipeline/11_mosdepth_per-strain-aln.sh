#!/usr/bin/bash
#SBATCH --nodes 1 --ntasks 24 --time 2:00:00 -p short --mem 64G --out mosdepth_per-strain.parallel.log
#SBATCH -J modepth
# This one goes to 11
module load parallel
CPU=$SLURM_CPUS_ON_NODE
if [ ! $CPU ]; then
 CPU=2
fi
module load mosdepth
mkdir -p coverage/mosdepth_per-strain coverage/mosdepth_total_per-strain
source config.txt

for WINDOW in 5000 10000 50000
do
	#parallel --jobs $CPU mosdepth -f $REFGENOME -T 1,10,50,100,200 -n --by $WINDOW -t 2 "{= s:$ALNFOLDER\/:coverage/mosdepth/:; s:\.$HTCEXT:.${WINDOW}bp: =}" {} ::: $(ls $ALNFOLDER/*.$HTCEXT)
	parallel -vv -j $CPU mosdepth -n -t 2 -f genome_per-strain/{/.}_fullMito.fasta  "{= s:$ALNFOLDER\/:coverage/mosdepth_total_per-strain/:; s:\.$HTCEXT:: =}" {} ::: $(ls $ALNFOLDER/*.$HTCEXT) 
done

