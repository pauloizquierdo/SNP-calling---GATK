#!/bin/bash --login
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --array=4-60
#SBATCH --mem=50GB
#SBATCH --job-name=combine
#SBATCH --time=01:30:00
#SBATCH --output=slurm_combine_%A_%a.out
#SBATCH --error=slurm_combine_%A_%a.err

cd /mnt/scratch/izquier7/DNA_seq_Chlamydomonas/SNP_calling_pipeline

module purge
module load GATK/4.5.0.0-GCCcore-12.3.0-Java-17

# Set intervals to create GenomicsDB
INT=$(awk "NR==${SLURM_ARRAY_TASK_ID}" ../reference_genome/intervals.txt | cut -f1)

# Build a GenomicsDB database organized by chromosomes and contigs.
gatk --java-options "-Xms40g -Xmx40g -XX:ParallelGCThreads=2" GenomicsDBImport \
   --genomicsdb-workspace-path DBImport/$INT  \
  -V genotyping/ccm31_S75_L004_sorted_dedup.vcf.gz \
  -V genotyping/ccm47_S78_L004_sorted_dedup.vcf.gz \
  -V genotyping/ccm5_S72_L004_sorted_dedup.vcf.gz \
  -V genotyping/con2_S63_L004_sorted_dedup.vcf.gz \
  -V genotyping/con4_S66_L004_sorted_dedup.vcf.gz \
  -V genotyping/con5_S69_L004_sorted_dedup.vcf.gz \
  -V genotyping/f2b1-16_S83_L004_sorted_dedup.vcf.gz \
  -V genotyping/f2b1-3_S80_L004_sorted_dedup.vcf.gz \
  -V genotyping/f2b1-31_S86_L004_sorted_dedup.vcf.gz \
  -V genotyping/fad4-20_S73_L004_sorted_dedup.vcf.gz \
  -V genotyping/fad4-37_S76_L004_sorted_dedup.vcf.gz \
  -V genotyping/fad4-46_S79_L004_sorted_dedup.vcf.gz \
  -V genotyping/fad4-47_S82_L004_sorted_dedup.vcf.gz \
  -V genotyping/fdx2-c2_S65_L004_sorted_dedup.vcf.gz \
  -V genotyping/fdx2-c8_S85_L004_sorted_dedup.vcf.gz \
  -V genotyping/fdx2-D4_S68_L004_sorted_dedup.vcf.gz \
  -V genotyping/fl1_S67_L004_sorted_dedup.vcf.gz \
  -V genotyping/fl32_S70_L004_sorted_dedup.vcf.gz \
  -V genotyping/rca-2_S71_L004_sorted_dedup.vcf.gz \
  -V genotyping/rca-21_S74_L004_sorted_dedup.vcf.gz \
  -V genotyping/rca-45_S77_L004_sorted_dedup.vcf.gz \
  -V genotyping/zcp2-13_S64_L004_sorted_dedup.vcf.gz \
  -V genotyping/zcp2-3_S81_L004_sorted_dedup.vcf.gz \
  -V genotyping/zcp2-5_S84_L004_sorted_dedup.vcf.gz \
  -L $INT \
  --tmp-dir /mnt/gs21/scratch/izquier7 \
  --reader-threads 2

scontrol show job $SLURM_JOB_ID > GenomicsDBImport_job_info.txt 