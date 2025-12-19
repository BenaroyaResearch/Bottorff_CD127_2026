#!/bin/bash

# Directory containing the BAM files
bam_dir="/mnt/bioinformatics/pipeline/Illumina/240327_VH00126_344_AACHGGFHV/Project_P576-1Processed_bri_240401/merged_alignments"

# Iterate through each BAM file in the directory
for bam_file in "$bam_dir"/merged*.bam; do
    # Extract the base name of the file (without extension)
    base_name=$(basename "$bam_file" .bam)
    # Call macs2 to generate peaks for the BAM file and specify the output name
    macs2 callpeak -t "$bam_file" -g hs -f BAMPE -n "${base_name#merged_}_peaks"
done

mv *.narrowPeak *.xls *.bed /mnt/bioinformatics/pipeline/Illumina/240327_VH00126_344_AACHGGFHV/Project_P576-1Processed_bri_240401/merged_peaks 
