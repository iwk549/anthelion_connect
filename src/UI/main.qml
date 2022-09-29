import QtQuick
import QtQuick.Controls.Basic

ApplicationWindow {
    visible: true
    width: 750
    height: 500
    x: 25
    y: 50
    title: "Anthelion Connect"

    flags: Qt.FramelessWindowHint | Qt.Window

    property QtObject backend
    property string zuluTime
    property string localTime
    
    Rectangle { 
        anchors.fill: parent

        Image {
            sourceSize.width: parent.width
            sourceSize.height: parent.height
            source: "./images/mainBg.jpg"
            fillMode: Image.PreserveAspectCrop 
        }

        Rectangle {
            id: header
            anchors.left: parent.left
            anchors.right: parent.right
            height: 50
            color: "transparent"

            Text {
                text: zuluTime
                font.pixelSize: 14
                anchors.left: parent.left
                anchors.leftMargin: 20
            }

            Text {
                anchors.right: parent.right
                anchors.rightMargin: 20
                text: localTime
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHEnd
            }
            
            Text {
                anchors.fill: parent
                text: "Anthelion Helicopters"
                font.pixelSize: 30
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Rectangle {
            id: buttons
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: header.bottom
            anchors.topMargin: 20

            CustomButton {
                text: "Download from Fare Harbor"
                bg_color: "blue"
                anchors.left: parent.left
                anchors.leftMargin: 35
                onClicked: backend.openDialog()
            }
            CustomButton {
                text: "Download from Flight Schedule Pro"
                bg_color: "green"
                anchors.right: parent.right
                anchors.rightMargin: 35
            }

        }
        CustomButton {
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            height: 25
            bg_color: "red"
            text: "Exit"
            onClicked: backend.exit_app()
        }
    }

    Connections {
        target: backend

        function onZuluTime(msg) {
            zuluTime = msg
        }
        function onLocalTime(msg) {
            localTime = msg
        }
    }
}