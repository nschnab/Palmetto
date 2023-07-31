#!/bin/bash

source var.txt
# Set the path to the executable
EXECUTABLE_PATH="$shTestPath/zipMerge/zipMerge"

# Prompt the user for input
read -p "Do you want to run the zip? (y/n): " choice

# Check the user's input
if [ "$choice" == "y" ]; then
    # Check if the executable file exists
    if [ -x "$EXECUTABLE_PATH" ]; then
        # Run the executable
        "$EXECUTABLE_PATH"
    else
        echo "Executable file not found or is not executable: $EXECUTABLE_PATH"
    fi
else
    echo "Execution skipped."
fi

# Call the other script
echo "Starting fastqToFasta"
$shTestPath/fastqToFasta.sh &
wait
echo "Subscript Complete"
echo "Starting kraken2"
$shTestPath/kraken2.sh &
wait
echo "Subscript Complete"
echo "Starting SPAdes"
$shTestPath/SPAdes.sh &
wait
echo "Subscript Complete"
echo "Moving Files"
$shTestPath/moveTo-4-.sh &
wait
echo "Subscript Complete"
echo "All subscripts have concluded"