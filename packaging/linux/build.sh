#!/bin/bash

# Application name
APP_NAME="lumashot"
# Version number
VERSION=${1:-"1.0.0"}
# Architecture
ARCH="amd64"

# Create directory structure for the .deb package
mkdir -p ${APP_NAME}_${VERSION}_${ARCH}/DEBIAN
mkdir -p ${APP_NAME}_${VERSION}_${ARCH}/opt/${APP_NAME,,}
mkdir -p ${APP_NAME}_${VERSION}_${ARCH}/usr/share/applications
mkdir -p ${APP_NAME}_${VERSION}_${ARCH}/usr/share/icons/hicolor/256x256/apps

# Create the control file
cat << EOF > ${APP_NAME}_${VERSION}_${ARCH}/DEBIAN/control
Package: ${APP_NAME,,}
Version: $VERSION
Section: utils
Priority: optional
Architecture: $ARCH
Maintainer: Tam Nguyen <tamnvhustcc@gmail.com>
Description: Screen recording and editing application
 LumaShot is a desktop application for screen recording
 and video editing with features like background replacing and padding.
EOF

# Copy the entire application directory
cp -R dist/lumashot/* ${APP_NAME}_${VERSION}_${ARCH}/opt/${APP_NAME,,}/

# Create a wrapper script in /usr/bin
mkdir -p ${APP_NAME}_${VERSION}_${ARCH}/usr/bin
cat << EOF > ${APP_NAME}_${VERSION}_${ARCH}/usr/bin/${APP_NAME,,}
#!/bin/bash
/opt/${APP_NAME,,}/lumashot "\$@"
EOF
chmod +x ${APP_NAME}_${VERSION}_${ARCH}/usr/bin/${APP_NAME,,}

# Create the .desktop file
cat << EOF > ${APP_NAME}_${VERSION}_${ARCH}/usr/share/applications/${APP_NAME,,}.desktop
[Desktop Entry]
Name=$APP_NAME
Exec=/usr/bin/${APP_NAME,,}
Icon=${APP_NAME,,}
Type=Application
Categories=Utility;
EOF

# Copy the icon
cp ../../lumashot/resources/icons/lumashot.png ${APP_NAME}_${VERSION}_${ARCH}/usr/share/icons/hicolor/256x256/apps/${APP_NAME,,}.png

# Build the .deb package
dpkg-deb --build ${APP_NAME}_${VERSION}_${ARCH}

# Clean up
rm -rf ${APP_NAME}_${VERSION}_${ARCH}

echo "Debian package created: ${APP_NAME}_${VERSION}_${ARCH}.deb"