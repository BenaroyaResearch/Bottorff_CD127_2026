#!/bin/bash

# Directory containing the .bam files
bam_dir="/mnt/bioinformatics/workspace/tbottorff/P576-1/raw_data/combined_bams/"

# Output directory
output_dir="./saved_data/"

# Array of min_coverage values
min_coverage_values=(20)

# Array of p-value thresholds
p_value_thresholds=(0.05)

# Array of min-var-freq values, ~0.5/num_samples
min_var_freq_values=(0.004)

# Reference genome file
reference_genome="/mnt/bioinformatics/pipeline/annotation/GRCh38/Homo_sapiens.GRCh38.dna.primary_assembly.fa"

# Iterate through all .bam files in the directory
for bam_file in "$bam_dir"/merged_mt*.bam; do
    # Extract base name of BAM file
    bam_base=$(basename "$bam_file" .bam)

    # Iterate over parameter combinations
    for min_coverage in "${min_coverage_values[@]}"; do
        for p_value in "${p_value_thresholds[@]}"; do
            for min_var_freq in "${min_var_freq_values[@]}"; do
                # Replace period with underscore in p_value and min_var_freq for the output file name
                p_value_str=$(echo "$p_value" | sed 's/\./_/g')
                min_var_freq_str=$(echo "$min_var_freq" | sed 's/\./_/g')

                # Create output file name with parameter suffixes
                output_file="${output_dir}/${bam_base}_coverage${min_coverage}_pvalue${p_value_str}_minvarfreq${min_var_freq_str}.txt"
                
                # Create pileup file and pipe to variant calling with the current parameters
                samtools mpileup -f "$reference_genome" "$bam_file" | java -jar VarScan.v2.3.9.jar pileup2snp --min-coverage "$min_coverage" --min-var-freq "$min_var_freq" --p-value "$p_value" > "$output_file"
            done
        done
    done
done
