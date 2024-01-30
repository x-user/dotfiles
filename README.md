# Dotfiles

My dotfiles managed by [chezmoi](https://www.chezmoi.io)

## Installation

`homebrew` (linux & macos)

```bash
brew install chezmoi
chezmoi init github.com/x-user --apply
```

`curl` (unix)

```bash
sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init github.com/x-user --apply
```

`powershell` (windows)

```powershell
(irm -useb https://get.chezmoi.io/ps1) | powershell -c -
chezmoi init github.com/x-user --apply
```

<!-- code: language=markdown vim: set ft=markdown: -->
