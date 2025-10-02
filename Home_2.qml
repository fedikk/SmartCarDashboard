import QtQuick
import QtQuick3D
import QtQuick.Controls

Item {
    width: 1280
    height: 720
    property bool isLightFront: false
    property bool isLightBack: false
    property bool isLightOn: isLightBack && isLightFront
    Rectangle {
        id: settingbg
        anchors.fill: parent
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "#000" }
            GradientStop { position: 0.5; color: "#142B39" }
            GradientStop { position: 1.0; color: "#000" }
        }
    }

    // Circle inside
        Rectangle {
            id:bigcircle
            width: settingbg.height /1.7
            height: width
            radius: width / 2 // makes it a circle
            color: "#03396c"
            anchors.centerIn: parent
            z:3
        }

        Rectangle {
            id:littlecircle
            width: settingbg.height /2
            height: width
            radius: width / 2 // makes it a circle
            color: "#005b96"
            anchors.centerIn: parent
            z:4
        }

        //Car Image
        Rectangle {
            id:imgcar
            width: 350
            height: 500
            color: "transparent"
            anchors.centerIn: parent
            z: 5
            Image {
                id: carimage
                anchors.fill: parent
                source: {
                        if (isLightBack && isLightFront)
                            return "file:///C:/Users/fedikk/Documents/Cockpit/images/Park/car2lightall.png";
                        else if (isLightBack)
                            return "file:///C:/Users/fedikk/Documents/Cockpit/images/Park/car2lightback.png";
                        else if (isLightFront)
                            return "file:///C:/Users/fedikk/Documents/Cockpit/images/Park/car2lightfront.png";
                        else
                            return "file:///C:/Users/fedikk/Documents/Cockpit/images/Park/car2.png";
                    }
                fillMode: Image.PreserveAspectfit
                smooth: true
            }
        }

        //Interior Light Buttons

            Rectangle {
                id: myButton
                width: 150
                height: 40
                radius: 20
                color: "#3498db"
                anchors.left:parent.left

                Text {
                    anchors.centerIn: parent
                    text: " Front Light"
                    color: "white"
                    font.bold: true
                    font.pointSize: 14
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Button front clicked!")
                        console.log(isLightFront)
                        isLightFront=!isLightFront
                    }
                    hoverEnabled: true
                    onEntered: myButton.color = "#2980b9" // darker when hovered
                    onExited: myButton.color = "#3498db"
                }
            }

            Rectangle {
                id: backlightbtn
                width: 150
                height: 40
                radius: 20
                color: "#3498db"
                anchors.left:parent.left
                anchors.top: parent.top
                anchors.topMargin: 100

                Text {
                    anchors.centerIn: parent
                    text: " back Light"
                    color: "white"
                    font.bold: true
                    font.pointSize: 14
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Button clicked!")
                        console.log(isLightOn)
                        isLightBack=!isLightBack
                    }
                    hoverEnabled: true
                    onEntered: backlightbtn.color = "#2980b9" // darker when hovered
                    onExited: backlightbtn.color = "#3498db"
                }
            }

            Rectangle {
                id: alllightbtn
                width: 150
                height: 40
                radius: 20
                color: "#3498db"
                anchors.left:parent.left
                anchors.top: parent.top
                anchors.topMargin: 170

                Text {
                    anchors.centerIn: parent
                    text: " All Light"
                    color: "white"
                    font.bold: true
                    font.pointSize: 14
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Button clicked!")
                        console.log(isLightOn)
                        if (!isLightBack && !isLightFront ){
                            isLightBack=true
                            isLightFront= true
                        }else if (isLightBack && isLightFront ) {
                            isLightBack=false
                            isLightFront= false
                        }else {
                            isLightBack=true
                            isLightFront= true
                        }


                    }
                    hoverEnabled: true
                    onEntered: alllightbtn.color = "#2980b9" // darker when hovered
                    onExited: alllightbtn.color = "#3498db"
                }
            }
}
