# dotfiles
My preferred bash config

Many thanks to all the bloggers, coders, github-ers, etc. that have provided countless examples for me to use as a starting point.

**Cygwin**

1. Down and install cygwin
2. Install package manager
~~~~
$> lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg
$> install apt-cyg /bin
~~~~

3. Install tools
~~~~
$> apt-cyg install git screen tmux ruby
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
