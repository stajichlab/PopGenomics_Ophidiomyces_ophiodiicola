#!/usr/bin/bash
module load samtools/1.9
module load bwa/0.7.17
module load picard
if [ -f config.txt ]; then
	source config.txt
fi
FASTAFILE=$REFGENOME
echo "working off $FASTAFILE - check if these don't match may need to update config/init script"

if [[ ! -f $FASTAFILE.fai || $FASTAFILE -nt $FASTAFILE.fai ]]; then
	samtools faidx $FASTAFILE
fi
if [[ ! -f $FASTAFILE.bwt || $FASTAFILE -nt $FASTAFILE.bwt ]]; then
	bwa index $FASTAFILE
fi

DICT=$(basename $FASTAFILE .fasta)".dict"

if [[ ! -f $DICT || $FASTAFILE -nt $DICT ]]; then
	rm -f $DICT
	picard CreateSequenceDictionary R=$FASTAFILE O=$DICT
	ln -s $DICT $FASTAFILE.dict 
fi
