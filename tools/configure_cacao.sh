#!/bin/sh

set -e

echo "Configure Cacao into $DOCK_BUILD_DIR"
cd $DOCK_BUILD_DIR
$DOCK_SRC_DIR/configure $@ --enable-unijit --enable-debug --enable-logging \
      --with-java-runtime-library=gnuclasspath \
      --with-java-runtime-library-prefix=/usr/local/classpath \
      --with-junit-jar=/usr/share/java/junit4.jar:/usr/share/java/hamcrest.jar

