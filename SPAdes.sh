#!/bin/bash
source var.txt

# Set the input and output directories
INPUT_DIR="$path3"
OUTPUT_DIR="$path4"

# load the module
module add spades

# Iterate over the filtered input files in the directory
for input_file in "$INPUT_DIR"/*.fa; do
    # Extract the base name of the input file without extension
    base_name=$(basename "$input_file" .fa)
    
    # Create the output directory for SPAdes
    spades_output_dir="$OUTPUT_DIR/${base_name}_spades"
    mkdir -p "$spades_output_dir"
    
    # Run SPAdes
    spades.py --rnaviral -s "$input_file" -o "$spades_output_dir"
done

# Print a message indicating the completion of the SPAdes run
echo "SPAdes analysis completed. Results saved to: $OUTPUT_DIR"