
## Usage

sshrc works just like ssh, but it also sources the sshrc dir on your local computer after logging in remotely.

    $ echo "echo welcome" >> ~/flant/sshrc/.bashrc
    $ sshrc me@myserver
    welcome

    $ echo "alias ..='cd ..'" >> ~/flant/sshrc/.bashrc
    $ sshrc me@myserver
    $ type ..
    .. is aliased to `cd ..'

You can use this to set environment variables, define functions, and run post-login commands. It's that simple, and it won't impact other users on the server - even if they use sshrc too. This makes sshrc very useful if you share a server with multiple users and can't edit the server's ~/.bashrc without affecting them, or if you have several servers that you don't want to configure independently.

## Installation

#### Everything else

    git clone git@github.com:alexey-gavrilov-flant/sshrc.git ~/flant/sshrc &&
    ls -n ~/flant/sshrc/sshrc ~/bin/sshrc
    echo "alias ssh='sshrc'" >> ~/.bash_aliases

