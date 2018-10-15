## how to use

```sh
# update git submodule(Vundler)
$ git submodule init
$ git submodule update

# create symbolic link
$ cd ~
$ ./dotfiles/link.sh

# neo bundle install
$ vim
:NeoBundleInstall

#  (optional) add your own .bash_ignored
$ vim dotfiles/.bash_git_ignored
edit...
$ ln -s dotfiles/.bash_git_ignored 
```

