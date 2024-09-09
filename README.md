clone this repo to your home directory

```
git clone https://github.com/bossearch/.dotfiles.git
```

I use `stow` to manage the dotfiles, `cd` to `.dotfiles` and use these command to copy all config files.

```
stow */
```

or use these command to copy a specific application config file, example for neovim.

```
stow nvim
```
