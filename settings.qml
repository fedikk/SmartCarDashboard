import QtQuick
import QtQuick3D
import QtQuick.Controls

Item {
    width: parent.width
    height: parent.height
    property bool isLightFront: false
    property bool isLightBack: false
    property bool isLightOn: isLightBack && isLightFront
    property bool isSeat0: false
    property bool isSeat1: false
    property bool isSeat2: false
    property bool isSeat3: false
    property bool isFrontdef: false
    property bool isBackdef: false
    property bool isFresh: false
    property bool isRecir: false
    // Background
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

    Rectangle{
        id: title
        width:300
        height: 100
        color:"transparent"
        anchors.right: parent.right
        anchors.rightMargin: 190
        anchors.bottom: parent.bottom

        Text {
            anchors.centerIn: parent
            text: "CAR CONTROLLER"
            color: "#fff"
            style: Text.Outline
            styleColor: "#2ea3dd"
            font.bold: true
            font.pointSize: 25
        }
    }

    // Big circle
    Rectangle {
        id: bigcircle
        width: settingbg.height / 1.7
        height: width
        radius: width / 2
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "#000" }
            GradientStop { position: 0.5; color: "#2ea3dd" }
            GradientStop { position: 1.0; color: "#000" }
        }
        anchors.right: parent.right
        anchors.rightMargin: 150
        anchors.top:parent.top
        anchors.topMargin: 140
        z: 3
    }

    // Little circle
    Rectangle {
        id: littlecircle
        width: settingbg.height / 2
        height: width
        radius: width / 2
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "#fff" }
            GradientStop { position: 0.5; color: "#142B39" }
            GradientStop { position: 1.0; color: "#fff" }
        }
        anchors.centerIn: bigcircle
        z: 4
    }

    // Car Image
    Rectangle {
        id: imgcar
        width: 650
        height: 500
        color: "transparent"
        anchors.centerIn: bigcircle
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
            fillMode: Image.PreserveAspectFit
            smooth: true
        }
    }




    /**********************************************************************************************************/
    /************************************* Interiror Light Control ********************************************/
    /**********************************************************************************************************/
    // Controls Column
    Column {
        id: lightsection
        spacing: 20
        width: parent.width / 3
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 50

        // Title
        Text {
            text: "Interior Light Control"
            font.pointSize: 14
            color: "#fff"
            font.bold: true
            horizontalAlignment: Text.AlignLeft
        }

        // First row of buttons
        Row {
            spacing: 20
            width: parent.width
            height: 40

            Rectangle {
                id: myButton
                width: 150
                height: 40
                radius: 20
                color: !isLightFront ? "transparent" : "#2980b9"
                border.width: 2
                border.color: "#2980b9"

                Text {
                    anchors.centerIn: parent
                    text: "Front Light"
                    color: "white"
                    font.bold: true
                    font.pointSize: 14
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: isLightFront = !isLightFront
                    hoverEnabled: true
                }
            }

            Rectangle {
                id: backlightbtn
                width: 150
                height: 40
                radius: 20
                color: !isLightBack ? "transparent" : "#2980b9"
                border.width: 2
                border.color: "#2980b9"

                Text {
                    anchors.centerIn: parent
                    text: "Back Light"
                    color: "white"
                    font.bold: true
                    font.pointSize: 14
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: isLightBack = !isLightBack
                    hoverEnabled: true
                }
            }

            //All lights button
            Rectangle {
                id: alllightbtn
                width: 150
                height: 40
                radius: 20
                color: (isLightBack && isLightFront) ? "#2980b9" : "transparent"
                border.width: 2
                border.color: "#2980b9"

                Text {
                    anchors.centerIn: parent
                    text: "All Light"
                    color: "white"
                    font.bold: true
                    font.pointSize: 14
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (!isLightBack && !isLightFront) {
                            isLightBack = true
                            isLightFront = true
                        } else if (isLightBack && isLightFront) {
                            isLightBack = false
                            isLightFront = false
                        } else {
                            isLightBack = true
                            isLightFront = true
                        }
                    }
                    hoverEnabled: true
                }
            }
        }

    }


    /********************************************************************************************************/
    /************************************ Fan Speed *********************************************************/
    /********************************************************************************************************/
    Column {
        id:fansection
        spacing: 20
        width: parent.width / 3
        anchors.top: lightsection.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 50

        // Title
        Text {
            text: "Fan Speed"
            font.pointSize: 14
            color: "#fff"
            font.bold: true
            horizontalAlignment: Text.AlignLeft
        }


        Slider
        {
            id: mySlider
            width: parent.width
            from: 0.0
            to: 1.0
            value: output.volume

            onValueChanged: {
                output.volume = value

            }

            background: Rectangle
            {
                x: mySlider.leftPadding
                y: mySlider.topPadding + mySlider.availableHeight / 2 - height / 2
                implicitWidth: 200
                implicitHeight: 10
                width: mySlider.availableWidth
                height: implicitHeight
                radius: height / 2
                color: "transparent"
                border.width:2
                border.color:"white"

                Rectangle
                {
                    width: mySlider.visualPosition == 0 ? 0 : mySlider.handle.x  + mySlider.handle.width / 2
                    height: parent.height
                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop { position: 0.0; color: "#fff" }
                        GradientStop { position: 0.5; color: "#2ea3dd" }
                        GradientStop { position: 1.0; color: "#fff" }
                    }
                    radius: height / 2
                }
            }

            handle: Rectangle
            {
                x: mySlider.leftPadding + mySlider.visualPosition * (mySlider.availableWidth - width)
                y: mySlider.topPadding + mySlider.availableHeight / 2 - height/ 2
                implicitHeight: 20
                implicitWidth: 20
                radius: implicitWidth / 2
                color: mySlider.pressed ? "#fff" : "#2ea3dd"
                border.color: "#ffffff"
                border.width: 2
            }
        }

        Text {
            text: "  0           1             2             3              4              5"
            font.pointSize: 14
            color: "#fff"
            horizontalAlignment: Text.AlignLeft
        }

    }


    /********************************************************************************************************/
    /************************************   Temperature   ***************************************************/
    /********************************************************************************************************/
    Column {
        id:tempreaturesetion
        spacing: 20
        width: parent.width / 3
        anchors.top: fansection.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 50

        // Title
        Text {
            text: "Temperature"
            font.pointSize: 14
            color: "#fff"
            horizontalAlignment: Text.AlignLeft
            font.bold: true
        }

        Row{
            spacing: 40
            Text {
                width:20
                text: mySlider1.value+"°c"
                font.pointSize: 14
                color: "#fff"
                horizontalAlignment: Text.AlignLeft
            }

        Slider
        {
            id:mySlider1
            width: mySlider.width*0.85
            anchors.verticalCenter: parent.verticalCenter
            from: 0
            to: 40
            value: output.volume
            stepSize: 1.0


            background: Rectangle
            {
                x: mySlider1.leftPadding
                y: mySlider1.topPadding + mySlider1.availableHeight / 2 - height / 2
                implicitWidth: 200
                implicitHeight: 10
                width: mySlider1.availableWidth
                height: implicitHeight
                radius: height / 2
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: "#bae2ff" }
                    GradientStop { position: 0.5; color: "#0394fc" }
                    GradientStop { position: 0.75; color: "#ff8b42" }
                    GradientStop { position: 1.0; color: "#fc1c03" }
                }


                Rectangle
                {
                    width: mySlider1.visualPosition == 0 ? 0 : mySlider1.handle.x  + mySlider1.handle.width / 2
                    height: parent.height
                    color:"transparent"
                    // gradient: Gradient {
                    //     orientation: Gradient.Horizontal
                    //     GradientStop { position: 0.0; color: "#bae2ff" }
                    //     GradientStop { position: 0.5; color: "#0394fc" }
                    //     GradientStop { position: 0.75; color: "#ff8b42" }
                    //     GradientStop { position: 1.0; color: "#fc1c03" }
                    // }
                    radius: height / 2
                }
            }

            handle: Rectangle
            {
                x: mySlider1.leftPadding + mySlider1.visualPosition * (mySlider1.availableWidth - width)
                y: mySlider1.topPadding + mySlider1.availableHeight / 2 - height/ 2
                implicitHeight: 20
                implicitWidth: 20
                radius: implicitWidth / 2
                color: "#fff"
                border.color: "#ffffff"
                border.width: 2
            }
        }


        }
    }

    /********************************************************************************************************************/
    /******************************************* AIR FLOW ***************************************************************/
    /********************************************************************************************************************/

    Column {
        id:airFlowsection
        spacing: 20
        width: parent.width / 3
        anchors.top: tempreaturesetion.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 50

        // Title
        Text {
            text: "AirFlow"
            font.pointSize: 14
            color: "#fff"
            font.bold: true
            horizontalAlignment: Text.AlignLeft
        }

        Row {
            id: seats
            spacing: 50
            anchors.left: parent.left
            anchors.leftMargin: 10

            Rectangle {
                id:seat0
                width: 80; height: 80
                color: !isSeat0 ? "transparent" : "#2ea3dd"
                radius: 40
                border.width: 1
                border.color: "#2ea3dd"
                clip: true

                Image {
                    width: 50; height: 50
                    anchors.centerIn: parent
                    source: "file:///C:/Users/fedikk/Documents/Cockpit/images/settings/seat0"
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    asynchronous: true
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: isSeat0 = !isSeat0
                    hoverEnabled: true
                }

            }
            //Seat 1
            Rectangle {
                id:seat1
                width: 80; height: 80
                color: !isSeat1 ? "transparent" : "#2ea3dd"
                radius: 40
                border.width: 1
                border.color: "#2ea3dd"
                clip: true

                Image {
                    width: 50; height: 50
                    anchors.centerIn: parent
                    source: "file:///C:/Users/fedikk/Documents/Cockpit/images/settings/seat1"
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    asynchronous: true
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: isSeat1 = !isSeat1
                    hoverEnabled: true
                }

            }


            //Seat 2
            Rectangle {
                id:seat2
                width: 80; height: 80
                color: !isSeat2 ? "transparent" : "#2ea3dd"
                radius: 40
                border.width: 1
                border.color: "#2ea3dd"
                clip: true

                Image {
                    width: 50; height: 50
                    anchors.centerIn: parent
                    source: "file:///C:/Users/fedikk/Documents/Cockpit/images/settings/seat2"
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    asynchronous: true
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: isSeat2 = !isSeat2
                    hoverEnabled: true
                }

            }

            //Seat 1
            Rectangle {
                id:seat3
                width: 80; height: 80
                color: !isSeat3 ? "transparent" : "#2ea3dd"
                radius: 40
                border.width: 1
                border.color: "#2ea3dd"
                clip: true

                Image {
                    width: 50; height: 50
                    anchors.centerIn: parent
                    source: "file:///C:/Users/fedikk/Documents/Cockpit/images/settings/seat3"
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    asynchronous: true
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: isSeat3 = !isSeat3
                    hoverEnabled: true
                }

            }
        }

    }

    /********************************************************************************************************************/
    /******************************************* AIR FLOW Property ******************************************************/
    /********************************************************************************************************************/

    Column {
        id:aircdts
        spacing: 20
        width: parent.width / 3
        anchors.top: airFlowsection.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 50

        Row {
               spacing: 40

               // first column
               Column {
                   spacing: 8
                   anchors.verticalCenter: parent.verticalCenter

                   Text {
                       text: "Front Defrost"
                       font.pointSize: 14
                       color: "white"
                       font.bold: true
                       horizontalAlignment: Text.AlignHCenter
                       anchors.horizontalCenter: parent.horizontalCenter
                   }

                   Rectangle {
                       id:airdcdt1
                       width: 80; height: 80
                       color: !isFrontdef ? "transparent" : "#2ea3dd"
                       radius: 40
                       border.width: 1
                       border.color: "#2ea3dd"
                       anchors.horizontalCenter: parent.horizontalCenter
                       clip: true

                       Image {
                           width: 50; height: 50
                           anchors.centerIn: parent
                           source: "file:///C:/Users/fedikk/Documents/Cockpit/images/settings/frontdef"
                           fillMode: Image.PreserveAspectFit
                           smooth: true
                           asynchronous: true
                       }
                       MouseArea {
                           anchors.fill: parent
                           onClicked: isFrontdef = !isFrontdef
                           hoverEnabled: true
                       }

                   }
               }

               // second  column
               Column {
                   spacing: 8
                   anchors.verticalCenter: parent.verticalCenter

                   Text {
                       text: "Rear Defrost"
                       font.pointSize: 14
                       color: "white"
                       font.bold: true
                       horizontalAlignment: Text.AlignHCenter
                       anchors.horizontalCenter: parent.horizontalCenter
                   }

                   Rectangle {
                       id:airdcdt2
                       width: 80; height: 80
                       color: !isBackdef ? "transparent" : "#2ea3dd"
                       radius: 40
                       border.width: 1
                       border.color: "#2ea3dd"
                       anchors.horizontalCenter: parent.horizontalCenter
                       clip: true

                       Image {
                           width: 50; height: 50
                           anchors.centerIn: parent
                           source: "file:///C:/Users/fedikk/Documents/Cockpit/images/settings/reardef.png"
                           fillMode: Image.PreserveAspectFit
                           smooth: true
                           asynchronous: true
                       }
                       MouseArea {
                           anchors.fill: parent
                           onClicked: isBackdef = !isBackdef
                           hoverEnabled: true
                       }

                   }
               }

               // third column
               Column {
                   spacing: 8
                   anchors.verticalCenter: parent.verticalCenter

                   Text {
                       text: "Fresh Air"
                       font.pointSize: 14
                       color: "white"
                       font.bold: true
                       horizontalAlignment: Text.AlignHCenter
                       anchors.horizontalCenter: parent.horizontalCenter
                   }

                   Rectangle {
                       id:freshair
                       width: 80; height: 80
                       color: !isFresh ? "transparent" : "#2ea3dd"
                       radius: 40
                       border.width: 1
                       border.color: "#2ea3dd"
                       anchors.horizontalCenter: parent.horizontalCenter
                       clip: true

                       Image {
                           width: 50; height: 50
                           anchors.centerIn: parent
                           source: "file:///C:/Users/fedikk/Documents/Cockpit/images/settings/freshair.png"
                           fillMode: Image.PreserveAspectFit
                           smooth: true
                           asynchronous: true
                       }
                       MouseArea {
                           anchors.fill: parent
                           onClicked: isFresh = !isFresh
                           hoverEnabled: true
                       }

                   }
               }

               // fourth column
               Column {
                   spacing: 8
                   anchors.verticalCenter: parent.verticalCenter

                   Text {
                       text: "Recirculation"
                       font.pointSize: 14
                       color: "white"
                       font.bold: true
                       horizontalAlignment: Text.AlignHCenter
                       anchors.horizontalCenter: parent.horizontalCenter
                   }

                   Rectangle {
                       id:airrecirculation
                       width: 80; height: 80
                       color: !isRecir ? "transparent" : "#2ea3dd"
                       radius: 40
                       border.width: 1
                       border.color: "#2ea3dd"
                       anchors.horizontalCenter: parent.horizontalCenter
                       clip: true

                       Image {
                           width: 50; height: 50
                           anchors.centerIn: parent
                           source: "file:///C:/Users/fedikk/Documents/Cockpit/images/settings/resair.png"
                           fillMode: Image.PreserveAspectFit
                           smooth: true
                           asynchronous: true
                       }
                       MouseArea {
                           anchors.fill: parent
                           onClicked: isRecir = !isRecir
                           hoverEnabled: true
                       }

                   }
               }

           }

    }














}
