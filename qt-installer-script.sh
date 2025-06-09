#!/bin/bash

# Slackware script for installing Qt libraries

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

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

QT_PATH=/opt/Qt
INSTALLER=qt-online-installer-linux-x64-4.10.0.run
WGETFOLDER=4.10

# Check if online installer is available, download it if not
if ! [ -f $INSTALLER ]; then
    wget https://download.qt.io/archive/online_installers/$WGETFOLDER/$INSTALLER
    chmod +x $INSTALLER
fi

# This will install a basic set of tools.
# You will need to run afterwards an install script for your specific set of libraries to be added Or
# you can run this script to manually configure Qt (an Icon is also installed in your desktop menu)
./$INSTALLER \
    --root $QT_PATH \
    --accept-licenses \
    --accept-obligations \
    --accept-messages \
    --auto-answer OverwriteTargetDirectory=Yes,telemetry-question=No \
    --confirm-command \
    install \
    qt.tools.cmake \
    qt.tools.maintenance \
    qt.tools.ninja \
    qt.tools.qtcreator \
    qt.tools.qtcreator_gui

# make sure gksu is used when calling the /opt/Qt/MaintenanceTool
sed -i -e "s:Exec=/opt/Qt/MaintenanceTool:Exec=gksu /opt/Qt/MaintenanceTool:" /usr/local/share/applications/Qt-MaintenanceTool.desktop

