#!/bin/bash

# Slackware script for installing Qt libraries

# Copyright 2024 Antonio Leal, Porto Salvo, Oeiras, Portugal
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

INSTALL_PATH=/opt/Qt
INSTALLER=qt-online-installer-linux-x64-4.8.0.run
SCRIPT=qt-installer-script.sh

mkdir -p $INSTALL_PATH

# Make shure this script exists at /opt/Qt
if ! [ -f $INSTALL_PATH/$SCRIPT ]; then
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
    cd $SCRIPT_DIR
    cp $SCRIPT $INSTALL_PATH
fi

cd $INSTALL_PATH

# Check if online installer is available, download it if not
if ! [ -f $INSTALL_PATH/$INSTALLER ]; then
    wget https://download.qt.io/archive/online_installers/4.8/$INSTALLER
    chmod +x $INSTALLER
fi

# If already installed then run the MaintenanceTool, otherwise install a basic set of tools.
# You will need to run afterwards an install script for your specific set of libraries to be added Or
# you can run this script to manually configure Qt (an Icon is also installed in your desktop menu)
if [ -f $INSTALL_PATH/MaintenanceTool ]; then
    $INSTALL_PATH/MaintenanceTool
else
    $INSTALL_PATH/$INSTALLER \
        --root $INSTALL_PATH \
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

    sed -i -e "s:Exec=/opt/Qt/MaintenanceTool:Exec=gksu /opt/Qt/qt-installer-script.sh:" /usr/local/share/applications/Qt-MaintenanceTool.desktop
fi

