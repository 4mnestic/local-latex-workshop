#!/bin/bash
# Setup script: Downloads both repos and merges them together

# Configuration
PUBLIC_REPO_URL="git@github.com:4mnestic/local-latex-workshop.git"
DEFAULT_PRIVATE_REPO_URL="git@github.com:4mnestic/local-latex-private.git"
WORKSPACE_DIR="local-latex"

echo "Setting up LaTeX workspace..."

# Check if workspace directory already exists
if [ -d "$WORKSPACE_DIR" ]; then
    echo "Error: Directory '$WORKSPACE_DIR' already exists."
    echo "Please remove it first or choose a different directory name."
    exit 1
fi

# Prompt for private repo URL
echo "Enter your private repository URL (default: $DEFAULT_PRIVATE_REPO_URL, or press Enter to skip):"
read -r PRIVATE_REPO_URL
if [ -z "$PRIVATE_REPO_URL" ]; then
    PRIVATE_REPO_URL="$DEFAULT_PRIVATE_REPO_URL"
fi

# Clone public repository
echo "Cloning public repository..."
if ! git clone "$PUBLIC_REPO_URL" "$WORKSPACE_DIR"; then
    echo "Error: Failed to clone public repository."
    exit 1
fi
cd "$WORKSPACE_DIR"

# Clone private repository to temp location
TEMP_PRIVATE_DIR="../local-latex-private-temp"
if [ -n "$PRIVATE_REPO_URL" ]; then
    echo "Cloning private repository..."
    # Try to clone, suppress error output initially
    if git clone "$PRIVATE_REPO_URL" "$TEMP_PRIVATE_DIR" 2>/dev/null; then
        # Clone succeeded
        # Copy tex-source/ and build/ from private to public
        echo "Merging private content..."
        if [ -d "$TEMP_PRIVATE_DIR/tex-source" ]; then
            rsync -av --delete "$TEMP_PRIVATE_DIR/tex-source/" "tex-source/"
        fi
        if [ -d "$TEMP_PRIVATE_DIR/build" ]; then
            rsync -av --delete "$TEMP_PRIVATE_DIR/build/" "build/"
        fi
        
        # Clean up temp directory
        echo "Cleaning up..."
        rm -rf "$TEMP_PRIVATE_DIR"
        echo "Private content merged successfully."
    else
        # Clone failed - provide helpful message
        echo ""
        echo "Warning: Could not clone private repository."
        echo "This is normal if you don't have access to the private repo."
        echo "The workspace will be set up with empty tex-source/ and build/ directories."
        echo "You can add your own content or clone your private repo separately."
        # Clean up any partial clone
        rm -rf "$TEMP_PRIVATE_DIR" 2>/dev/null || true
    fi
else
    echo "Skipping private repository (URL not provided)"
    echo "You can manually copy tex-source/ and build/ from your private repo later."
fi

echo ""
echo "Setup complete! Next steps:"
echo "  1. cd $WORKSPACE_DIR"
echo "  2. Open local-latex.code-workspace in VS Code"
echo "  3. Install VS Code extensions (LaTeX Workshop, HyperSnips)"
echo "  4. Install LaTeX distribution: sudo pacman -S texlive-most texlive-lang"

