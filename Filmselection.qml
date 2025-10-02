import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    width: 1280
    height: 720

    // Full model of all films
    ListModel {
        id: fullFilmModel

        ListElement { title: "Oppenheimer"; genre: "Biography Drama History"; poster: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/openheimer.jpg" }
        ListElement { title: "Lilo & Stitch"; genre: "Animation Adventure Comedy"; poster: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/liloandstitch.jpg" }
        ListElement { title: "Venom"; genre: "Action Sci-Fi Thriller"; poster: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/venom.jpg" }
        ListElement { title: "Mission Impossible"; genre: "Action Sci-Fi Thriller"; poster: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/missionimpo.jpg" }
        ListElement { title: "How to Train Your Dragon"; genre: " Adventure Fantasy"; poster: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/howtotrain.jpg" }
        ListElement { title: "Beekeeper"; genre: "Thriller"; poster: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/beekeep.jpg" }
        ListElement { title: "Jurassic World Rebirth"; genre: "Action Sci-fi"; poster: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/jurrasicworld.jpg" }
        ListElement { title: "Deep Cover"; genre: "Comedy Crime"; poster: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/deepcover.jpg" }
        ListElement { title: "A Minecraft Movie"; genre: "Adventure Comedy"; poster: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/mincraftmovie.jpg" }
        ListElement { title: "First Steps"; genre: "Action Sci-fi"; poster: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/f4.jpg" }
        ListElement { title: "Zootopia2"; genre: "Family Comedy"; poster: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/zootopia.jpg" }
        ListElement { title: "Wicked "; genre: "Musical Fantasy"; poster: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/wicked.jpg" }
    }

    property string genreFilter: "All"

    // Filtered model
    ListModel {
        id: filteredModel
    }

    // List of unique genres
    ListModel {
        id: genreListModel
        ListElement { genre: "All" } // Default: show all
    }

    function populateGenres() {
        let seen = { "All": true }  // start with "All" included
        genreListModel.clear()
        genreListModel.append({ genre: "All" })

        for (let i = 0; i < fullFilmModel.count; i++) {
            let genres = fullFilmModel.get(i).genre.split(" ")  // split by space
            for (let j = 0; j < genres.length; j++) {
                let g = genres[j].trim()
                if (g.length > 0 && !seen[g]) {
                    genreListModel.append({ genre: g })
                    seen[g] = true
                }
            }
        }
    }


    function applyFilter() {
        filteredModel.clear()
        for (let i = 0; i < fullFilmModel.count; i++) {
            let film = fullFilmModel.get(i)
            if (genreFilter === "All" || film.genre.indexOf(genreFilter) !== -1) {
                filteredModel.append(film)
            }
        }
    }


    Component.onCompleted: {
        populateGenres()
        applyFilter()
    }

    Rectangle {
        id: filmselection
        anchors.fill: parent
        visible: true
        z: -5

        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "#000" }
            GradientStop { position: 0.5; color: "#142B39" }
            GradientStop { position: 1.0; color: "#000" }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 30
            spacing: 20

            // Genre Filter Dropdown
            RowLayout {
                spacing: 10
                Label {
                    text: "Filter by Genre:"
                    color: "white"
                    font.pixelSize: 18
                }

                ComboBox {
                    model: genreListModel
                    textRole: "genre"
                    onCurrentTextChanged: {
                        genreFilter = currentText
                        applyFilter()
                    }
                }
            }

            // Poster Grid
            GridView {
                id: posterGrid
                Layout.fillWidth: true
                Layout.fillHeight: true
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.topMargin: 20
                anchors.leftMargin: 20

                cellWidth: 300    // Adjusted from 280 to 320
                cellHeight: 420

                model: filteredModel
                clip: true
                interactive: true
                boundsBehavior: Flickable.StopAtBounds
                flickableDirection: Flickable.VerticalFlick

                // delegate: Item {
                //     width: 280   // slightly less than cellWidth
                //     height: 400
                //     Column {
                //         spacing: 6
                //         anchors.horizontalCenter: parent.horizontalCenter

                //         Rectangle {
                //             width: 260
                //             height: 350
                //             radius: 10
                //             color: "#00000000"

                //             Image {
                //                 anchors.fill: parent
                //                 source: model.poster
                //                 fillMode: Image.PreserveAspectCrop
                //                 smooth: true
                //             }

                //             MouseArea {
                //                 anchors.fill: parent
                //                 hoverEnabled: true
                //                 onEntered: parent.scale = 1.05
                //                 onExited: parent.scale = 1.0
                //                 onClicked: {
                //                     console.log("Clicked on", model.title)
                //                 }
                //                 cursorShape: Qt.PointingHandCursor
                //             }

                //             Behavior on scale {
                //                 NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                //             }
                //         }

                //         Text {
                //             text: model.title
                //             font.pixelSize: 16
                //             color: "white"
                //             horizontalAlignment: Text.AlignHCenter
                //             elide: Text.ElideRight
                //             width: 280
                //         }
                //     }
                // }
                delegate: Item {
                    width: 280
                    height: 400

                    Rectangle {
                        width: 260
                        height: 350
                        radius: 10
                        color: "#00000000"

                        Image {
                            id: posterImage
                            anchors.fill: parent
                            source: model.poster
                            fillMode: Image.PreserveAspectCrop
                            smooth: true
                        }

                        Rectangle {
                            id: overlay
                            anchors.fill: parent
                            color: "#000000"
                            opacity: hoverArea.containsMouse ? 0.6 : 0
                            visible: true
                            z: 1
                            Behavior on opacity {
                                NumberAnimation { duration: 200 }
                            }
                        }

                        Rectangle {
                            id: playButton
                            width: 80
                            height: 80
                            radius: 40
                            color: "transparent"
                            anchors.centerIn: parent
                            opacity: hoverArea.containsMouse ? 1 : 0
                            z: 2

                            Image {
                                anchors.centerIn: parent
                                source: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/play.png"
                                width: 100
                                height: 100
                                fillMode: Image.PreserveAspectFit
                                smooth: true
                            }

                            Behavior on opacity {
                                NumberAnimation { duration: 200 }
                            }
                        }

                        MouseArea {
                            id: hoverArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onPressed: playButton.scale = 0.85
                            onReleased: playButton.scale = 1.0
                            onCanceled: playButton.scale = 1.0
                            onClicked: {
                                console.log("Clicked on", model.title)
                            }
                        }

                        // Optional bottom gradient and title on hover (if you want)
                        Rectangle {
                            width: parent.width
                            height: 40
                            anchors.bottom: parent.bottom
                            color: "#00000088"
                            z: 3
                            visible: hoverArea.containsMouse

                            Text {
                                text: model.title
                                anchors.centerIn: parent
                                font.pixelSize: 20
                                font.bold: true
                                color: "white"
                            }
                        }
                    }
                }

            }


        }
    }
}
