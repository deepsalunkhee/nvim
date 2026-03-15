# Neovim Configuration Overview

This is a modern, modular Neovim configuration written in Lua, designed for a full IDE experience on Ubuntu/WSL. It uses `lazy.nvim` for plugin management and `mason.nvim` for managing LSP servers, linters, and formatters.

## Project Structure

- `init.lua`: Main entry point that loads core settings and the plugin manager.
- `lua/core/`: Contains fundamental Neovim configurations.
  - `options.lua`: Core Neovim settings (indentation, UI, leader key, etc.).
  - `keymaps.lua`: Global keybindings (navigation, window management, etc.).
  - `lazy.lua`: Bootstraps the `lazy.nvim` plugin manager.
- `lua/plugins/`: Individual plugin configuration files (LSP, Telescope, Treesitter, etc.).
- `setup.sh`: A shell script for automated installation of Neovim and all system dependencies.

## Key Technologies

- **Editor**: Neovim 0.11+
- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim)
- **LSP Support**: [mason.nvim](https://github.com/williamboman/mason.nvim), [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim), [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- **Git Integration**: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) (Line-level status and blame)
- **File Explorer**: [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) (With Git status icons)
- **Fuzzy Finder**: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- **Syntax Highlighting**: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- **UI Enhancements**: [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim), [which-key.nvim](https://github.com/folke/which-key.nvim)
- **AI Completion**: [copilot.lua](https://github.com/zbirenbaum/copilot.lua)

## Building and Running

### Initial Setup (Ubuntu/WSL)
1.  Ensure you have `git` installed.
2.  Clone this repository to `~/.config/nvim`.
3.  Run the setup script to install Neovim, language servers, and formatters:
    ```bash
    chmod +x setup.sh
    ./setup.sh
    ```

### Launching Neovim
Simply run:
```bash
nvim
```
On the first run, `lazy.nvim` will automatically download and install all configured plugins.

### Managing Plugins and LSPs
- **Plugins**: Run `:Lazy` to open the plugin manager dashboard.
- **LSPs/Formatters**: Run `:Mason` to manage language servers, linters, and formatters.

## Development Conventions

- **Leader Key**: The `<Space>` key is configured as the global map leader.
- **Modular Config**: New plugins should be added as separate files in `lua/plugins/` following the `lazy.nvim` specification format.
- **Keybindings Help**: Use `<leader>km` (or wait after pressing `<leader>`) to trigger `which-key` for a searchable list of available keybindings.

### Common Keybindings

| Keymap | Action |
| :--- | :--- |
| `<leader>e` | Toggle file explorer (`NvimTree`) |
| `<leader>ff` | Search files (Telescope) |
| `<leader>fg` | Search text across project (Live Grep) |
| `]c` / `[c` | Jump to next/prev Git hunk |
| `<leader>hp` | Preview Git hunk |
| `<leader>hb` | Show Git blame for current line |
| `gd` | Go to definition (LSP) |
| `K` | Show hover information (LSP) |
| `<leader>rn` | Rename symbol (LSP) |
| `<leader>ca` | Code actions (LSP) |
| `[d` / `]d` | Navigate diagnostics (LSP) |
| `<C-h/j/k/l>` | Navigate between windows |
| `<S-h/l>` | Navigate between buffers |

## Formatting Standards
The project includes automatic formatting for several languages via the `setup.sh` script:
- **Lua**: `stylua`
- **JS/TS/HTML/CSS/JSON**: `prettier`
- **C/C++**: `clang-format`
- **Java**: `google-java-format`
