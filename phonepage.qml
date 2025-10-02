import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    width: parent.width
    height: parent.height
    property var keys: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "12", "11"]

    /*********************************************************************************/
    /**************************Get Contqct name for calling page *********************/
    /*********************************************************************************/
    function getContactNameByNumber(phone) {
        for (let i = 0; i < contactModel.count; i++) {
            if (contactModel.get(i).number.replace(/\s/g, "") === phone.replace(/\s/g, "")) {
                return contactModel.get(i).name;
            }
        }
        return "Unknown";
    }

    Rectangle {
        anchors.fill: parent
        z: -1
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "#000" }
            GradientStop { position: 0.5; color: "#142B39" }
            GradientStop { position: 1.0; color: "#000" }
        }
    }
    CallingPage{
        id:callingScreen
    }

    Rectangle {
        anchors.right: parent.right
        anchors.top:  parent.top
        anchors.rightMargin: 300
        anchors.topMargin: 50
        width: 300
        height:30
        color:"transparent"

        Text {
            text: "CONTACT"
            color: "white"
            font.pixelSize: 24
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 20
        anchors.margins: 20

        // ☎️ DIAL PAD SECTION
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.5
            Layout.preferredHeight: parent.height * 0.92
            anchors.top: parent.top
            anchors.topMargin: -10
            radius: 20
            color: "transparent"

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 20

                // Input field
                TextField {
                    id: dialInput
                    width: 400
                    height: 60  // increased height for bigger font
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true
                    placeholderText: "|"

                    font.pixelSize: 28
                    color: "white"
                    background: null
                    padding: 0

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                // Dial pad
                ColumnLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 4

                    GridLayout {
                        columns: 3 // 3 buttons per row
                        rowSpacing: 20
                        columnSpacing: 40

                        Repeater {
                            model: keys.length
                            delegate: Rectangle {
                                width: 100
                                height: 100
                                radius: 50
                                color: "transparent"

                                property string keyText: keys[index]

                                Image {
                                    anchors.centerIn: parent
                                    source: "images/phone/" + keyText + ".png"
                                    width: 95
                                    height: 95
                                    fillMode: Image.PreserveAspectFit
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        if (keys[index] === "10") {
                                            dialInput.text += "*"
                                        } else if (keys[index] === "11") {
                                            dialInput.text += "#"
                                        } else if (keys[index] === "12") {
                                            dialInput.text += "0"
                                        } else {
                                            dialInput.text += keyText
                                            console.log("Clicked:", keyText)
                                        }
                                    }
                                    cursorShape: Qt.PointingHandCursor
                                }
                            }
                        }
                    }
                }

                // Call / Clear / Backspace Buttons
                GridLayout {
                    width:parent.width
                    columns: 3
                    columnSpacing: 60
                    Layout.alignment: Qt.AlignHCenter

                    // 🧹 Clear
                    ColumnLayout {
                        Layout.alignment: Qt.AlignHCenter
                        spacing: 5

                        Item {
                            width: 80
                            height: 80

                            Image {
                                id: clearImage
                                source: "images/phone/clear.png"
                                width: 64
                                height: 64
                                anchors.centerIn: parent
                                fillMode: Image.PreserveAspectFit
                                ToolTip.text: "Clear input"
                                ToolTip.visible: clearImage.containsMouse
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    dialInput.text = ""
                                }
                            }
                        }

                        Text {
                            text: "Clear"
                            color: "white"
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }


                    // 📞 Call
                    ColumnLayout {
                        Layout.alignment: Qt.AlignHCenter
                        spacing: 5

                        Item {
                            width: 80
                            height: 80

                            Image {
                                id: callImage
                                source: "images/phone/phone-call.png"
                                width: 64
                                height: 64
                                anchors.centerIn: parent
                                fillMode: Image.PreserveAspectFit
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onPressed: parent.scale = 0.85
                                onReleased: {
                                    parent.scale = 1.0
                                    callingScreen.visible = false
                                }
                                onCanceled: parent.scale = 1.0
                                onClicked: {
                                    if (dialInput.text.length >= 8) {
                                        console.log("calling "+ dialInput.text)
                                        let name = getContactNameByNumber(dialInput.text);
                                        callingScreen.phoneNumber = dialInput.text;
                                        callingScreen.contactName = name;
                                        callingScreen.visible = true;
                                        callingScreen.z = 2
                                    } else {
                                        console.log("Number too short to call.")
                                    }
                                }

                            }
                        }

                        Text {
                            text: "Call"
                            color: "white"
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }



                    // ⌫ Backspace
                    ColumnLayout {
                        Layout.alignment: Qt.AlignHCenter
                        spacing: 5

                        Item {
                            width: 80
                            height: 80

                            Image {
                                id: backspaceImage
                                source: "images/phone/delete.png"
                                width: 64
                                height: 64
                                anchors.centerIn: parent
                                fillMode: Image.PreserveAspectFit
                                ToolTip.text: "Delete last digit"
                                ToolTip.visible: backspaceImage.containsMouse
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onPressed: parent.scale = 0.85
                                onReleased: {
                                    parent.scale = 1.0
                                    callingScreen.visible = false
                                }
                                onCanceled: parent.scale = 1.0
                                onClicked: {
                                    dialInput.text = dialInput.text.slice(0, -1)
                                }
                            }
                        }

                        Text {
                            text: "Delete"
                            color: "white"
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }



            }
        }



        /********************************************************************************************************/
        /*****************************************📇 CONTACTS SECTION********************************************/
        /********************************************************************************************************/


        Rectangle {
            width: parent.width / 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin:-70
            Layout.preferredWidth: parent.width * 0.5
            color: "#0F1C22"
            radius: 40
            height: contactList.contentHeight + 100

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop {
                    position: 0.0
                    color: "#000"
                } // Soft blue
                GradientStop {
                    position: 1.0
                    color: "#162937"
                } // Dark blue
            }
            border.color: "#000c1f"
            border.width:1
            opacity: 0.8

            ListView {
                id: contactList
                anchors.fill: parent
                anchors.margins: 20
                spacing: 5

                model: ListModel {
                    id: contactModel
                    ListElement { name: "GHADA "; number: " 98 548 254" }
                    ListElement { name: "BAHA  ";  number: " 52 244 556" }
                    ListElement { name: "EMNA  ";  number: " 21 211 262" }
                    ListElement { name: "SAMIR "; number: "  97 548 854" }
                    ListElement { name: "ALI   ";  number: " 59 245 656" }
                    ListElement { name: "SALMEN";  number: " 20 251 262" }
                    ListElement { name: "AMINE ";  number: " 41 784 001" }

                }


                delegate: Rectangle {
                    width: parent.width
                    height: 70
                    color: "transparent"

                    Row {
                        anchors.fill: parent
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 5

                        Rectangle {
                            height: 1
                            width: 10
                            color: "transparent"
                        }

                        Image {
                            source: "images/usericon.png"
                            width: 40
                            height: 40
                            anchors.verticalCenter: parent.verticalCenter
                            fillMode: Image.PreserveAspectFit
                        }
                        Rectangle {
                            height: 1
                            width: 10
                            color: "transparent"
                        }
                        Text {
                            text: name
                            anchors.verticalCenter: parent.verticalCenter
                            color: "white"
                            font.pixelSize: 20
                            width: 150
                            elide: Text.ElideRight
                        }

                        Rectangle {
                            height: 1
                            width: 150
                            color: "transparent"
                        }

                        Text {
                            text: number
                            color: "white"
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 18
                            horizontalAlignment: Text.AlignRight
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: dialInput.text = number
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }




    }
}
