#!/bin/bash --login
#SBATCH --ntasks=1 
#SBATCH --cpus-per-task=6
#SBATCH --job-name=fastp_processing
#SBATCH --time=03:30:00
#SBATCH --output=fastp_processing_%j.out
#SBATCH --error=fastp_processing_%j.err

cd /mnt/scratch/izquier7/DNA_seq_Chlamydomonas/SNP_calling_pipeline

# Activate Conda environment
conda activate snp_calling

# Define the input and output directories
input_dir="../raw_data/2023_DNAseq_crispr/"
output_dir="quality_control"
mkdir -p "$output_dir"

# Loop through all R1 FASTQ files in the input directory
for r1 in ${input_dir}/*_R1_*.fastq.gz; do
    r2="${r1/_R1/_R2}"  # Identify the corresponding R2 file by replacing "_R1_" with "_R2_"
    sample_name=$(basename "$r1" | sed 's/_R1_.*//')  # Extract sample name

    echo "Processing sample: $sample_name"

    # Run fastp to filter and trim reads
    fastp -i "$r1" \
          -I "$r2" \
          -o "${output_dir}/${sample_name}_R1_filtered.fastq.gz" \
          -O "${output_dir}/${sample_name}_R2_filtered.fastq.gz" \
          --thread 6 \
          -j "${output_dir}/${sample_name}_fastp.json" \
          -h "${output_dir}/${sample_name}_fastp.html" \
          > "${output_dir}/${sample_name}_fastp.log" 2>&1
done

# Print completion messages
echo "Processing sample: $sample_name"
echo "All samples processed. Filtered files and reports are in $output_dir."
