# Link dotfiles to github dotfiles

if [ "~/.zshrc" ]; then
    mv ~/.zshrc ~/.zshrc.bak
fi

if [ "~/.vimrc" ]; then
    mv ~/.vimrc ~/.vimrc.bak
fi

if [ "~/.tmux.conf" ]; then
    mv ~/.tmux.conf ~/.tmux.conf.bak
fi

ln .zshrc ~/.zshrc
ln .tmux.conf ~/.tmux.conf
ln .vimrc ~/.vimrc
ln rc.xml ~/.config/openbox/rc.xml
