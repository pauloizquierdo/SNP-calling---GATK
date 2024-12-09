#!/bin/bash --login
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --array=2-60
#SBATCH --mem=40GB
#SBATCH --job-name=genotype
#SBATCH --time=01:30:00
#SBATCH --output=slurm_combine_%A_%a.out
#SBATCH --error=slurm_combine_%A_%a.err

cd /mnt/scratch/izquier7/DNA_seq_Chlamydomonas/SNP_calling_pipeline

module purge
module load GATK/4.5.0.0-GCCcore-12.3.0-Java-17

ref_genome="../reference_genome/CreinhardtiiCC_4532_707_v6.0.fa"
INT=$(awk "NR==${SLURM_ARRAY_TASK_ID}" ../reference_genome/intervals.txt | cut -f1)

# Joint genotyping of all samples
gatk --java-options "-Xms35G -Xmx35G -XX:ParallelGCThreads=2" GenotypeGVCFs \
    -R $ref_genome \
    -V gendb://DBImport/$INT \
    -L $INT \
    --tmp-dir /mnt/gs21/scratch/izquier7 \
    -O population/${INT}_population.vcf.gz

scontrol show job $SLURM_JOB_ID > GenomicsDBImport_job_info.txt 