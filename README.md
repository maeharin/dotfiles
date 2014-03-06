## how to use
```sh
# 1. git clone
$ cd ~
$ git clone git@github.com:maeharin/dotfiles.git

# 2. create symbolic link
$ cd ~
$ ln -s dotfiles/.bash_profile
$ ln -s dotfiles/.bashrc
$ ln -s dotfiles/.bash_logout
$ ln -s dotfiles/.vimrc
$ ln -s dotriles/.vim
$ ln -s dotfiles/.tmux.conf

# 3. (optional) add your own .bash_ignored
$ vim dotfiles/.bash_git_ignored
edit...
$ ln -s dotfiles/.bash_git_ignored 

# 4. update git submodule(Vundler)
$ cd dotfiles
$ git submodule init
$ git submodule update

# 5. vundle install
$ vim
:BundleInstall
```
