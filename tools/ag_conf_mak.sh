#!/bin/sh

# Runs autogen, configure and make. All arguments are passed to the configure step.

set -e

$DOCK_TOOL_DIR/cacao_autogen.sh
$DOCK_TOOL_DIR/configure_cacao.sh $@
$DOCK_TOOL_DIR/cacao_autogen.sh

