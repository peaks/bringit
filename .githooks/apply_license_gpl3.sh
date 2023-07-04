#!/bin/bash

###
# Copyright (c) 2020 Peaks
#
# This file is part of Brin'Git
#
# Brin'Git is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Brin'Git is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Brin'Git.  If not, see <http://www.gnu.org/licenses/>.
###

### Bash script to check if files with specific extensions have the GPL3 license header. If not, it adds it to the beginning.
# $1:       the directory to analyze. The script will analyze all files in this directory and its subdirectories.
# &{@:2}:   list of extensions in the format: .ext (e.g., .java, etc.). The script will only analyze and potentially modify files with these extensions.

# Please take the time to check and specify the variables present in utils.sh

echo -e "\e[1;35m############## License GPL3 Modification: begin ###############\e[0m"
source .githooks/utils.sh
[ "$debug" = true ] && write_in_green "DEBUG: DEBUG variable: $debug"
[ "$debug" = true ] && write_in_green "DEBUG: DEBUG variable: $workdir"
[ "$debug" = true ] && write_in_green "DEBUG: DEBUG variable: $file_path_template_license"

# Directory containing the files (passed as parameter)
repo_directory="$1"

# List of file extensions to check (passed as parameter)
extensions=("${@:2}")

# Check if the directory is provided as a parameter
[ -z "$repo_directory" ] && { write_in_red "Please specify the directory containing the files to analyze."; exit 1; }

# Check if the directory exists
[ ! -d "$repo_directory" ] && { write_in_red "The directory $repo_directory does not exist."; exit 1; }

# Check if the extensions are provided as parameters
[ ${#extensions[@]} -eq 0 ] && { write_in_red "Please specify at least one file extension to analyze."; exit 1; }

# Check if the extensions passed as parameters start with a dot
for ext in "${extensions[@]}"; do
    [[ "$ext" == .* ]] || { write_in_red "Extensions must start with a dot: $ext"; exit 1; }
done

# Absolute path of the gpl3 license template file
file_exists "$file_path_template_license"

# Execute the cleaned_flattened_extracted_comment_block function and store the output in the header_licence_gpl3 variable
header_licence_gpl3=$(cleaned_flattened_extracted_comment_block "$file_path_template_license")
if [ "$debug" = true ]; then
    write_in_green "DEBUG: Here is the header_licence extracted from the file $file_path_template_license:"
    echo -e "$header_licence_gpl3"
fi

# List of files without the GPL3 license
files_without_license_gpl3=()

# Traverse all files in the directory and its subdirectories
while IFS= read -r -d '' file; do
    # Check the specified extensions
    for ext in "${extensions[@]}"; do
        if [[ $file == *"$ext" && $file != *"generated_"* ]]; then
            first_line=$(extract_first_non_empty_line "$file")
            [ "$debug" = true ] && write_in_green "DEBUG: $file: Here is the first non-empty line of the file: $first_line"
            if [[ $first_line != "/*" && $first_line != "/**" ]]; then # The first line of the analyzed file is not a comment block
                [ "$debug" = true ] && write_in_green "DEBUG: $file: The first non-empty line does not have /* or /**"
                files_without_license_gpl3+=("$file")
                insert_file_content "$file_path_template_license" "$file"
            else # The first line of the analyzed file is a comment block
                [ "$debug" = true ] && write_in_green "DEBUG: $file: The first non-empty line has /* or /**"
                file_contents=$(cleaned_flattened_extracted_comment_block "$file")
                # [ "$debug" = true ] && write_in_green "DEBUG: $file: Here is the content of the first extracted comment block:"
                # [ "$debug" = true ] && echo -e "$file_contents"
                # Check if the content of the first comment block matches the content of the gpl3 license template
                if ! grep -q "$header_licence_gpl3" <<< "$file_contents"; then
                    [ "$debug" = true ] && write_in_green "DEBUG: $file: The block does not match the content of $file_path_template_license"
                    files_without_license_gpl3+=("$file")
                    insert_file_content "$file_path_template_license" "$file"
                else
                    [ "$debug" = true ] && write_in_green "DEBUG: $file: The block matchs the content of $file_path_template_license"
                fi
            fi
        fi
    done
done < <(find "$repo_directory" -type f -print0)

# Check if the list of files without GPL3 license is not empty
if [ ${#files_without_license_gpl3[@]} -gt 0 ]; then
    write_in_red "The following files do not have the content of $file_path_template_license in their header:"
    printf "%s\n" "${files_without_license_gpl3[@]}"
    write_in_red "The above files have been modified."
    exit 1  # Raise an error
else
    echo -e "\e[5;1;34m\u25A0\u25A0\u25A0    All analysed files already have a valid license gpl3   \u25A0\u25A0\u25A0\e[0m"
fi

echo -e "\e[1;35m############## License GPL3 Modification: end ###############\e[0m"
