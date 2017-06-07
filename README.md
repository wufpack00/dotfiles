# dotfiles
My preferred bash config

Many thanks to all the bloggers, coders, github-ers, etc. that have provided countless examples for me to use as a starting point.

**Initial Setup**

1. Clone repo into home directory
2. Execute bootstrap script to backup existing dotfiles and create symlinks to these
~~~~
$> git clone git@github.com:wufpack00/dotfiles.git
$> ./dotfiles/bin/bootstrap.sh
~~~~

At this time, not all config files are included as part of the bootstrap.sh script setup.

**Cygwin**

1. Down and install cygwin (select lynx as package to install)
2. Install package manager
~~~~
$> lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg
$> install apt-cyg /bin
~~~~

3. Install tools
~~~~
$> apt-cyg install wget curl tar openssh openssl make vim gcc-core git screen tmux ruby 
~~~~

4. Install tumxinator - https://github.com/tmuxinator/tmuxinator
~~~~
$> gem install tmuxinator
~~~~

**Mac OS X**

1. Install package manager - http://brew.sh/

~~~~
$> /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$> brew install tmux
$> gem install tmuxinator
~~~~


**Vagrant Setup**

1. Download and install vagrant
2. Bring up default box 
~~~~
$> mkcd vagrant-ubuntu-trusty64-docker
$> vagrant init williamyeh/ubuntu-trusty64-docker
$> vagrant up
$> vagrant ssh
~~~~
