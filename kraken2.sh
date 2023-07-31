#!/bin/bash

# Load the Kraken 2 module
module load kraken2
source var.txt

# Set the input and output file paths
INPUT_DIR="$path2"
OUTPUT_DIR="$path3"
KRAKEN_DATABASE="/zfs/virologylab/kraken_databases/k2plant"
FINAL_PATH="$path4"

# Iterate over the input files in the directory
for input_file in "$INPUT_DIR"/*.fasta; do
    # Extract the base name of the input file without extension
    base_name=$(basename "$input_file" .fasta)
    
    # Set the output file paths
    output_unclassified="$OUTPUT_DIR/${base_name}_k2plant_notplant.fa"
    output_report="$FINAL_PATH/${base_name}_k2plant.report"
    output_classified="$OUTPUT_DIR/${base_name}.output"
    
    # Run Kraken 2 to filter the data
    kraken2 --threads 16 --db "$KRAKEN_DATABASE" --unclassified-out "$output_unclassified" --confidence 0.5 --output "$output_classified" --report "$output_report" --memory-mapping "$input_file"
    
    # Move the output files to the output directory
    mv "$output_unclassified" "$OUTPUT_DIR"
    rm "$output_classified"
done

# Print a message indicating the completion of the filtering process
echo "Data filtering completed. Filtered data saved to: $OUTPUT_DIR"
