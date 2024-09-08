#!/bin/bash

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Define the location where QT will be installed
INSTALL_PATH=/opt/Qt

# Install the required Libraries for MuseScore 4.4 and above
if [ -f $INSTALL_PATH/MaintenanceTool ]; then
    $INSTALL_PATH/MaintenanceTool \
        --root $INSTALL_PATH \
        --accept-licenses \
        --accept-obligations \
        --auto-answer OverwriteTargetDirectory=Yes,telemetry-question=No \
        --accept-messages \
        --confirm-command \
        install \
        qt.qt6.624.addons.qtnetworkauth \
        qt.qt6.624.addons.qtnetworkauth.gcc_64 \
        qt.qt6.624.addons.qtscxml \
        qt.qt6.624.addons.qtscxml.gcc_64 \
        qt.qt6.624.doc.qt5compat \
        qt.qt6.624.doc.qtnetworkauth \
        qt.qt6.624.doc.qtscxml \
        qt.qt6.624.gcc_64 \
        qt.qt6.624.qt5compat \
        qt.qt6.624.qt5compat.gcc_64 \
        qt.tools.cmake \
        qt.tools.maintenance \
        qt.tools.ninja \
        qt.tools.qtcreator \
        qt.tools.qtcreator_gui
fi
