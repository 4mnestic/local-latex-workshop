#!/bin/bash
# Sync script: Copies tex-source/ and build/ to private repo, commits, and pushes

set -e  # Exit on error

# Configuration
PUBLIC_REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PRIVATE_REPO_DIR="${PUBLIC_REPO_DIR}/../local-latex-private"

echo "Syncing to private repository..."

# Check if private repo directory exists
if [ ! -d "$PRIVATE_REPO_DIR" ]; then
    echo "Error: Private repository directory not found at: $PRIVATE_REPO_DIR"
    echo "Please create the private repository first:"
    echo "  mkdir -p $PRIVATE_REPO_DIR"
    echo "  cd $PRIVATE_REPO_DIR"
    echo "  git init"
    echo "  gh repo create --private --source=. --remote=origin"
    exit 1
fi

# Check if it's a git repository
if [ ! -d "$PRIVATE_REPO_DIR/.git" ]; then
    echo "Error: $PRIVATE_REPO_DIR is not a git repository"
    exit 1
fi

# Copy directories
echo "Copying tex-source/ and build/..."
rsync -av --delete "$PUBLIC_REPO_DIR/tex-source/" "$PRIVATE_REPO_DIR/tex-source/"
rsync -av --delete "$PUBLIC_REPO_DIR/build/" "$PRIVATE_REPO_DIR/build/"

# Change to private repo directory
cd "$PRIVATE_REPO_DIR"

# Stage all changes (including untracked files)
echo "Staging changes..."
git add -A

# Check if there are any staged changes to commit
if git diff --cached --quiet; then
    echo "No changes to commit."
    exit 0
fi

# Commit
echo "Committing changes..."
git commit -m "Sync from local-latex workspace $(date +%Y-%m-%d\ %H:%M:%S)"

# Push
echo "Pushing to remote..."
if git remote | grep -q "^origin$"; then
    git push origin master 2>/dev/null || git push origin main 2>/dev/null || {
        echo "Warning: Push failed. You may need to set up the remote:"
        echo "  git remote add origin <your-repo-url>"
        echo "  git push -u origin master  # or main"
    }
else
    echo "Warning: No 'origin' remote found. Set it up with:"
    echo "  git remote add origin <your-repo-url>"
fi

echo "Sync complete!"

