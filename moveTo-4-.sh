#!/bin/bash
source var.txt

TO_KRAKEN2="$path2"
TO_SPAdes="$path3"
OUTPUT_DIR="$path4"

# Move files matching '*.fasta' to the output directory
find "$TO_KRAKEN2" -name '*.fasta' -type f -exec mv {} "$OUTPUT_DIR" \;

# Move files matching '*.report' to the output directory
find "$TO_SPAdes" -name '*.report' -type f -exec mv {} "$OUTPUT_DIR" \;

# move files with '.fa' to the output folder
find "$TO_SPAdes" -name '*.fa' -type f -exec mv {} "$OUTPUT_DIR" \;

echo "Files moved to: $OUTPUT_DIR"