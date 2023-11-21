#!/bin/bash

echo ""
echo "Build ELS DMG Image"
echo ""

if [ ! -d ELS/ ]; then
    echo "ELS/ directory is missing"
    exit 1
fi

if [ ! -f ELS/build-stamp.properties ]; then
    echo "ELS/build-stamp.properties is missing"
    exit 1
fi

# Build ELS.app using com.oracle.appbundler.AppBundlerTask
# https://github.com/TheInfiniteKind/appbundler
# That library must be added to the Ant lib/
ant -f els-app.xml

# Build the DMG from the .app using DMG Canvas
# https://www.araelium.com/dmgcanvas
dmgcanvas "Entertainment Library Synchronizer.dmgcanvas/" ELS.dmg

