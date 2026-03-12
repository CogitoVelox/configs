#!/usr/bin/env bash
set -euo pipefail

# ---------------------------------------------------------------------------
# install.sh — idempotent setup script for neovim + dependencies
#
# Usage (from cloned repo):
#   bash install.sh
#
# Usage (via curl, clones repo automatically):
#   curl -fsSL https://raw.githubusercontent.com/cogitovelox/configs/master/install.sh | bash
# ---------------------------------------------------------------------------

REPO_URL="https://github.com/cogitovelox/configs"
REPO_DIR="${REPO_DIR:-$HOME/.config/clonedconfigs/configs}"

# If running as a file (not piped), resolve the script's own directory
if [[ -n "${BASH_SOURCE[0]:-}" && "${BASH_SOURCE[0]}" != "bash" ]]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    if [[ -f "$SCRIPT_DIR/nvim/init.lua" ]]; then
        REPO_DIR="$SCRIPT_DIR"
    fi
fi

info()    { echo "[install] $*"; }
success() { echo "[install] ✓ $*"; }

# ---------------------------------------------------------------------------
# 1. Clone repo if not present
# ---------------------------------------------------------------------------
if [[ ! -d "$REPO_DIR/.git" ]]; then
    info "Cloning configs repo to $REPO_DIR..."
    git clone "$REPO_URL" "$REPO_DIR"
fi

# ---------------------------------------------------------------------------
# 2. Install system packages (apt-based systems only)
# ---------------------------------------------------------------------------
if command -v apt-get &>/dev/null; then
    info "Installing system packages..."
    sudo apt-get update -qq
    sudo apt-get install -y ripgrep fd-find unzip curl git npm
    success "System packages installed."
fi

# ---------------------------------------------------------------------------
# 3. Install tree-sitter-cli if not present
# ---------------------------------------------------------------------------
if command -v npm &>/dev/null && ! npm list -g tree-sitter-cli &>/dev/null; then
    info "Installing tree-sitter-cli..."
    sudo npm install -g tree-sitter-cli
    success "tree-sitter-cli installed."
fi

# ---------------------------------------------------------------------------
# 4. Install neovim if not present
# ---------------------------------------------------------------------------
if ! command -v nvim &>/dev/null; then
    info "Fetching latest neovim release..."
    NVIM_VERSION=$(curl -fsSL "https://api.github.com/repos/neovim/neovim-releases/releases/latest" \
        | grep -Po '"tag_name": "\K[^"]*')
    NVIM_TMP="/tmp/nvim-linux-x86_64.appimage"
    info "Downloading neovim $NVIM_VERSION..."
    curl -fsSL -o "$NVIM_TMP" \
        "https://github.com/neovim/neovim-releases/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.appimage"
    chmod u+x "$NVIM_TMP"
    sudo mv "$NVIM_TMP" /usr/local/bin/nvim
    success "Neovim $NVIM_VERSION installed."
else
    success "Neovim already installed ($(nvim --version | head -1))."
fi

# ---------------------------------------------------------------------------
# 5. Install lazygit if not present
# ---------------------------------------------------------------------------
if ! command -v lazygit &>/dev/null; then
    info "Installing lazygit..."
    LAZYGIT_VERSION=$(curl -fsSL "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
        | grep -Po '"tag_name": "v\K[^"]*')
    curl -fsSL -o /tmp/lazygit.tar.gz \
        "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar -xf /tmp/lazygit.tar.gz -C /tmp lazygit
    sudo install /tmp/lazygit /usr/local/bin/
    rm -f /tmp/lazygit.tar.gz /tmp/lazygit
    success "lazygit installed."
else
    success "lazygit already installed."
fi

# ---------------------------------------------------------------------------
# 6. WSL: install win32yank for clipboard support
# ---------------------------------------------------------------------------
if grep -qi 'wsl' /proc/version 2>/dev/null; then
    if ! command -v win32yank.exe &>/dev/null; then
        info "WSL detected — installing win32yank for clipboard support..."
        curl -fsSL -o /tmp/win32yank-x64.zip \
            "https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip"
        unzip -o /tmp/win32yank-x64.zip -d /tmp win32yank.exe
        chmod +x /tmp/win32yank.exe
        sudo mv /tmp/win32yank.exe /usr/local/bin/
        rm -f /tmp/win32yank-x64.zip
        success "win32yank installed."
    else
        success "win32yank already installed."
    fi
fi

# ---------------------------------------------------------------------------
# 7. Initialize git submodules (tmux plugins, etc.)
# ---------------------------------------------------------------------------
info "Updating git submodules..."
git -C "$REPO_DIR" submodule update --init --recursive
success "Submodules up to date."

# ---------------------------------------------------------------------------
# 8. Symlinks
#
# Format: "repo/source/path:destination"
# Add a new line here to symlink any new config to its expected location.
# ---------------------------------------------------------------------------
SYMLINKS=(
    "nvim:${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
    "tmux:${XDG_CONFIG_HOME:-$HOME/.config}/tmux"
    "clang-format/clang-format:$HOME/.clang-format"
)

# tmux plugin manager expects plugins at ~/.tmux/plugins — symlink that too
mkdir -p "$HOME/.tmux"
SYMLINKS+=("tmux/plugins:$HOME/.tmux/plugins")

for entry in "${SYMLINKS[@]}"; do
    src="$REPO_DIR/${entry%%:*}"
    dest="${entry##*:}"
    if [[ -L "$dest" ]]; then
        success "$dest already symlinked."
    elif [[ -e "$dest" ]]; then
        echo "[install] WARNING: $dest already exists (not a symlink). Back it up and re-run."
    else
        ln -s "$src" "$dest"
        success "Symlinked $dest → $src"
    fi
done

# ---------------------------------------------------------------------------
echo ""
echo "All done! Open neovim with 'nvim' — lazy.nvim will auto-install plugins on first launch."
