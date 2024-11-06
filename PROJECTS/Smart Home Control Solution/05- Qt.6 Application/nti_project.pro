QT += quick virtualkeyboard


SOURCES += \
        WiFiModel.cpp \
        custommqttcallback.cpp \
        main.cpp \
        mqttclient.cpp

resources.files = main.qml


resources.prefix = /$${TARGET}
RESOURCES += resources \
        resources.qrc
# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    WiFiModel.h \
    customMqttCallback.h \
    mqttclient.h \
    paths.h



# Paho MQTT library paths
LIBS += -L/usr/local/lib -lpaho-mqttpp3 -lpaho-mqtt3c
INCLUDEPATH += /usr/local/include



