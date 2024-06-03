#!/bin/bash

# Check if a log file path is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

logfile="$1"

# Check if the log file exists and is readable
if [ ! -f "$logfile" ] || [ ! -r "$logfile" ]; then
    echo "Error: Log file '$logfile' does not exist or is not readable."
    exit 1
fi

# Total Requests Count
total_requests=$(wc -l < "$logfile")

# Percentage of Successful Requests
successful_requests=$(awk '$9 >= 200 && $9 < 300 {print}' "$logfile" | wc -l)
percentage_success=$(awk "BEGIN {printf \"%.2f\", ($successful_requests/$total_requests) * 100}")

# Most Active User
most_active_user=$(awk '{print $1}' "$logfile" | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')

# Output
echo "Total Requests Count: $total_requests"
echo "Percentage of Successful Requests: $percentage_success%"
echo "Most Active User: $most_active_user"
