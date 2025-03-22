#!/bin/bash

# Slackware script for installing Qt 6.2.4 libraries required by MuseScore

# Copyright 2024-2025 Antonio Leal, Porto Salvo, Oeiras, Portugal
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Define the location where QT will be installed
QT_PATH=/opt/Qt

# Install the required Libraries for MuseScore 4.4 and above
if [ -f $QT_PATH/MaintenanceTool ]; then
    $QT_PATH/MaintenanceTool \
        --root $QT_PATH \
        --accept-licenses \
        --accept-obligations \
        --accept-messages \
        --auto-answer OverwriteTargetDirectory=Yes,telemetry-question=No \
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
else
    echo "Could not find Qt's MaintenanceTool at $QT_PATH, please run the qt-installer-script.sh before this script. "
fi
