# Acknowledgements

Thanks to [dinfuehr](https://gist.github.com/dinfuehr) for providing [cacao-jvm-dockerfile](https://gist.github.com/dinfuehr/ab83ad825cd24be0e816588d0465a7fb), on which this guide is based.
Also thanks to [Tobias Schwarzinger](https://github.com/tobixdev) who wrote the original guide.

# What is this?

This guide summarizes the setup of a [cacaojvm](http://www.cacaojvm.org/) dev container using docker.

It is tested on x86_64 Linux and M1 Apple Silicon. In theory it should walk for x86* Windows machines as well.

Tools used in this guide:
* OS System
* docker deamon
* Visual Studio Code
    * [Remote - Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

# Getting Started

* Fork or clone this repository.
* Change the git repository link in the Dockerfile (`RUN git clone https://bitbucket.org/cacaovm/cacao.git`) to your forked cacao repository.
* Download the Linux x84 openjdk7 tar.gz file from the [Oracle archive](https://www.oracle.com/java/technologies/javase/javase7-archive-downloads.html) and place it in this directory. The name should be `jdk-7u80-linux-x64.tar.gz`.
* Open VS Code
* Create the dev container
    * Press `CMD/CTRL + SHIFT + P` or `F1` to open the command palette.
    * Execute the command `Remote-Containers: Reopen in Container`
* VS Code/docker will setup the container for you
* Verify the installation
  * I specified the workspace path to `/code/cacao` so you should be located there
  * Validate the environment by invoking `make check` in the `/code/build` directory

# Differences to the original guide

* The Docker container requires `jdk7`, which the original Dockerfile installed via `apt` from `ppa/openjdk`. For some time now, `jdk7` is no longer available via apt, so we install it manually.
* In the past mercurial was used as version control system. Since a while the CACAO dev-team uses git with the repository hosted on a [Bitbucket repository](https://bitbucket.org/cacaovm/cacao/src/master/). This Dockerfile changed all necessary things to use git instead of mercurial.
* Also, I leave gcc on version 9 and do not upgrade to a higher version as this ends in an error when building cacao.
* I also added the `devcontainer.json` file since it now contains the workspace path which is specified to be `/code/cacao`.