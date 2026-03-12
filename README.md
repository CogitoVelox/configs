# Neovim Config

Based on [LazyVim](https://github.com/LazyVim/LazyVim).

## Setup (two steps)

**1. Clone the repo**

```bash
git clone https://github.com/cogitovelox/configs ~/.config/clonedconfigs/configs
```

**2. Run the install script**

```bash
bash ~/.config/clonedconfigs/configs/install.sh
```

Or, if you prefer to skip the clone and do it all in one shot:

```bash
curl -fsSL https://raw.githubusercontent.com/cogitovelox/configs/master/install.sh | bash
```

The script is safe to re-run — it skips anything already installed or symlinked.

### Keeping configs up to date

Because the install script creates symlinks (e.g. `~/.config/nvim` → `~/.config/clonedconfigs/configs/nvim`), a simple pull is all you ever need to update your live config:

```bash
git -C ~/.config/clonedconfigs/configs pull
```

### What the script does

- Installs system packages: `ripgrep`, `fd-find`, `npm`, `unzip`
- Installs the latest **neovim** release (via appimage → `/usr/local/bin/nvim`)
- Installs **lazygit** (latest release)
- Installs **tree-sitter-cli** (via npm)
- On WSL: installs **win32yank** for clipboard support
- Symlinks `~/.config/nvim` → `~/.config/configs/nvim`
- Symlinks `~/.clang-format` → `~/.config/configs/clang-format/clang-format`

On first launch, neovim will auto-install lazy.nvim and all plugins.

---

## Manual / optional setup

### Nerd Font (icons)

Download a Nerd Font from [nerdfonts.com](https://www.nerdfonts.com/font-downloads) and install it **on Windows** (for WSL), then set it as your terminal default.

### Starship prompt

```bash
curl -fsSL https://starship.rs/install.sh | bash
```

Then add to `~/.bashrc`:

```bash
eval "$(starship init bash)"
```

### ctags (jump-to-definition fallback)

```bash
sudo apt install exuberant-ctags
ctags -R .
```

- Jump to definition: `Ctrl-]`
- Jump back: `Ctrl-t`

### XDG Base Directories

If not already set, add to `~/.bashrc`:

```bash
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
```

---

## Plugins

| Category | Plugin |
|---|---|
| Plugin manager | [lazy.nvim](https://github.com/folke/lazy.nvim) via LazyVim |
| Language | TypeScript, JSON, C/C++ (clangd) |
| UI | mini-animate |
| Motion | flash.nvim (search mode disabled) |
| Git | lazygit |

Custom plugin specs live in `nvim/lua/plugins/`. See `example.lua` for a reference of common config patterns.
