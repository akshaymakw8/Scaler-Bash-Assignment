#!/bin/bash

# Check if directory path is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

directory="$1"

# Check if the directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist."
    exit 1
fi

# Traverse the specified directory recursively, identify file types based on extensions, count and list the number of files for each file type
file_types=$(find "$directory" -type f | grep -E -o '\.[a-zA-Z0-9]+$' | sort | uniq -c | awk '{print $2,$1}')

# Output the sorted list of file types along with their counts
echo "File Type Count"
echo "$file_types"
