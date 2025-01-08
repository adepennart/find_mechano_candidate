#!/bin/bash
#script to for loop through each insect species and print respective plot

# read through file and create variables
cat mechano_aegypti_fna.txt | while read line;
do 
id=$(echo $line);
#species=$(echo $line|cut -d ' ' -f 2);
#species="${genus}_${species}";
#echo ${species};
#didn't work
#echo "esearch -db protein -query '${species} cytochrome oxidase subunit I' | efetch -format fasta >> output/cox.fasta" >> get_beetle_cox_part2;
#echo "esearch -db protein -query '${species}' | efetch -format fasta >> output/cox.fasta" >> get_beetle_cox_part2;
#echo "esearch -db nucleotide -query 'aedes aegypti ${id}' | efetch -format fasta >> mechano_aegypti.fna" >> mechano_aegypti_fasta2.sh;
elink -db gene -id ${id} -target nuccore -name gene_nuccore_refseqrna| efetch -format fasta >> mechano_aegypti_mRNA.fna;
esummary -db gene -id ${id} \
  | xtract -pattern DocumentSummary -if GenomicInfoType -element Id \
    -block GenomicInfoType -element ChrAccVer ChrStart ChrStop \
  | while read -r gene_id chr_acc chr_start chr_stop ; do 
    efetch -db nuccore -id $chr_acc -chr_start $chr_start -chr_stop $chr_stop -format fasta  >> mechano_aegypti_CDS.fna; 
    done;
done
