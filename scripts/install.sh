#!/bin/bash
set -e

echo "Install script, curr dir : $PWD"
BAYA_DIR="baya_releases"
EXTRACTED_DIR="."
EXAMPLES_DIR="examples"

# Find the first archive in baya_releases
BAYA_ARCHIVE=$(find "$BAYA_DIR" -type f \( -name "*.tar.gz" -o -name "*.zip" \) | head -n 1)
if [ -z "$BAYA_ARCHIVE" ]; then
    echo "Baya release not found in $BAYA_DIR."
    echo "Please upload the Baya tool release (.zip/.tar.gz) into $BAYA_DIR and re-run this script."
    exit 1
fi

echo "Found Baya tool: $BAYA_ARCHIVE"
mkdir -p "$EXTRACTED_DIR"

# Extract archive
if [[ "$BAYA_ARCHIVE" == *.tar.gz ]]; then
    echo "Installing - it will take couple of minutes, please wait ..."
    tar -xzf "$BAYA_ARCHIVE" -C "$EXTRACTED_DIR"
elif [[ "$BAYA_ARCHIVE" == *.zip ]]; then
    unzip -q "$BAYA_ARCHIVE" -d "$EXTRACTED_DIR"
else
    echo "Unsupported archive format. Please use .zip or .tar.gz."
    exit 2
fi

# Find the most recent directory inside baya_tool/baya-shell
BAYA_SHELL_DIR=$(find "$EXTRACTED_DIR/baya-shell" -mindepth 1 -maxdepth 1 -type d | sort | tail -n 1)
if [ -z "$BAYA_SHELL_DIR" ]; then
    echo "Could not find extracted Baya shell directory."
    exit 3
fi

echo "Baya tool extracted to $BAYA_SHELL_DIR"

cd "$BAYA_SHELL_DIR"

# Source setup_env.sh if exists
if [ -f setup_env.sh ]; then
    source setup_env.sh
else
    echo "Warning: setup_env.sh not found in $BAYA_SHELL_DIR."
fi

# Now in the $BAYA_SHELL_DIR"
# Try running examples 
if [ -d "./$EXAMPLES_DIR" ]; then
    found_example=""
    for ex in ./$EXAMPLES_DIR/*; do
        if [ -d "$ex" ]; then
            if [ -f "$ex/runme.csh" ]; then
                echo "Running Example: $ex"
                pushd "$ex"
                csh "runme.csh"
                popd
                found_example=1
            fi
        fi
    done
    if [ -z "$found_example" ]; then
        echo "No runnable examples found in $EXAMPLES_DIR. Add some example projects with runme.csh!"
    fi
else
    echo "No examples found in $EXAMPLES_DIR. Add some example projects!"
fi

cd -

echo "Setup complete."
exit 0
