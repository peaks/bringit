#!/bin/bash
# Context variables
debug=false  # true or false
file_path_template_license="./.githooks/license_gpl3.txt"

# Function to write in red
write_in_red() {
    local message="$1"
    echo -e "\e[31m${message}\e[0m"
}

# Function to write in green
write_in_green() {
    local message="$1"
    echo -e "\e[32m${message}\e[0m"
}

# Function to check if a file exists
file_exists() {
    local file_path="$1"

    if [ -f "$file_path" ]; then
        return 0
    else
        write_in_red "Error: File $file_path does not exist"
        exit 1
    fi
}

# Function to extract the first comment block
extract_first_comment_block() {
    local file_path="$1"
    local comment_block=""
    local comment_started=false

    while IFS= read -r line; do
        if [[ $line =~ ^[[:space:]]*\/\* ]]; then
            comment_started=true
            comment_block+="${line#*[[:space:]]*\/\*}"$'\n'
        elif [[ $line =~ \*\/[[:space:]]*$ ]]; then
            comment_started=false
            comment_block+="${line%%\*\/[[:space:]]*}"$'\n'
            break
        elif [[ $comment_started == true ]]; then
            comment_block+="$line"$'\n'
        fi
    done < "$file_path"

    echo -n "$comment_block"
}

# Function to remove special characters and unnecessary spaces at the beginning and end of a string
remove_comments_chars() {
    local text="$1"
    # Remove special characters
    text="${text//\*}"
    text="${text//\/}"
    # Remove unnecessary spaces at the beginning and end of the string
    text="${text#"${text%%[![:space:]]*}"}"
    text="${text%"${text##*[![:space:]]}"}"
    echo -n "$text"
}

# Function to flatten the comment block into a single line
flatten_comment_block() {
    local comment_block="$1"
    # Remove unnecessary spaces
    comment_block=$(echo "$comment_block" | tr -d '[:space:]')
    echo -n "$comment_block"
}

cleaned_flattened_extracted_comment_block() {
    # Input variable
    local file_path=$1
    # Extract the first comment block
    comment_block=$(extract_first_comment_block "$file_path")
    # Remove special characters and unnecessary spaces
    cleaned_block=$(remove_comments_chars "$comment_block")
    # Flatten the comment block into a single line
    flattened_block=$(flatten_comment_block "$cleaned_block")
    echo -n "$flattened_block"
}

extract_first_non_empty_line() {
  file=$1

  while IFS= read -r line_content; do
    if [[ -n "$line_content" ]]; then
      echo "$line_content"
      return
    fi
  done < "$file"
}

# Define the function to insert the content of a file at the beginning of the specified file
insert_file_content() {
    local file_to_insert="$1"
    local file_target="$2"
    # Create a temporary file
    local temp_file=$(mktemp)
    # Insert the content of the file to insert at the beginning of the file (the second echo is to add a new line)
    { cat "$file_to_insert"; echo; cat "$file_target"; } > "$temp_file"
    # Copy the content of the temporary file to the original file
    cat "$temp_file" > "$file_target"
    # Remove the temporary file
    rm "$temp_file"
}
