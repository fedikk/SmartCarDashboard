import QtQuick 2.15
import QtQuick.Controls 2.15


Item {
    width: 1280
    height: 720

    property bool hovered: false

    // List of films
    ListModel {
        id: filmModel

        ListElement {
            titleImage: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/openheimertitle.png"
            length: "180"
            genre: "Biography, Drama, History"
            rating: "5.0"
            year: "2023"
            description: "The story of J. Robert Oppenheimer’s role in the development of the atomic bomb during World War II, and the moral dilemmas he faces."
            bg: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/openheimerbg.png"
            poster: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/openheimer.jpg"
        }
        //Lilo & stitch
        ListElement {
            titleImage: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/stitchtitle.png"
            length: "108"
            genre: "Animation, Adventure, Comedy"
            rating: "4.2"
            year: "2025"
            description: "A young and mischievous girl named Lilo adopts a strange alien named Stitch, who was engineered to be destructive. Together, they form a unique and loving bond."
            bg: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/stitchbg.png"
            poster: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/liloandstitch.jpg"
        }
        //venom
        ListElement {
            titleImage: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/venomtitle.png"
            length: "112"
            genre: "Action, Sci-Fi, Thriller"
            rating: "3.0"
            year: "2024"
            description: "Journalist Eddie Brock gains superpowers after becoming host to an alien symbiote. Together, they become Venom and must fight against a powerful enemy."
            bg: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/venombg.jpg"
            poster: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/venom.jpg"
        }
        //mISSION IMPO
        ListElement {
            titleImage: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/missionimpotitle.png"
            length: "163"
            genre: "Action, Sci-Fi, Thriller"
            rating: "4.5"
            year: "2018"
            description: "Ethan Hunt and the IMF team must track down a terrifying new weapon that threatens all of humanity if it falls into the wrong hands. With control of the future and the fate of the world at stake, a deadly race around the globe begins."
            bg: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/missionimpobg.jpg"
            poster: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/missionimpo.jpg"
        }
        // how to train your dragon
        ListElement {
            titleImage: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/howtotraintitle.png"
            length: "125"
            genre: " Adventure, Fantasy"
            rating: "4.15"
            year: "2025"
            description: "On the rugged isle of Berk, a Viking boy named Hiccup defies centuries of tradition by befriending a dragon named Toothless. However, Hiccup's friendship with Toothless becomes the key to forging a new future."
            bg: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/howtotrainbg.jpg"
            poster: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/howtotrain.jpg"
        }

        //beekeeper
        ListElement {
            titleImage: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/beekeeptitle.png"
            length: "105"
            genre: "Action, Thriller"
            rating: "4.1"
            year: "2025"
            description: "A former operative of a secretive organization known as the Beekeepers takes on a personal mission of vengeance after uncovering a conspiracy at the highest levels of power."
            bg: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/beekeepBg.jpg"
            poster: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/beekeep.jpg"
        }

    }

    property int currentIndex: 0
    property var currentFilm: filmModel.get(currentIndex)
    property var previousFilm: filmModel.get((currentIndex - 1 + filmModel.count) % filmModel.count)
    property var nextFilm: filmModel.get((currentIndex + 1) % filmModel.count)

    Timer {
            interval: 5000
            running: true
            repeat: true
            onTriggered: {
                currentIndex = (currentIndex + 1) % filmModel.count
                currentFilm = filmModel.get(currentIndex)
                previousFilm = filmModel.get((currentIndex - 1 + filmModel.count) % filmModel.count)
                nextFilm = filmModel.get((currentIndex + 1) % filmModel.count)
            }
        }

    // Trending Text Button
    Rectangle {
        id: trend
        width: 120
        height: 40
        radius:20
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 20
        anchors.rightMargin: 180
        color: "transparent"
        border.width: 2
        border.color: "white"
        z: 10
        MouseArea {
            id: trendingArea
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                trend.color = "#2ea3dd"
                trend.border.color="#2ea3dd"
            }
            onExited : {
                trend.color = "transparent"
                trend.border.color="white"
            }
            onClicked: {
                allfilmpage.z = -5
            }

            Text {
                anchors.centerIn: parent
                text: "Trending"
                color: trendingArea.containsMouse ? "#ffffff" : "#cccccc"
                font.pixelSize: 20
                font.bold: true
            }
        }
    }

    // Films Text Button
    Rectangle {
        id:films
        width: 120
        height: 40
        radius:20
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 20
        anchors.rightMargin: 40
        color: "transparent"
        border.width: 2
        border.color: "white"
        z:10
        MouseArea {
            id: filmsArea
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                films.color = "#2ea3dd"
                films.border.color="#2ea3dd"
            }
            onExited : {
                films.color = "transparent"
                films.border.color="white"
            }
            onClicked: {
                allfilmpage.z = 4
            }

            Text {
                anchors.centerIn: parent
                text: "Films"
                color: filmsArea.containsMouse ? "#ffffff" : "#cccccc"
                font.pixelSize: 20
                font.bold: true
            }
        }
    }



    Filmselection{
        id:allfilmpage
        anchors.fill: parent
        z:-4
    }

    Rectangle {
        width: parent.width
        height: parent.height
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "#000" }
            GradientStop { position: 0.5; color: "#142B39" }
            GradientStop { position: 1.0; color: "#000" }
        }
        z: -2
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        Image {
            anchors.fill: parent
            source: currentFilm.bg
            fillMode: Image.PreserveAspectCrop
            smooth: true
        }
        z: -1
    }
    Rectangle {
        width:200
        height: parent.height
        color:"transparent"
        anchors.left:parent.left
        // Previous Film
        Rectangle {
            width: 150
            height: 220
            anchors.top: parent.top
            anchors.topMargin: 50
            anchors.left: parent.left
            anchors.leftMargin: 50
            opacity: 0.65
            Image {
                anchors.fill: parent
                source: previousFilm.poster
                fillMode: Image.PreserveAspectCrop
                smooth: true
            }
        }

        // Next Film Poster
        Rectangle {
            width: 150
            height: 220
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 100
            anchors.left: parent.left
            anchors.leftMargin: 50
            color: "transparent"
            opacity: 0.65
            Image {
                anchors.fill: parent
                source: nextFilm.poster
                fillMode: Image.PreserveAspectCrop
                smooth: true
            }
        }

    }

    Rectangle {
        id: playbtn
        width: 250
        height: 360
        z:2
        color:  "transparent"
        opacity: hovered
        anchors.top: parent.top
        anchors.topMargin: 170
        anchors.left: parent.left
        anchors.leftMargin: 270
        Image {
            width: 100
            height: 100
            anchors.centerIn: parent
            source: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/play.png"
            fillMode: Image.PreserveAspectCrop
            smooth: true
        }
    }
    Rectangle {
        width: 250
        height: 350
        z:3
        color:  "#254f69"
        opacity: hovered*0.3
        anchors.top: parent.top
        anchors.topMargin: 170
        anchors.left: parent.left
        anchors.leftMargin: 270
    }

    Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent"

        Row {
            anchors.top: parent.top
            anchors.topMargin: 150
            anchors.left: parent.left
            anchors.leftMargin: 270
            spacing: 30

            Rectangle {
                width: 250
                height: 370
                color: "transparent"

                Image {
                    anchors.fill: parent
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    source: currentFilm.poster
                    fillMode: Image.PreserveAspectCrop
                    smooth: true
                }
                MouseArea {
                    id: hoverArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: hovered = true
                    onExited: hovered = false
                    onPressed: playbtn.scale = 0.85
                    onReleased: playbtn.scale = 1.0
                    onCanceled: playbtn.scale = 1.0
                }
            }

            Column {
                anchors.top: parent.top
                anchors.topMargin: 20
                spacing: 20
                width: 500

                // 🔤 Title Image

                Rectangle {
                    width: 400
                    height: 60
                    color: "transparent"
                    Image {
                        anchors.centerIn: parent
                        width:parent.width
                        source: currentFilm.titleImage
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }
                }

                // film rating
                Row {
                    spacing: 4

                    Repeater {
                        model: 5
                        Image {
                            width: 24
                            height: 24
                            source: index < Math.round(currentFilm.rating)
                                    ? "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/star.png"
                                    : "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/staroff.png"
                        }
                    }

                    Text {
                        text: "(" + currentFilm.rating + " / 5.0)"
                        font.pixelSize: 16
                        color: "#ccc"
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: 10
                    }
                }

                Row  {
                    Rectangle {
                        width:30
                        height: 24
                        color: "transparent"
                        Image {
                            width: 24
                            height: 24
                            source: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/time.png"
                        }
                    }
                    //film duration
                    Text {
                        text: currentFilm.length
                        font.pixelSize: 18
                        color: "#fff"
                        font.bold: true
                    }
                }

                Row  {
                    Rectangle {
                        width:30
                        height: 24
                        color: "transparent"
                        Image {
                            width: 24
                            height: 24
                            source: "file:///C:/Users/fedikk/Documents/Cockpit/images/Film/year.png"
                        }
                    }
                    //film Year
                    Text {
                        text: currentFilm.year
                        font.pixelSize: 18
                        color: "#fff"
                        font.bold: true
                    }
                }


                //film genre
                Text {
                    text: "Genre: " + currentFilm.genre
                    font.pixelSize: 18
                    color: "#fff"
                    font.bold: true
                }




                Rectangle {
                    width: 550
                    height: 100
                    color: "transparent"

                    Text {
                        text: currentFilm.description
                        font.pixelSize: 18
                        color: "#fff"
                        font.bold: true
                        wrapMode: Text.Wrap
                        anchors.fill: parent
                    }
                }
            }


        }
    }
}

