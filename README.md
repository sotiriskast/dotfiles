dotfiles Debian/Ubuntu/Mac
==========================
Setup
-----

To set up the dotfiles run the appropriate snippet in the terminal:

(⚠️  __DO NOT__ run the `setup` script if you do not fully understand
[what it does][setup]. Seriously, __DON'T__!)


The setup process will:

* Download the dotfiles on your computer
  (by default it will suggest `~/projects/dotfiles`).
* [Symlink][symlink] the [Git], [shell], [tmux],
  and [Vim] related files.
* Install applications / command-line tools for
  [macOS][install macos] / [Ubuntu][install ubuntu].
* Set custom [macOS][preferences macos] /
  [Ubuntu][preferences ubuntu] preferences.
* Install the [Vim][vim plugins] and
  [VS Code][vscode plugins] plugins.

Setup process in action:

Screenshots
-----------

### Git

Output for `git status`:

| ![Output for Git status on macOS][git output macos] | ![Output for Git status on Ubuntu][git output ubuntu] |
|:---:|:---:|
| macOS | Ubuntu | Debian

Output for `git log`:

| ![Output for Git log on macOS][git log macos] | ![Output for Git log on Ubuntu][git log ubuntu] |
|:---:|:---:|
| macOS | Ubuntu | Debian


### tmux & Vim

| ![tmux and Vim on macOS][vim macos] | ![tmux and Vim on Ubuntu][vim ubuntu] |
|:---:|:---:|
| macOS | Ubuntu | Debian


Customize
---------

### Local Settings

The dotfiles can be easily extended to suit additional local
requirements by using the following files:

#### `~/.bash.local`

The `~/.bash.local` file will be automatically sourced after all
the other [Bash related files][shell], thus, allowing its content
to add to or overwrite the existing aliases, settings, `PATH`, etc.

Here is an example:

```shell
#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set PATH additions.

PATH="/Users/sotiriskast/projects/dotfiles/src/bin/:$PATH"

export PATH

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set local aliases.

alias g="git"
```

### Forks

If you decide to [fork] this project, do not forget to substitute
my username with your own in the [`setup` snippets](#setup) and
[in the `setup` script][setup script].

Update
------

To update the dotfiles you can either run the [`setup` script][setup]
or, if you want to update one particular part, run the appropriate
[`os` script](src/os).

License
-------

The code is available under the [MIT license][license].

<!-- Link labels: -->
