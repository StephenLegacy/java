#!/bin/bash

# Enhanced script to backdate Git commits with better error handling and flexibility

# Set the backdate timestamp (default: 2025-04-30 11:32:00)
BACKDATE="${1:-"2025-05-07T11:32:00"}"

# Validate the date format
if ! date -d "$BACKDATE" >/dev/null 2>&1; then
    echo "Error: Invalid date format. Please use ISO 8601 format (e.g., YYYY-MM-DDThh:mm:ss)"
    exit 1
fi

# Check if we're in a Git repository
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: This is not a Git repository"
    exit 1
fi

# Get the current branch
CURRENT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null) || {
    echo "Error: Unable to determine current branch"
    exit 1
}

# Function to commit a single file
commit_file() {
    local file="$1"
    local message="$2"
    
    if [ ! -f "$file" ] && [ ! -d "$file" ]; then
        echo "Warning: File/directory '$file' does not exist - skipping"
        return 1
    fi
    
    git add "$file"
    GIT_AUTHOR_DATE="$BACKDATE" GIT_COMMITTER_DATE="$BACKDATE" \
        git commit -m "$message" || {
            echo "Error: Failed to commit file '$file'"
            return 1
        }
}

# Main execution
echo "Backdating commits to $BACKDATE on branch $CURRENT_BRANCH"

# Commit each specified file
commit_file "ideal.sh" "edit script"
commit_file "main.java" "Update main file"

# Push to remote if desired
read -p "Do you want to push these commits to origin/$CURRENT_BRANCH? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    git push origin "$CURRENT_BRANCH" || {
        echo "Error: Failed to push to origin/$CURRENT_BRANCH"
        exit 1
    }
    echo "Successfully pushed backdated commits"
else
    echo "Changes committed locally but not pushed"
fi