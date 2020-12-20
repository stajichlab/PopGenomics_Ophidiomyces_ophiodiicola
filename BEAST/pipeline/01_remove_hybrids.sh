#!/usr/bin/bash
#SBATCH -p short -N 1 -n 2 --mem 8gb

module load bcftools/1.11
INDIR=../vcf
bcftools view --samples-file non-hybrids.txt -o NAU-USGS.SNP.strain_cull_hybrids.vcf.gz -Oz $INDIR/NAU-USGS.SNP.combined_selected.vcf.gz

bcftools view -e 'AC==0 || AC==AN || F_MISSING > 0.0' -o NAU-USGS.SNP.strain_cull_hybrids_missing.vcf NAU-USGS.SNP.strain_cull_hybrids.vcf.gz
