#!/bin/bash
# based off of http://homer.ucsd.edu/homer/ngs/peakMotifs.html

# load hg38 beforehand
# ~/homer/bin/loadGenome.pl -name hg38 -org null -fasta ~/homer/data/genomes/hg38/hg38.fa -gtf ~/homer/data/genomes/hg38/hg38.ensGene.gtf

# Set paths
DIR=./saved_data
TF=~/homer/bin

# arameters
# -size is mandatory and 200 is the default window
# -mask allows use of the masked genome
# -bg provides specific background (default is whole genome), using all peaks (OCRs) here as background

# run Find motifs on peaks separated out into the contrasts of interest

# CD127+ Tex. vs. PD-1+ Tex
$TF/findMotifsGenome.pl $DIR/TIGIT_pos_KLRG1_pos_CD57_neg_CD127_neg_PD1_pos_vs_TIGIT_pos_KLRG1_pos_CD57_neg_CD127_pos_differential_peaks_up_in_DP_CD127_pos.txt hg38 $DIR/DP_CD127_pos_vs_DP_PD1_pos_background_all_peaks_homer -size 200 -mask -bg $DIR/TIGIT_pos_KLRG1_pos_CD57_neg_CD127_neg_PD1_pos_vs_TIGIT_pos_KLRG1_pos_CD57_neg_CD127_pos_all_peaks.txt
# PD-1+ Tex vs. CD127+ Tex
$TF/findMotifsGenome.pl $DIR/TIGIT_pos_KLRG1_pos_CD57_neg_CD127_neg_PD1_pos_vs_TIGIT_pos_KLRG1_pos_CD57_neg_CD127_pos_differential_peaks_up_in_DP_PD1_pos.txt hg38 $DIR/DP_PD1_pos_vs_DP_CD127_pos_background_all_peaks_homer -size 200 -mask -bg $DIR/TIGIT_pos_KLRG1_pos_CD57_neg_CD127_neg_PD1_pos_vs_TIGIT_pos_KLRG1_pos_CD57_neg_CD127_pos_all_peaks.txt

# CD57+ Tex vs. PD-1+ Tex
$TF/findMotifsGenome.pl $DIR/TIGIT_pos_KLRG1_pos_CD57_neg_CD127_neg_PD1_pos_vs_TIGIT_pos_KLRG1_pos_CD57_pos_CD127_neg_differential_peaks_up_in_DP_CD57_pos.txt hg38 $DIR/DP_CD57_pos_vs_DP_PD1_pos_background_all_peaks_homer -size 200 -mask -bg $DIR/TIGIT_pos_KLRG1_pos_CD57_neg_CD127_neg_PD1_pos_vs_TIGIT_pos_KLRG1_pos_CD57_pos_CD127_neg_all_peaks.txt
# PD-1+ Tex vs. CD57+ Tex
$TF/findMotifsGenome.pl $DIR/TIGIT_pos_KLRG1_pos_CD57_neg_CD127_neg_PD1_pos_vs_TIGIT_pos_KLRG1_pos_CD57_pos_CD127_neg_differential_peaks_up_in_DP_PD1_pos.txt hg38 $DIR/DP_PD1_pos_vs_DP_CD57_pos_background_all_peaks_homer -size 200 -mask -bg $DIR/TIGIT_pos_KLRG1_pos_CD57_neg_CD127_neg_PD1_pos_vs_TIGIT_pos_KLRG1_pos_CD57_pos_CD127_neg_all_peaks.txt

# CD127+ Tex vs. CD57+ Tex
$TF/findMotifsGenome.pl $DIR/TIGIT_pos_KLRG1_pos_CD57_neg_CD127_pos_vs_TIGIT_pos_KLRG1_pos_CD57_pos_CD127_neg_differential_peaks_up_in_DP_CD127_pos.txt hg38 $DIR/DP_CD127_pos_vs_DP_CD57_pos_background_all_peaks_homer -size 200 -mask -bg $DIR/TIGIT_pos_KLRG1_pos_CD57_neg_CD127_pos_vs_TIGIT_pos_KLRG1_pos_CD57_pos_CD127_neg_all_peaks.txt
# CD57+ Tex vs. CD127+ Tex
$TF/findMotifsGenome.pl $DIR/TIGIT_pos_KLRG1_pos_CD57_neg_CD127_pos_vs_TIGIT_pos_KLRG1_pos_CD57_pos_CD127_neg_differential_peaks_up_in_DP_CD57_pos.txt hg38 $DIR/DP_CD57_pos_vs_DP_CD127_pos_background_all_peaks_homer -size 200 -mask -bg $DIR/TIGIT_pos_KLRG1_pos_CD57_neg_CD127_pos_vs_TIGIT_pos_KLRG1_pos_CD57_pos_CD127_neg_all_peaks.txt