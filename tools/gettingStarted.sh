#!/bin/sh
# Usage: ./pre_build.sh PRE_BUILD:bool REPO_URL:string PRE_MAKE:bool 

echo "\n---\nClone Repository...\n"
#Clone repository
git -C "$DOCK_SRC_DIR" pull || git clone $CACAO_REPO "$DOCK_SRC_DIR"

echo "\n---\nStart autogen...\n"
cd $DOCK_SRC_DIR
sh autogen.sh

echo "\n---\nConfigure CACAO project...\n"
mkdir /code/build
sh $DOCK_TOOL_DIR/configure_cacao.sh
