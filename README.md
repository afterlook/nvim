# Neovim Configuration

This is my personal Neovim configuration, built with Lua. It focuses on providing a streamlined and efficient coding experience.

## Prerequisites

To use this configuration effectively, ensure the following tools are installed on your system:

- **fzf**: A general-purpose command-line fuzzy finder, required for enhanced file navigation.
- **ripgrep**: A fast search tool for searching through code and files.
- **bat**: A clone of `cat` with syntax highlighting and Git integration.
- **editorconfig**: Maintains consistent coding styles across different editors.
- **Node.js (>= 18.x)**: Needed if using Copilot for code suggestions.
- **Lazygit**: git TUI

Make sure these general-purpose CLI tools are installed to ensure full functionality of the configuration.

## Structure

The configuration is organized as follows:

- `init.lua`: Main entry point for the configuration.
- `snippets/`: My custom snippets.
- `lua/`: Contains Lua modules for different aspects of the configuration.
  - `lua/user.lua`: User-specific settings and configurations.
  - `lua/keymaps.lua`: Custom key mappings.
  - `lua/util/`: Utility functions and modules.
  - `lua/plugins/`: All plugins and their configuration

## Usage

1. Install the prerequisites.
2. Clone this repository to your Neovim configuration directory (usually `~/.config/nvim`).
3. Start Neovim. lazy.nvim should automatically install the plugins.
4. Adjust, I have no idea if the prerequisites list is complete.
5. Any language specific stuff like LSP you also have to adjust and fix errors on the fly.
