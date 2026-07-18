# dotfiles

## Getting Started

1. Clone this repository into `~/dotfiles`.
2. Run `git submodule update --init --recursive` to install submodules
3. Install the dependencies below and run `stow .` in `~/dotfiles`. You may need to comment some lines from `.zshrc` if you aren't using certain software (e.g., `nvm`, `golang`, or `ghcup`). Once the `.zshrc` loads without fail,
4. Run `bat cache --build` to load the `bat` themes
5. Run `sourcetmux` to load tmux plugins
6. Press `Ctrl+a` + `I` inside a tmux session to install tmux plugins
7. Open Neovim (`nvim`) to install Neovim plugins

## Dependencies

- [Homebrew]("https://brew.sh/")
- [oh-my-zsh](https://ohmyz.sh/)
- [Volta](https://volta.sh/)
- Node `volta install node`
- pi `npm install -g --ignore-scripts @earendil-works/pi-coding-agent`

### Casks

- Ghostty `brew install --cask ghostty`
- FiraCode Nerd Font `brew install font-fira-code-nerd-font`
- Rectangle `brew install rectangle`
- Raycast `brew install raycast`
- cmux:

  ```bash
  brew tap manaflow-ai/cmux
  brew install --cask cmux
  ```

### Formulae

- stow `brew install stow`
- zsh `brew install zsh`
- eza `brew install eza`
- ripgrep `brew install ripgrep`
- Neovim `brew install neovim`
- tmux `brew install tmux`
- Starship `brew install starship`
- Nerdfetch `brew install nerdfetch`
- zsh-autosuggestions `brew install zsh-autosuggestions`
- fzf `brew install fzf`
- fd `brew install fd`
- luarocks `brew install luarocks`
- less `brew install less` (most recent version, dependency of `bat`)
- bat `brew install bat`
- hunk `brew install hunk`
- glow `brew install glow`
- go `brew install go`
- yt-dlp `brew install yt-dlp`
- ffmpeg `brew install ffmpeg`
- tree-sitter-cli `brew install tree-sitter-cli`

### Hunk

Configure [Hunk](https://github.com/modem-dev/hunk#git-integration) as Git's pager:

```bash
git config --global core.pager "hunk pager"
```

### Obsidian

Keep generic Obsidian config in `~/dotfiles/.obsidian` and symlink it into each vault while leaving vault-local state, such as `workspace.json`, `graph.json`, and `daily-notes.json`, inside the vault.

Install and enable [Kanban](https://github.com/obsidian-community/obsidian-kanban) through Obsidian's community-plugin UI before linking this shared configuration. Track its installed runtime under `.obsidian/plugins/obsidian-kanban/` and enable `obsidian-kanban` in `.obsidian/community-plugins.json` only after `manifest.json` and non-empty `main.js` exist. Code Brain boards remain ordinary Markdown and wikilinks, so the workflow data stays readable without the plugin.

```bash
~/dotfiles/scripts/link-obsidian-vault-config \
  ~/Documents/Obsidian\ Vault \
  ~/Documents/Code\ Brain
```

Preview first with:

```bash
~/dotfiles/scripts/link-obsidian-vault-config --dry-run ~/Documents/Obsidian\ Vault
```
