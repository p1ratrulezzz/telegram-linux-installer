#!/bin/bash

echo "============================================="
echo "==     Telegram Script Installer v 0.1     =="
echo "==                                         =="
echo "==            by Jalcaldea                 =="
echo "============================================="

echo "Downloading necesary files..."

cd /tmp

LINK64="https://github.com/telegramdesktop/tdesktop/releases/download/v1.9.3/tsetup.1.9.3.tar.xz"
LINK32="https://github.com/telegramdesktop/tdesktop/releases/download/v1.9.3/tsetup32.1.9.3.tar.xz"

LINK=$LINK32

if [ $(uname -p) == "x86_64" ]; then
  LINK=$LINK64
fi

wget -O - $LINK > tsetup.tar.gz
wget -O - https://raw.githubusercontent.com/telegramdesktop/tdesktop/master/Telegram/Telegram/Images.xcassets/Icon.iconset/icon_256x256@2x.png > icon.png

echo "Making destination folder..."

sudo mkdir /opt/telegram
sudo chmod +x /opt/telegram

echo "Extracting files..."

tar -xvJf tsetup.tar.gz
cd ./Telegram

echo "Copying new files..."
sudo cp ./Updater /opt/telegram/
sudo cp ./Telegram /opt/telegram/

sudo chmod -R +x /opt/telegram/


echo "Making desktop files..."

cd /tmp

sudo echo "[Desktop Entry]" > telegram.desktop
sudo echo "Name=Telegram Desktop" >> telegram.desktop
sudo echo "GenericName=Chat" >> telegram.desktop
sudo echo "Comment=Official desktop application for the Telegram messaging service" >> telegram.desktop
sudo echo "Exec=/opt/telegram/Updater -- %u" >> telegram.desktop
sudo echo "Terminal=false" >> telegram.desktop
sudo echo "Type=Application" >> telegram.desktop
sudo echo "Icon=/opt/telegram/icon.png" >> telegram.desktop
sudo echo "Categories=Network;Chat;" >> telegram.desktop
sudo echo "StartupNotify=false" >> telegram.desktop

sudo cp icon.png /opt/telegram/icon.png
sudo cp telegram.desktop /usr/share/applications/telegram.desktop

echo "Removing old files..."

rm /tmp/tsetup.tar.gz
rm /tmp/icon.png
rm /tmp/telegram.desktop
rm -R /tmp/Telegram


echo "Installation Complete! Launching Telegram..."

/opt/telegram/Updater &
