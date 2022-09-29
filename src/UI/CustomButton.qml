import QtQuick
import QtQuick.Controls

Button {
    id: ctrl

    property color bg_color: "green"
    property color txt_color: "white"

    background: Rectangle {
        color: ctrl.pressed ? Qt.lighter(bg_color, 1.25) : bg_color
        radius: 15
    }

    contentItem: Text {
        anchors.fill: parent
        font.pixelSize: 14
        wrapMode: Text.WordWrap
        text: ctrl.text
        padding: ctrl.padding
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: txt_color
    }
}