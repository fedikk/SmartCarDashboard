import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtLocation 5.15
import QtPositioning 5.15

Item {
    width: parent.width
    height: parent.height
    id: mapPage
    anchors.fill: parent

    Plugin {
        id: mapPlugin
        name: "osm"
    }

    RowLayout {
        anchors.fill: parent
        spacing: 10
        Rectangle {
            id: vehicleSection
            Layout.preferredWidth: 270
            Layout.fillHeight: true
            color: "#222222"

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 15

                Text {
                    text: "Vehicle Info"
                    font.pixelSize: 24
                    color: "white"
                    Layout.alignment: Qt.AlignHCenter
                }
                Text { text: "Speed: 85 km/h"; color: "white"; font.pixelSize: 18 }
                Text { text: "Fuel: 60%"; color: "white"; font.pixelSize: 18 }
            }
        }
        Rectangle {
            id: mapSection
            Layout.preferredWidth: 1010
            Layout.fillHeight: true
            color: "black"

            Map {
                id: map
                anchors.fill: parent
                plugin: mapPlugin
                center: QtPositioning.coordinate(36.8663, 10.1647) // Ariana
                zoomLevel: 14
                focus: true
                enabled: true

                property geoCoordinate startCentroid

                PinchHandler {
                    id: pinch
                    target: null
                    onActiveChanged: if (active) {
                        map.startCentroid = map.toCoordinate(pinch.centroid.position, false)
                    }
                    onScaleChanged: (delta) => {
                        map.zoomLevel += Math.log2(delta)
                        map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
                    }
                    onRotationChanged: (delta) => {
                        map.bearing -= delta
                        map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
                    }
                    grabPermissions: PointerHandler.TakeOverForbidden
                }

                WheelHandler {
                    id: wheel
                    rotationScale: 1/120
                    property: "zoomLevel"
                }

                DragHandler {
                    id: drag
                    target: null
                    onTranslationChanged: (delta) => map.pan(-delta.x, -delta.y)
                }
            }
        }


    }
}
