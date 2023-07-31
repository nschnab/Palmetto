#!/bin/bash

source var.txt

# Directory path where the FastQ files are located
inputDir="$path1"

# Output directory path to store the converted FastA files
outputDir="$path2"

# Load the module
module add fastx_toolkit

# Iterate over each FastQ file in the input directory
for file in "$inputDir"/*.fastq; do
    # Extract the file name without the extension
    filename=$(basename "$file" .fastq)
    
    # Construct the output file path for the converted FastA file
    outputFile="$outputDir/$filename.fasta"
    
    # Use fastx_toolkit's fastq_to_fasta command to convert the FastQ file to FastA
    fastq_to_fasta -r -i "$file" -o "$outputFile"
    
    echo "Converted $file to $outputFile"
done