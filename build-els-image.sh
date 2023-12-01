#!/bin/bash

echo ""
echo "Build ELS & Updater DMG Images"
echo ""

if [ ! -d ELS/ ]; then
    echo "ELS/ directory is missing"
    exit 1
fi

if [ ! -d ELS_Updater/ ]; then
    echo "ELS_Updater/ directory is missing"
    exit 1
fi

if [ ! -f ELS/build-stamp.properties ]; then
    echo "ELS/build-stamp.properties is missing"
    exit 1
fi

# Build ELS.app & ELS_Updater.app using com.oracle.appbundler.AppBundlerTask
# https://github.com/TheInfiniteKind/appbundler
# That library must be added to the Ant lib/
ant -f els-1-app.xml

# Build the DMGs from the .apps using DMG Canvas
# https://www.araelium.com/dmgcanvas
dmgcanvas "dmgcanvas/ELS.dmgcanvas/" build/ELS-macos.dmg
dmgcanvas "dmgcanvas/ELS_Updater.dmgcanvas/" build/ELS-macos-updater.dmg

# Rename using build-stamp.properties
ant -f els-2-rename.xml
