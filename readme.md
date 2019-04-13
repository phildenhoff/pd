# pd
A place to backup my .nix configs, because I've already deleted them once.

## dotfiles

`configuration.nix`, `entertainment.nix`, and `software-dev.nix` must be hardlinked to
/etc/nixos.
`home.nix` must be hardlinked to `~/.config/nixpkgs`.

Symlinks do not work; nix-rebuild and home-manager will fail to read the files.

## Cheatsheets
[vim](cheatsheets/vim.md)  
[zsh](cheatsheets/zsh.md)  
[linux](cheatsheets/linux.md)  
[openbox](cheatsheets/openbox.md)  
