#!/bin/bash

# The path to transform, passed as the first argument to the script
path="$1"

# Count the number of slashes in the path to determine its depth
depth=$(echo "$path" | awk -F"/" '{print NF-1}')

# If the path depth is greater than 3 (accounting for leading slash in absolute paths)
if [ "$depth" -gt 3 ]; then
    # Extract the last two segments of the path and prefix with "/.../" or "~/.../" as appropriate
    if [[ "$path" == "$HOME"* ]]; then
        # Path starts with the user's home directory, replace it with "~"
        formatted_path="~/.../"$(echo "$path" | awk -F"/" '{print $(NF-1)"/"$NF}')
    else
        # Path does not start with the user's home directory
        formatted_path="/.../"$(echo "$path" | awk -F"/" '{print $(NF-1)"/"$NF}')
    fi
else
    # If the path depth is 3 or less, use it as is, but replace the home directory with "~"
    formatted_path=$(echo "$path" | sed "s|$HOME|~|")
fi

echo "$formatted_path"

