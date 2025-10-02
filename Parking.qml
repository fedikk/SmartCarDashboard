import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import QtMultimedia


Item {
    id: parkingView
    width: 1280
    height: 720
    anchors.fill: parent
    property real steeringAngle: 0   // -45 to 45 degrees (example range)
    property real leftStartX: carFrame.x + 10
    property real rightStartX: carFrame.x + carFrame.width - 10
    property real offset: 50
    property real leftEndX: leftStartX + 100 * Math.sin(steeringAngle / 90)
    property real rightEndX: rightStartX + 100 * Math.sin(steeringAngle / 90)
    property real endY: carFrame.y - 350
    property real midY: (leftEndY + rightEndY) / 2
    property real leftEndY: carFrame.y - 300 + 50 * Math.sin(steeringAngle / 90)
    property real rightEndY: carFrame.y - 300 - 50 * Math.sin(steeringAngle / 90)
    // Shared scroll position
    property real scrollY: 0
    property int imageHeight: 720


    Rectangle {
        id: cameraBackground
        anchors.fill: parent
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "#000" }
            GradientStop { position: 0.5; color: "#142B39" }
            GradientStop { position: 1.0; color: "#000" }
        }
    }
    // Right Panel for car & road
    Rectangle {
        id: carholder
        width: 400
        height: parent.height
        color: "transparent"
        anchors.right: parent.right
        Rectangle {
            id: shadowContainer
            width: 120
            height: 150
            anchors.left: parent.left
            anchors.leftMargin: 120
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
            color: "#34699A"
            opacity: 0.4
            z: 1 // LOWER z to stay behind
        }
        // MINI line Indicator: behind the car image
        Rectangle {
            id: pathContainer
            width: 120
            height: 150
            anchors.left: parent.left
            anchors.leftMargin: 120
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
            z: 1 // LOWER z to stay behind

            color: "transparent"

            property real endOffset: 30

            // RIGHT curved line with steering at START (mirrored)
            Shape {
                anchors.fill: parent
                ShapePath {
                    strokeColor: "red"
                    strokeWidth: 4
                    fillColor: "transparent"
                    capStyle: ShapePath.RoundCap

                    // Start at bottom-right, offset based on steering
                    startX: pathContainer.width - 30 * Math.sin(steeringAngle / 90)
                    startY: pathContainer.height

                    PathQuad {
                        // End at top-right
                        x: pathContainer.width
                        y: 0

                        // Control point curves OUTWARD
                        controlX: pathContainer.width - 5 * Math.sin(steeringAngle / 90)
                        controlY: pathContainer.height / 2
                    }
                }
            }

            // LEFT curved line with steering at START (mirrored)
            Shape {
                anchors.fill: parent
                ShapePath {
                    strokeColor: "red"
                    strokeWidth: 4
                    fillColor: "transparent"
                    capStyle: ShapePath.RoundCap

                    // Start at bottom-left, opposite offset
                    startX: 0 - 30 * Math.sin(steeringAngle / 90)
                    startY: pathContainer.height

                    PathQuad {
                        // End at top-left
                        x: 0
                        y: 0

                        // Control point curves OUTWARD (reversed sign)
                        controlX: 0 - 5 * Math.sin(steeringAngle / 90)
                        controlY: pathContainer.height / 2
                    }
                }
            }



        }

        // CAR image holder (now visually above the mini lines)
        Rectangle {
            width: 400
            height: 300
            color: "transparent"
            anchors.top: parent.top
            anchors.topMargin: 170
            z: 10 // Higher than pathContainer
            Image {
                id: carimage
                source: "file:///C:/Users/fedikk/Documents/Cockpit/images/Park/car.png"
                fillMode: Image.PreserveAspectCrop
                smooth: true
            }
        }
        /********************************************************************************************/
        /*************************** Moving road effect *********************************************/
        /********************************************************************************************/
        Rectangle {
               id: container
               width: 435
               height: parent.height
               anchors.right: parent.right
               anchors.rightMargin: 0
               color: "transparent"
               clip: true

               // ✅ Scroll position shared by both images
               property real scrollY: 0
               property int imageHeight: 720

               // ✅ First image
               Image {
                   id: movingImage
                   width: parent.width
                   height: imageHeight
                   y: container.scrollY
                   source: "file:///C:/Users/fedikk/Documents/Cockpit/images/Park/road.jpg"
                   fillMode: Image.Stretch
                   smooth: true
               }

               // ✅ Second image below it
               Image {
                   id: secondroad
                   width: parent.width
                   height: imageHeight
                   y: container.scrollY + imageHeight
                   source: "file:///C:/Users/fedikk/Documents/Cockpit/images/Park/road.jpg"
                   fillMode: Image.Stretch
                   smooth: true
               }

               // ✅ Animate scrollY to move both images
               NumberAnimation on scrollY {
                   from: -imageHeight
                   to: 0
                   duration: 3000
                   loops: Animation.Infinite
                   running: true
               }
        }



}

    // camera Field Frame
    Rectangle{
        width: 900
        height: 500
        anchors.top: parent.top
        anchors.topMargin: 60
        color: "transparent"
        z:4
        Image {
            id: frame
            anchors.fill: parent
            source: "file:///C:/Users/fedikk/Documents/Cockpit/images/Park/frame.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    // Steering Wheel image
    Rectangle{
        width: 120
        height: 120
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 380
        color: "transparent"
        z:5
        Image {
            id: steerwheel
            anchors.fill: parent
            source: "file:///C:/Users/fedikk/Documents/Cockpit/images/Park/steeringwheel.png"
            fillMode: Image.PreserveAspectFit
            rotation: steeringAngle/4
            transformOrigin: Item.Center
        }
    }

    //Rear Camera
    Rectangle {
        width: 730
        height: 450
        color:"black"
        z:3
        anchors.top: parent.top
        anchors.topMargin: 90
        anchors.left: parent.left
        anchors.leftMargin: 78
        MediaDevices {
            id: mediaDevices
        }

        Camera {
            id: camera
            cameraDevice: mediaDevices.defaultVideoInput
            focusMode: Camera.FocusModeAutoNear
            customFocusPoint: Qt.point(0.5, 0.5) // Center focus
        }

        CaptureSession {
            id: captureSession
            camera: camera
            videoOutput: videoOutput
        }

        VideoOutput {
            id: videoOutput
            anchors.fill: parent
            fillMode: VideoOutput.PreserveAspectFit
        }

        Component.onCompleted: camera.start()
    }








    // Vehicle outline
    Rectangle {
        id: carFrame
        width: 400
        height: 1
        color: "transparent"
        anchors.left: parent.left
        anchors.leftMargin: 250
        anchors.top: parent.top
        anchors.topMargin: 515
        radius: 10
    }

    // right path line direction
    Shape {
        id: rightPath
        anchors.fill: parent
        z:10
        ShapePath {
            strokeColor: "#FDF5AA"
            strokeWidth: 4
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap

            startX: rightStartX
            startY: carFrame.y

            PathQuad {
                x: rightStartX  + 100 * Math.sin(steeringAngle / 90)
                y: endY
                controlX: rightStartX - 30 * Math.sin(steeringAngle / 90)
                controlY: carFrame.y - 150
            }
        }
    }
    // Left path  line direction
    Shape {
        id: leftPath
        anchors.fill: parent
        z:10
        ShapePath {
            strokeColor: "#FDF5AA"
            strokeWidth: 4
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap

            startX: leftStartX
            startY: carFrame.y

            PathQuad {
                x: leftStartX + 100 * Math.sin(steeringAngle / 90)
                y: endY
                controlX: leftStartX - 30 * Math.sin(steeringAngle / 90)
                controlY: carFrame.y - 150
            }
        }
    }
    //Shadow effect repere
    Rectangle{
        width:380
        height: 350
        color: "#34699A"
        opacity: 0.4
        z:4
        anchors.top: parent.top
        anchors.topMargin: 165
        anchors.left: parent.left
        anchors.leftMargin: 260
    }

    // Horizontal line connecting leftEndX and rightEndX at endY
    Rectangle {
        id: connectingLineTop
        y: endY -2
        x: leftEndX
        width: rightEndX - leftEndX
        height: 2
        color: "#FDF5AA"
        radius: 1
        z:10
    }
    // Horizontal line connecting leftEndX and rightEndX at MIDY
    Rectangle {
        id: connectingLineMid
        y: midY + 150
        x: leftStartX + 5*Math.sin(steeringAngle/90)
        width: Math.abs(rightEndX - leftEndX)
        height: 4
        color: "#FDF5AA"
        radius: 1
        z: 10
    }



    // Slider to simulate steering angle
    Slider {
        id: steeringSlider
        from: -170
        to: 170
        value: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        width: 300

        onValueChanged: steeringAngle = value
    }

    // Display angle text
    Text {
        text: "Steering Angle: " + steeringAngle.toFixed(1) + "°"
        color: "white"
        font.pixelSize: 18
        anchors.bottom: steeringSlider.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 10
    }
}
