#!/usr/bin/bash
#SBATCH -p short -N 1 -n 24 --mem 24gb 
module load bcftools
module unload perl
module load parallel
module load plink/2
CPU=2
print_fas() {
	printf ">%s\n%s\n" $1 $(bcftools view -e 'AF=1' $2 | bcftools query -e 'INFO/AF < 0.1' -s $1 -f '[%TGT]' | perl -p -e 's/\/\w//g') 
}

export -f print_fas
invcf=NAU-USGS.SNP.strain_cull_hybrids_missing.vcf
vcf=NAU-USGS.SNP.strain_cull_hybrids_missing.subsample.vcf
base=$(basename $vcf .vcf)
plink2 --vcf $invcf --thin-count 5000 --export vcf-4.2 --out $base --allow-extra-chr

FAS=$base.mfa
REFNAME=AN0400001
printf ">%s\n%s\n" $REFNAME $(bcftools view -e 'AF=1' ${vcf} | bcftools query -e 'INFO/AF < 0.1' -f '%REF') > $FAS
parallel -j $CPU print_fas ::: $(bcftools query -l ${vcf}) ::: $vcf >> $FAS

perl -ip -e 'if(/^>/){s/[\(\)#]/_/g; s/_+/_/g } else {s/[\*.]/-/g }' $FAS
