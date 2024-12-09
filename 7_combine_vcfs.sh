module purge
module load GATK/4.5.0.0-GCCcore-12.3.0-Java-17

# Combine all the VCF files into a single VCF file
gatk GatherVcfs \
    -I chromosome_01_population.vcf.gz \
    -I chromosome_02_population.vcf.gz \
    -I chromosome_03_population.vcf.gz \
    -I chromosome_04_population.vcf.gz \
    -I chromosome_05_population.vcf.gz \
    -I chromosome_06_population.vcf.gz \
    -I chromosome_07_population.vcf.gz \
    -I chromosome_08_population.vcf.gz \
    -I chromosome_09_population.vcf.gz \
    -I chromosome_10_population.vcf.gz \
    -I chromosome_11_population.vcf.gz \
    -I chromosome_12_population.vcf.gz \
    -I chromosome_13_population.vcf.gz \
    -I chromosome_14_population.vcf.gz \
    -I chromosome_15_population.vcf.gz \
    -I chromosome_16_population.vcf.gz \
    -I chromosome_17_population.vcf.gz \
    -I contig_18_population.vcf.gz \
    -I contig_19_population.vcf.gz \
    -I contig_20_population.vcf.gz \
    -I contig_21_population.vcf.gz \
    -I contig_22_population.vcf.gz \
    -I contig_23_population.vcf.gz \
    -I contig_24_population.vcf.gz \
    -I contig_25_population.vcf.gz \
    -I contig_26_population.vcf.gz \
    -I contig_27_population.vcf.gz \
    -I contig_28_population.vcf.gz \
    -I contig_29_population.vcf.gz \
    -I contig_30_population.vcf.gz \
    -I contig_31_population.vcf.gz \
    -I contig_32_population.vcf.gz \
    -I contig_33_population.vcf.gz \
    -I contig_34_population.vcf.gz \
    -I contig_35_population.vcf.gz \
    -I contig_36_population.vcf.gz \
    -I contig_37_population.vcf.gz \
    -I contig_38_population.vcf.gz \
    -I contig_39_population.vcf.gz \
    -I contig_40_population.vcf.gz \
    -I contig_41_population.vcf.gz \
    -I contig_42_population.vcf.gz \
    -I contig_43_population.vcf.gz \
    -I contig_44_population.vcf.gz \
    -I contig_45_population.vcf.gz \
    -I contig_46_population.vcf.gz \
    -I contig_47_population.vcf.gz \
    -I contig_48_population.vcf.gz \
    -I contig_49_population.vcf.gz \
    -I contig_50_population.vcf.gz \
    -I contig_51_population.vcf.gz \
    -I contig_52_population.vcf.gz \
    -I contig_53_population.vcf.gz \
    -I contig_54_population.vcf.gz \
    -I contig_55_population.vcf.gz \
    -I contig_56_population.vcf.gz \
    -I contig_57_population.vcf.gz \
    -I plastome_population.vcf.gz \
    -I mitogenome_population.vcf.gz \
    -I mating_type_plus_population.vcf.gz \
    -O population.vcf

pwd

java -Xmx6g -jar /mnt/home/izquier7/Documents/software/NGSToolsApp_2.1.5.jar Annotate  population.vcf ../../reference_genome/CreinhardtiiCC_4532_707_v6.1.gene.gff3 ../../reference_genome/CreinhardtiiCC_4532_707_v6.0.fa > population_annotated.vcf &
