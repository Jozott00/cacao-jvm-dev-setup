#!/bin/sh

set -e

echo "Install Unijit dependencies"

apt-get install -y  cmake \
                    clang \
                    flex  \
                    bison \
                    lld

echo "Install Ninja ..."
wget -qO /usr/local/bin/ninja.gz https://github.com/ninja-build/ninja/releases/latest/download/ninja-linux.zip
gunzip /usr/local/bin/ninja.gz
chmod a+x /usr/local/bin/ninja
ninjavr=$(ninja --version)
echo "Installed ninja version $ninjavr"

