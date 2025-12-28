# LaTeX Math Note-Taking Workspace

VS Code workspace for mathematical notes, homework, and exercises with auto-compilation and snippet expansion.

## Setup

1. **Install LaTeX distribution (Arch Linux):**
   ```bash
   sudo pacman -S texlive-most texlive-lang
   ```

2. **Install VS Code extensions:**
   - LaTeX Workshop (`James-Yu.latex-workshop`)
   - HyperSnips (`draivin.hsnips`)
   - VS Code will prompt to install these when opening the workspace

3. **Open workspace:** Open `local-latex.code-workspace` in VS Code
   - All LaTeX compilation settings are configured automatically
   - HyperSnips auto-detects `.hsnips` files in the workspace (snippets work immediately)

4. **Setup existing notes:**
   
   **Manual setup:**
   - Clone this repository
   - Move `.tex` files into `tex-source/`.
     - Check out [configuration](#configuration) if you're lost.
   - Optionally move `.pdf` and `.synctex.gz` files into `build/`.
   
   **Automated setup:**
   
   Download and run in one command:
   ```bash
   bash <(curl -fsSL https://raw.githubusercontent.com/4mnestic/local-latex-workshop/main/setup-workspace.sh)
   ```
   
   Or download before you run:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/4mnestic/local-latex-workshop/main/setup-workspace.sh -o setup-workspace.sh
   ```
   
   The script clones this main repo and prompts you for a private repo URL with your `build/` and `tex-source/` folders. It puts your `build/` and `tex-source/` folders into this main repo. The private repo is **kept** and can be automatically updated with the other script: `sync-to-private.sh`.

## Structure

- `tex-source/notes/` - Personal notes (template: `template.tex`)
- `tex-source/homework-and-exercises/` - Course homework
- `tex-source/tex-environments/` - Shared LaTeX environments
- `build/` - ALL compiled PDFs (auto-generated on-save)

## Usage

1. Create/edit `.tex` files in `tex-source/`
2. Save (`ctrl+S`) → PDF auto-compiles to `build/`
3. Use snippets: `//` → `\frac{}{}`, `sum` → `\sum_{}^{}`, `alpha` → `\alpha`, etc.
4. Click between source and PDF for sync navigation

## Snippets

HyperSnips automatically detects `.hsnips` files in the workspace. Snippets are available immediately after opening the workspace.

Full snippet list: `snippets/math.hsnips` or `math.hsnips`
- Fractions: `//`, `/2`, `/3`
- Greek: `alpha`, `beta`, `theta`, `pi`, `lambda`, etc.
- Math: `sum`, `int`, `lim`, `in`, `subset`
- Sets: `RR` → `\mathbb{R}`, `NN`, `ZZ`, `QQ`, `CC`
- Environments: `align`, `cases`

## Custom Environments

Import shared environments in your `.tex` files:
```latex
\input{../tex-environments/environments}
```



Provides colored theorem boxes, custom commands, and enhanced math environments.

## Configuration

**Main config:** `local-latex.code-workspace` contains all LaTeX Workshop settings, build tools, and the `TEXINPUTS` environment variable (enables LaTeX to find `tex-environments/`). Also defines the root directories for multi-root workshop!

**Per-folder overrides:** Each `tex-source/*/.vscode/settings.json` only sets the output directory (`outDir`) for that folder's PDFs. Don't modify these unless you understand the structure.

**Portability:** All paths use `%WORKSPACE_FOLDER%` (which is the folder that `local-latex.code-workspace` was opened in). If you didn't start the workspace using `local-latex.code-workspace`, paths probably won't work as intended.

## Scripts

**`sync-to-private.sh` (tested)** - Syncs `tex-source/` and `build/` to a private repository. Run this whenever you update your LaTeX files:
```bash
./sync-to-private.sh
```
Requires a private repo at `../local-latex-private/` with git initialized and remote configured.

**`setup-workspace.sh` (UNTESTED)** - Automated setup script for new computers. Clones both public and private repos, merges them, and sets up the workspace. See Setup section above for one-liner usage.

To customize: download the script, edit the `PRIVATE_REPO_URL` variable, then run:
```bash
curl -O https://raw.githubusercontent.com/4mnestic/local-latex-workshop/main/setup-workspace.sh
# Edit PRIVATE_REPO_URL in the script
bash setup-workspace.sh
```
