# Acknowledgements

Thanks to [dinfuehr](https://gist.github.com/dinfuehr) for providing the original [cacao-jvm-dockerfile](https://gist.github.com/dinfuehr/ab83ad825cd24be0e816588d0465a7fb).
Also thanks to [Tobias Schwarzinger](https://github.com/tobixdev) and [Robert Obkircher](https://github.com/RobertObkircher) who extended the Dockerfile.

## IMPORTANT
While the master branch has a more general configuration, the unijit branch is more stable and updated.

# What is this?

This guide summarizes the setup of a [cacaojvm](http://www.cacaojvm.org/) dev container using docker.

It is tested on x86_64 Linux and M1 Apple Silicon. In theory it should work for x86_64 Windows machines as well.

Tools used in this guide:
* OS System
* docker deamon
* Visual Studio Code
    * [Remote - Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

# Getting Started

* Fork or clone this repository.
* Open VS Code
* Change the CACAO git repository link in `.devcontainer/devcontainer.json` (`"CACAO_REPO": "https://ea.complang.tuwien.ac.at/UniJIT/cacao.git"`) to your required cacao repo fork.
* Create the dev container
    * Press `CMD/CTRL + SHIFT + P` or `F1` to open the command palette.
    * Execute the command `Remote-Containers: Reopen in Container`
* VS Code/docker will setup the container for you. It should open a VS Code window in `/code` inside the container.
* Verify the environment
  * Run `sh /tools/gettingStarted.sh`. This might take a while...
  * Validate the environment by invoking `make check` in the `/code/build` directory

# Build the executable

Go to `/code/build` and run `make`. This will take a while and creates the executable `/code/build/cacao/cacao` and the respective `libjvm.so` `/code/build/cacao/.libs/libjvm.so`. 
To speed things up, you can execute `make` with `make -j 12` which uses 12 threads to compile the project. Note that you should increase the allowed docker resoureces in the docker preferences (RAM, Cores). In case the build process crashes, rerun the `make -j ..` command with less threads.


# Run a java `Hello World`

1. Create a `/code/HelloWorld` directory and write a little Java `HelloWorld.java` program.
2. Run `javac HelloWorld.java`. That creates a `HelloWorld.class` file.

Now run
```bash
LD_LIBRARY_PATH=/code/build/src/cacao/.libs:$LD_LIBRARY_PATH /code/build/src/cacao/cacao -Xbootclasspath:/code/build/src/classes/classes:/usr/local/classpath/share/classpath/glibj.zip HelloWorld
```
this will execute the java program.
### Execution command explanation

We set `LD_LIBRARY_PATH` to the directory cacao shared library, so when the cacao process calls `dlopen(3)` it find the `libjvm.so` shared object. 
`/code/build/src/cacao/cacao` calls the `cacao` executable.

`-Xbootclasspath` defines location of class files loaded by the bootstrap classloader (java*, javax.*).

# Some helpful commands

#### Check environment
```
cd /code/build 
make check
```
#### Build doxygen documentation
This builds the code documentation, which is nice to have since the cacaovm.org documentation page isn't reachable anymore.
```
mkdir /code/docs && cd /code/docs
doxygen /code/build/doc/doxygen/Doxyfile
```
# Differences to the original guide

* The Docker container requires `jdk7`, which the original Dockerfile installed via `apt` from `ppa/openjdk`. For some time now, `jdk7` is no longer available via apt, so we install zulu7-jdk.
* In the past mercurial was used as version control system. Since a while the CACAO dev-team uses git with the repository hosted on a [Bitbucket repository](https://bitbucket.org/cacaovm/cacao/src/master/). This Dockerfile changed all necessary things to use git instead of mercurial.
* I also added the `devcontainer.json` file since it now contains the workspace path which is specified to be `/code/cacao`.
* `tools/` contains some useful scripts (e.g. `gettingStarted.sh`) to run complicated commands.
