import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: callingScreen
    anchors.fill: parent
    visible: false
    z: 2

    property bool ismuted: false
    property string contactName: "Calling..."
    property string phoneNumber: ""

    gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop { position: 0.0; color: "#000" }
        GradientStop { position: 0.5; color: "#142B39" }
        GradientStop { position: 1.0; color: "#000" }
    }

    Column {
        anchors.centerIn: parent
        spacing: 20

        Image {
            source: "images/usericon.png"
            width: 120
            height: 120
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: contactName !== "" ? contactName : "Calling..."
            font.pixelSize: 24
            color: "white"
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: phoneNumber
            font.pixelSize: 18
            color: "lightgray"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: calling
            text: "Calling ..."
            font.pixelSize: 18
            color: "lightgray"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }





    /*******************************************************************************************/
    /********************************* PHONE COntrol Panel *************************************/
    /*******************************************************************************************/

    Row {
        spacing: 40
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 60

        // Hold Button
        Item {
            width: 64
            height: 64
            scale: 1.0

            Image {
                anchors.fill: parent
                source: "images/phone/hold.png"
                fillMode: Image.PreserveAspectFit
            }

            MouseArea {
                anchors.fill: parent
                onPressed: parent.scale = 0.85
                onReleased: parent.scale = 1.0
                onCanceled: parent.scale = 1.0
                cursorShape: Qt.PointingHandCursor
            }
        }

        // Mic Button
        Item {
            width: 64
            height: 64
            scale: 1.0

            Image {
                anchors.fill: parent
                source: ismuted?"images/phone/microphoneoff.png":"images/phone/microphone.png"
                fillMode: Image.PreserveAspectFit
            }

            MouseArea {
                anchors.fill: parent
                onPressed: parent.scale = 0.85
                onReleased: parent.scale = 1.0
                onCanceled: parent.scale = 1.0
                cursorShape: Qt.PointingHandCursor
                onClicked: ismuted = !ismuted
            }
        }

        // Speaker Button
        Item {
            width: 64
            height: 64
            scale: 1.0

            Image {
                anchors.fill: parent
                source: "images/phone/speaker.png"
                fillMode: Image.PreserveAspectFit
            }

            MouseArea {
                anchors.fill: parent
                onPressed: parent.scale = 0.85
                onReleased: parent.scale = 1.0
                onCanceled: parent.scale = 1.0
                cursorShape: Qt.PointingHandCursor
            }
        }

        // Keypad Button
        Item {
            width: 64
            height: 64
            scale: 1.0

            Image {
                anchors.fill: parent
                source: "images/phone/label_keypad.png"
                fillMode: Image.PreserveAspectFit
            }

            MouseArea {
                anchors.fill: parent
                onPressed: parent.scale = 0.85
                onReleased: parent.scale = 1.0
                onCanceled: parent.scale = 1.0
                cursorShape: Qt.PointingHandCursor
            }
        }


        // Bluetooth Button
        Item {
            width: 64
            height: 64
            scale: 1.0

            Image {
                anchors.fill: parent
                source: "images/phone/bluetooth.png"
                fillMode: Image.PreserveAspectFit
            }

            MouseArea {
                anchors.fill: parent
                onPressed: parent.scale = 0.85
                onReleased: parent.scale = 1.0
                onCanceled: parent.scale = 1.0
                cursorShape: Qt.PointingHandCursor
            }
        }


        // End Call Button
        Item {
            width: 64
            height: 64
            scale: 1.0

            Image {
                anchors.fill: parent
                source: "images/phone/calloff.png"
                fillMode: Image.PreserveAspectFit
            }

            MouseArea {
                anchors.fill: parent
                onPressed: parent.scale = 0.85
                onReleased: {
                    parent.scale = 1.0
                    callingScreen.visible = false
                }
                onCanceled: parent.scale = 1.0
                cursorShape: Qt.PointingHandCursor
            }
        }
    }
}
