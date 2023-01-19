#!/bin/sh

echo "\n---\nClone Repository...\n"
#Clone repository
git -C "$DOCK_SRC_DIR" pull || git clone $CACAO_REPO "$DOCK_SRC_DIR"

# start cacaos autogen
echo "\n---\nStart autogen...\n"
sh $DOCK_TOOL_DIR/cacao_autogen.sh

echo "\n---\nConfigure CACAO project...\n"
mkdir /code/build
sh $DOCK_TOOL_DIR/configure_cacao.sh
