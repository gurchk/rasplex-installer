#-------------------------------------------------
#
# Project created by QtCreator 2013-03-14T18:13:26
#
#-------------------------------------------------

QT       += core gui xml network

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = rasplex-installer
TEMPLATE = app

SOURCES += main.cpp\
    installer.cpp \
    confighandler.cpp \
    downloadmanager.cpp \
    diskwriter.cpp \
    simplejsonparser.cpp


static { # everything below takes effect with CONFIG += static
    LIBS += -L$$PWD/3rd-party
    CONFIG += static
    CONFIG += staticlib # this is needed if you create a static library, not a static executable
    DEFINES += STATIC
    message("~~~ static build ~~~") # this is for information, that the static build is done
}

HEADERS  += installer.h \
    diskwriter.h \
    zlib.h \
    zconf.h \
    confighandler.h \
    downloadmanager.h \
    deviceenumerator.h \
    simplejsonparser.h


win32 {
    SOURCES += diskwriter_windows.cpp \
        confighandler_windows.cpp \
        deviceenumerator_windows.cpp
    HEADERS += diskwriter_windows.h \
        confighandler_windows.h \
        deviceenumerator_windows.h
    CONFIG += rtti
    QMAKE_LFLAGS  = -static -static-libgcc
    RC_FILE = rasplex-installer.rc
}
unix {
    # remove possible other optimization flags
    QMAKE_CFLAGS_RELEASE -= -O
    QMAKE_CFLAGS_RELEASE -= -O1
    QMAKE_CFLAGS_RELEASE -= -O2
    QMAKE_CFLAGS_RELEASE -= -O3
    # Optimize for size
    QMAKE_CFLAGS_RELEASE += -Os

    QMAKE_CXXFLAGS += -fPIC
    SOURCES += diskwriter_unix.cpp \
        confighandler_unix.cpp \
        deviceenumerator_unix.cpp
    HEADERS += diskwriter_unix.h \
        confighandler_unix.h \
        deviceenumerator_unix.h

}

linux* {
    LIBS += -lblkid
}

FORMS    += installer.ui

LIBS += -lz

lessThan(QT_MAJOR_VERSION, 5): LIBS += -lqjson

OTHER_FILES +=

RESOURCES += \
    resources.qrc
