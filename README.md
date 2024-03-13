
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
    ln -s ~/flant/sshrc/sshrc ~/bin/sshrc
    echo "alias ssh='sshrc'" >> ~/.bash_aliases
    touch ~/flant/sshrc/.bash_secret

```
dh_auth=license-token:....
user_name=f...-g...
user_email=g...@...com
user_pass=.....
user_crypt=\$2a\$12\$....
node_user=....
node_pass=\$6\$O6TPJh....
node_sshkey="cert-authority,principals=\"...\" ssh-rsa AAAA..."
```

At MacOS you also need `base64` command from `coreutils` package

    brew install coreutils &&
    ln -s /opt/homebrew/opt/coreutils/libexec/gnubin/base64 ~/bin/base64

## Useful pipelines

Before D8 version `v1.55.0` it may help to solve D8NodeIsNotUpdating that caused by infinity timeout in apt-get

    k.get.clusteralerts | grep D8NodeIsNotUpdating | awk '{ print "k.get.clusteralerts " $1 " -o yaml" }' | bash | grep 'node:' | awk '{ print "k.exec.node " $2 " \"systemctl restart apt-daily bashible\"" }' | bash
