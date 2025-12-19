#!/bin/bash

# Define the base directory
base_dir="/nfs/bioinformatics/pipeline/Illumina/MultiFlowcellProjects/Project_P348-4Processed_CellRangerV611_220613/"

# List of patient IDs and corresponding folder names (including the additional patients)
patients=("1_pb10917330" "2_pb402322171" "3_pb331023716" "4_pb28361184" "5_pb1052706431" "6_pb50492692" "7_pb342784489" "8_pb1060485913")

# Loop over each patient
for patient in "${patients[@]}"; do
  # Construct the file path to the .bam file for each patient
  bam_file="${base_dir}multi/${patient}/outs/per_sample_outs/${patient}/count/sample_alignments.bam"
  
  # Check if the BAM file exists
  if [ ! -f "$bam_file" ]; then
    echo "BAM file for $patient not found: $bam_file"
    continue
  fi

  # Define the output BAM file path
  output_bam="${bam_file%.bam}_filtered_dedup.bam"
  
  # Step 1: Filter for mitochondrial reads (assuming mitochondria are mapped to chrM or MT)
  # Filter reads mapped to mitochondria and save to temp BAM file
  temp_bam="${bam_file%.bam}_mt_filtered.bam"
  samtools view -h "$bam_file" | grep -E '\tMT\t' | samtools view -Sb - > "$temp_bam"
  
  # Step 2: Deduplicate reads using UMIs
  # The UMI tag is assumed to be `UB:Z:<UMI_sequence>`
  umi_tools dedup -I "$temp_bam" --output-bam "$output_bam" --umi-tag UB --cell-tag CB
  
  # Clean up the temp BAM file
  rm "$temp_bam"
  
  echo "Processed BAM for $patient: $output_bam"
done

