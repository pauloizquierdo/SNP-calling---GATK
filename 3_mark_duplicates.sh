#!/bin/bash --login
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --array=7-8
#SBATCH --mem=30GB
#SBATCH --job-name=markduplictes
#SBATCH --time=03:30:00
#SBATCH --output=slurm_markdu_%A_%a.out
#SBATCH --error=slurm_markdu_%A_%a.err


cd /mnt/scratch/izquier7/DNA_seq_Chlamydomonas/SNP_calling_pipeline

module purge
module load picard/2.25.1-Java-11
module load SAMtools/1.18-GCC-12.3.0


# Set directories
input_output_dir="mapping"
TMP_DIR="/mnt/gs21/scratch/izquier7"

# Extract the sample name for the current array job
sample_name=$(awk "NR==${SLURM_ARRAY_TASK_ID}" samples.txt | cut -d " " -f1)

# Identify duplicate reads in BAM  files
java -Xms20G -Xmx20G -jar $EBROOTPICARD/picard.jar MarkDuplicates \
    I=$input_output_dir/${sample_name}_sorted.bam \
    O=$input_output_dir/${sample_name}_sorted_dedup.bam \
    M=$input_output_dir/${sample_name}_sorted_dedup_metrics.txt \
    TMP_DIR=$TMP_DIR \

# Index the sorted BAM file
samtools index -@ 4 $input_output_dir/${sample_name}_sorted_dedup.bam

scontrol show job $SLURM_JOB_ID > $output_dir/${sample_name}_job_info_dedup_align_${SLURM_ARRAY_TASK_ID}.txt