#!/usr/bin/env bash
set -e
#*******************************************************************************
# run-dev.sh
# ----------
# A script to run the DEVELOPMENT version of gPodder+ with development source
# code and a test database.
#*******************************************************************************

# Set the gPodder+ and gpodder locations for this script.
# Note: This script should be running from the gPodder+ folder.
GPODDER_PLUS_DIR="/d/SWDevRepos/GitHub/rlampere/gPodder+"
GPODDER_DIR="$GPODDER_PLUS_DIR/gpodder"

# Set MSYS paths for script execution.
MYGPOCLIENT_MSYS="$GPODDER_PLUS_DIR/mygpoclient"
PODCASTPARSER_MSYS="$GPODDER_PLUS_DIR/podcastparser"
FAKE_DBUS_MSYS="$GPODDER_DIR/tools/fake-dbus-module"

# Set MSYS paths for the test database and downloads locations.
GPODDER_HOME_MSYS="$GPODDER_PLUS_DIR/gpodder-home-test"
GPODDER_DOWNLOAD_DIR_MSYS="$GPODDER_PLUS_DIR/gpodder-downloads-test"

# Export the definitions for the test databaes and downloads locations by
# converting MSYS to Windows-style paths for Python.
export GPODDER_HOME="$(cygpath -m "$GPODDER_HOME_MSYS")"
echo "GPODDER_HOME=$GPODDER_HOME"
export GPODDER_DOWNLOAD_DIR="$(cygpath -m "$GPODDER_DOWNLOAD_DIR_MSYS")"
echo "GPODDER_DOWNLOAD_DIR=$GPODDER_DOWNLOAD_DIR"

# Set local source paths for use by Windows by converting the
# MSYS definitions to mixed Linux/Windows-style paths for Python.
MYGPOCLIENT_WIN="$(cygpath -m "$MYGPOCLIENT_MSYS")"
PODCASTPARSER_WIN="$(cygpath -m "$PODCASTPARSER_MSYS")"
FAKE_DBUS_WIN="$(cygpath -m "$FAKE_DBUS_MSYS")"

# Set the Python path based on whether PYTHONPATH is already defined or not.
if [ -n "${PYTHONPATH:-}" ]; then
    export PYTHONPATH="$MYGPOCLIENT_WIN;$PODCASTPARSER_WIN;$FAKE_DBUS_WIN;$PYTHONPATH"
else
    export PYTHONPATH="$MYGPOCLIENT_WIN;$PODCASTPARSER_WIN;$FAKE_DBUS_WIN"
fi

# If in debug mode, output all values defined above for verification.
debug=false
if $debug; then
    echo "GPODDER_PLUS_DIR=$GPODDER_PLUS_DIR"
    echo "GPODDER_DIR=$GPODDER_DIR"
    echo "MSYS Paths..."
    echo "  GPODDER_HOME_MSYS=$GPODDER_HOME_MSYS"
    echo "  GPODDER_DOWNLOAD_DIR_MSYS=$GPODDER_DOWNLOAD_DIR_MSYS"
    echo "  MYGPOCLIENT_MSYS=$MYGPOCLIENT_MSYS"
    echo "  PODCASTPARSER_MSYS=$PODCASTPARSER_MSYS"
    echo "  FAKE_DBUS_MSYS=$FAKE_DBUS_MSYS"
    echo "Local source paths..."
    echo "  MYGPOCLIENT_WIN=$MYGPOCLIENT_WIN"
    echo "  PODCASTPARSER_WIN=$PODCASTPARSER_WIN"
    echo "  FAKE_DBUS_WIN=$FAKE_DBUS_WIN"
    echo "PYTHONPATH=$PYTHONPATH"
fi

# Go to the gPodder root directory and start the gPodder application.
cd "$GPODDER_DIR"
pwd
#exec python ./bin/gpodder+ "$@" >> "$GPODDER_PLUS_DIR/gpodder-dev.log" 2>&1
exec python ./bin/gpodder+ "$@"