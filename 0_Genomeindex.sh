# Genome index
module load BWA/0.7.17-20220923-GCCcore-12.3.0
module load SAMtools/1.18-GCC-12.3.0
module load GATK/4.5.0.0-GCCcore-12.3.0-Java-17

gunzip -c CreinhardtiiCC_4532_707_v6.0.fa.gz > CreinhardtiiCC_4532_707_v6.0.fa
bwa index CreinhardtiiCC_4532_707_v6.0.fa

gunzip -c CreinhardtiiCC_4532_707_v6.0.fa.gz > CreinhardtiiCC_4532_707_v6.0.fa
samtools faidx CreinhardtiiCC_4532_707_v6.0.fa

gatk CreateSequenceDictionary \
    -R CreinhardtiiCC_4532_707_v6.0.fa \
    -O CreinhardtiiCC_4532_707_v6.0.dict



