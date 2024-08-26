import QtQuick
import QtQuick.Window 2.15
import QtQuick.Controls.Material 2.15

Window {
    id: mainWindow
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    visible: true
    color: "transparent"

    Component.onCompleted: {
        windowController.get_window_position()
        lumashot.source = ""
        lumashot.source = "qrc:/qml/entry/LumaShot.qml"
        mainWindow.hide()
    }

    Loader { id: lumashot }
}