# Install

1. Download
  
```
git clone https://github.com/urugus/dotfiles.git
cd dotfiles
```

2. Setup

```
./setup.sh --install
```

3. Check links

```
./install_scripts/dotinstaller.sh doctor
```

Only git-tracked entries are linked: top-level dotfiles to `~/`, and each child of `.config/` to `~/.config/<name>`. `~/.config` itself must be a real directory, not a symlink to this repo.

# Hardware
 
 ### Keyboard

- [Lalapad](https://booth.pm/ja/items/6669026?srsltid=AfmBOooX4ooJo6bmkYag9PLYvjE8m6VKcu_sCBVIWuu2CLzzob7ZHIBl)

# Components

## Editor

- [neovim](https://neovim.io)
  - [config](https://github.com/urugus/dotfiles/tree/master/.config/nvim) 
  - [plugins](https://github.com/urugus/dotfiles/blob/master/.config/nvim/lua/rc/pluginlist.lua)

## CUI

- zsh
- [packages](https://github.com/urugus/dotfiles/blob/master/.config/brewfile/Brewfile)
- [ghostty](https://ghostty.org/docs)
  - [config](https://github.com/urugus/dotfiles/tree/master/.config/ghostty)
- たまに気分で [neovide](https://neovide.dev)
