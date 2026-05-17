QT += quick

CONFIG += c++17

TARGET = JigsawPuzzle
TEMPLATE = app

SOURCES += \
    src/main.cpp

RESOURCES += qml/qml.qrc

QML_IMPORT_PATH += $$PWD/qml

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
