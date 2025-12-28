# LaTeX Math Note-Taking Workspace

VS Code workspace for mathematical notes, homework, and exercises with auto-compilation and snippet expansion.

## Setup

1. **Install LaTeX distribution:**
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

**Main config:** `local-latex.code-workspace` contains all LaTeX Workshop settings, build tools, and the `TEXINPUTS` environment variable (enables LaTeX to find `tex-environments/`).

**Per-folder overrides:** Each `tex-source/*/.vscode/settings.json` only sets the output directory (`outDir`) for that folder's PDFs. Don't modify these unless you understand the structure.

**Portability:** All paths use `%WORKSPACE_FOLDER%` (which is the folder that `local-latex.code-workspace` was opened in). If you didn't start the workspace using `local-latex.code-workspace`, paths probably won't work as intended.
