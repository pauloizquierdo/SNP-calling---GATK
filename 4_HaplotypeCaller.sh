#!/bin/bash --login
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --array=2-24
#SBATCH --mem=30GB
#SBATCH --job-name=haplotypercaller
#SBATCH --time=03:30:00
#SBATCH --output=slurm_haplo_%A_%a.out
#SBATCH --error=slurm_haplo_%A_%a.err


cd /mnt/scratch/izquier7/DNA_seq_Chlamydomonas/SNP_calling_pipeline

module purge
module load GATK/4.5.0.0-GCCcore-12.3.0-Java-17

# Set directories 
ref_genome="../reference_genome/CreinhardtiiCC_4532_707_v6.0.fa"
mark_dir="mapping"
tmp_dir="/mnt/gs21/scratch/izquier7"
output_dir="genotyping"
mkdir -p "$output_dir"

# Get sample name and type from samples.txt file
sample_name=$(awk "NR==${SLURM_ARRAY_TASK_ID}" samples.txt | cut -d " " -f1)

# Call SNPs and indels 
gatk --java-options "-Xmx20g -XX:ParallelGCThreads=2" HaplotypeCaller \
    -R $ref_genome \
    -I $mark_dir/${sample_name}_sorted_dedup.bam  \
    -O $output_dir/${sample_name}_sorted_dedup.vcf.gz \
    -ERC GVCF \
    --tmp-dir $tmp_dir \
    --sample-ploidy 1

scontrol show job $SLURM_JOB_ID > ${sample_name}_job_info_genotyping.txt