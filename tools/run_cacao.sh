#!/bin/sh

LD_LIBRARY_PATH=/code/build/src/cacao/.libs:$LD_LIBRARY_PATH $DOCK_BUILD_DIR/src/cacao/cacao -Xbootclasspath:/code/build/src/classes/classes:/usr/local/classpath/share/classpath/glibj.zip $@ 
