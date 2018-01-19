# pd
A personal git repository for storing dotfiles & cheatsheets.

## Dot files
[vimrc](dotfiles/.vimrc)  
[zshrc](dotfiles/.zshrc)  
[tmux.conf](dotfiles/.tmux.conf)  
[rc.xml](dotfiles/rc.xml)

### Installing
To actually use the dotfiles that are provded, I've written a quick installer script. It just makes symbolic links from the repo to your home directory, so if you `git pull` any new changes they're applied to your system automatically.
`git clone` this repository and then `cd` into it with

```
git clone https://github.com/phildenhoff/pd.git
cd pd
```

Then, run the installer script in dotfiles/ with

```
bash dotfiles/setup.sh
```

You'll now see the files represented in your home directory, as symbolic links.

You'll need to install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh),
[vim-plug](https://github.com/junegunn/vim-plug), and the
[pyte](https://github.com/therubymug/vim-pyte) vim theme.

## Cheatsheets
[vim](cheatsheets/vim.md)  
[zsh](cheatsheets/zsh.md)  
[linux](cheatsheets/linux.md)  
[openbox](cheatsheets/openbox.md)  
