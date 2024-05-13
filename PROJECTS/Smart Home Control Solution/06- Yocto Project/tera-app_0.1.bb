SUMMARY = "Qt informative app"
DESCRIPTION = "A simple Qt application that display information about car"
LICENSE = "MIT"

# The LIC_FILES_CHKSUM is the checksum of the license file that is included in the source code
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI:append = " \
    file://main.cpp \
    file://door.h \
    file://main.qml \
    file://main_no_permissions.qml \
    file://qmldir \
    file://MediaList.qml \
    file://AudioInputSelect.qml \
    file://VideoSourceSelect.qml \
    file://RecordButton.qml \
    file://Controls.qml \
    file://StyleParameter.qml \
    file://StyleRectangle.qml \
    file://SettingsMetaData.qml \
    file://SettingsEncoder.qml \
    file://StyleSlider.qml \
    file://Style.qml \
    file://Playback.qml \
    file://CMakeLists.txt \
    file://CMakeLists.txt.user.9604e61 \
    file://CMakeLists.txt.user.da0cb49 \
    file://Info.plist.in \
    file://name.txt \
    file://WeatherDisplay.qml \
"

 
S = "${WORKDIR}"

FILES:${PN} = " \
     /opt/tera_APP/bin/tera_APP \
     /usr/bin/tera_APP \    
    "

DEPENDS += " qtbase"

do_install:append () {
    install -d ${D}${bindir}
    install -m 0755 tera_APP ${D}${bindir}/
}

inherit qt6-cmake