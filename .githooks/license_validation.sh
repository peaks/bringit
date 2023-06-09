#!/bin/bash

###
# Copyright (c) 2020 Peaks
#
# This file is part of GitGud
#
# GitGud is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# GitGud is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GitGud.  If not, see <http://www.gnu.org/licenses/>.
###

### Bash script for validating GPL3 license in header of files with specified extensions

echo -e "\e[1;34m############## License GPL3 validation ###############\e[0m"

source ./.githooks/utils.sh

# Directory containing the files (passed as parameter)
repo_directory="$1"

# List of file extensions to check (passed as parameter)
extensions=("${@:2}")

# Check if directory is provided as parameter
[ -z "$repo_directory" ] && { echo -e "\e[1;31m$error_suffix Please specify the directory containing the files to analyze.\e[0m"; exit 1; }

# Check if directory exists
[ ! -d "$repo_directory" ] && { echo -e "\e[1;31m$error_suffix The directory $repo_directory does not exist.\e[0m"; exit 1; }

# Check if extensions are provided as parameter
[ ${#extensions[@]} -eq 0 ] && { echo -e "\e[1;31m$error_suffix Please specify at least one file extension to analyze.\e[0m"; exit 1; }

# Check if extensions passed as parameter start with a dot
for ext in "${extensions[@]}"; do
    [[ "$ext" == .* ]] || { echo -e "\e[1;31m$error_suffix Extensions must start with a dot: $ext\e[0m"; exit 1; }
done

# Check if license template already exists
file_exists "$file_path_template_license"

# Execute the cleaned_flattened_extracted_comment_block function and store the output in the header_licence_gpl3 variable
header_licence_gpl3=$(cleaned_flattened_extracted_comment_block "$file_path_template_license")
if [ "$debug" = true ]; then
    echo -e "\e[1;32mDEBUG: Here is the header_licence extracted from the file $file_path_template_license:\e[0m"
    echo -e "$header_licence_gpl3 \n"
fi

# List of files without the GPL3 license
files_without_license_gpl3=()

# Analyze all files from a directory and its subdirectories
while IFS= read -r -d '' file; do
    # Check specified extensions
    for ext in "${extensions[@]}"; do
        if [[ $file == *"$ext" ]]; then
            file_contents=$(cleaned_flattened_extracted_comment_block "$file")
            if [ "$debug" = true ]; then
                write_in_green "DEBUG: Here is the first extracted comment block from the file: $file"
                echo -e "$file_contents \n"
            fi
            if ! grep -q "$header_licence_gpl3" <<< "$file_contents"; then
                files_without_license_gpl3+=("$file")
            fi
        fi
    done
done < <(find "$repo_directory" -type f -print0)


# Check if the list of files without GPL3 license is not empty
if [ ${#files_without_license_gpl3[@]} -gt 0 ]; then
    write_in_red "$error_suffix The following files do not contain the GPL3 license in the header:"
    printf "%s\n" "${files_without_license_gpl3[@]}"
    write_in_red "$error_suffix Please add the GPL3 license header."
    write_in_red "$error_suffix Script that check and add license gpl3 available here:"
    echo -e "==========> ~/.githooks/apply_license_gpl3.sh <==========\n"
    exit 1  # Raise an error
else
    write_in_green "All analyzed files already have the header from $file_path_template_license"
fi

echo "############## License GPL3 validation: end ###############"
