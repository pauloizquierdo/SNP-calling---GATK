#!/bin/bash --login
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --array=7-8
#SBATCH --job-name=mapping
#SBATCH --time=03:30:00
#SBATCH --output=slurm_bwa_%A_%a.out
#SBATCH --error=slurm_bwa_%A_%a.err


cd /mnt/scratch/izquier7/DNA_seq_Chlamydomonas/SNP_calling_pipeline

module purge
module load BWA/0.7.17-20220923-GCCcore-12.3.0
module load SAMtools/1.18-GCC-12.3.0

# Set directories
input_dir="quality_control"
ref_genome="../reference_genome/CreinhardtiiCC_4532_707_v6.0.fa.gz"
output_dir="mapping"
mkdir -p "$output_dir"

# Extract the sample name for the current array job
sample_name=$(awk "NR==${SLURM_ARRAY_TASK_ID}" samples.txt | cut -d " " -f1)

# Map and sort reads to the reference genome
bwa mem -t 32 -M \
    -R "@RG\tID:${sample_name}\tSM:${sample_name}\tLB:${sample_name}\tPL:ILLUMINA" \
    $ref_genome \
    $input_dir/${sample_name}_R1_filtered.fastq.gz $input_dir/${sample_name}_R2_filtered.fastq.gz \
| samtools sort -@ 12 -o $output_dir/${sample_name}_sorted.bam -

# Index the sorted BAM file
samtools index -@ 12 $output_dir/${sample_name}_sorted.bam

scontrol show job $SLURM_JOB_ID > $output_dir/${sample_name}_job_info_bwa_align_${SLURM_ARRAY_TASK_ID}.txt