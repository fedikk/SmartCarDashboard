import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 1280
    height: 720
    title: "DashCool"
    property string currentPage: "home"  // default page
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "Home.qml"
    }

    footer: Rectangle {
        height: 60
        width: parent.width
        color: "#000c1f"

        Row {
            anchors.centerIn: parent
            spacing: 20

            // Home Button
            Column {
                spacing: 5
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    width: currentPage === "home" ? 52 : 32
                    height: currentPage === "home" ? 52 : 32
                    fillMode: Image.PreserveAspectFit
                    source: currentPage === "home" ? "images/navbar/homeon.png" : "images/navbar/home.png"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(currentPage!="home"){
                                stackView.replace("Home.qml")
                                currentPage = "home"
                            }
                        }
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }





            //Music button
            Column {
                spacing: 5
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    width: currentPage === "music" ? 52 : 32
                    height: currentPage === "music" ? 52 : 32
                    source: currentPage === "music" ? "images/navbar/musicon.png" : "images/navbar/music.png"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(currentPage!="music"){
                            stackView.replace("music.qml")
                            currentPage = "music"
                            }
                        }
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }



            // phone button
            Column {
                spacing: 5
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    width: currentPage === "phone" ? 52 : 32
                    height: currentPage === "phone" ? 52 : 32
                    source: currentPage === "phone" ? "images/navbar/phoneon.png" : "images/navbar/phone.png"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(currentPage!="phone"){
                            stackView.replace("phonepage.qml")
                            currentPage = "phone"
                            }
                        }
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }



            //Film button
            Column {
                spacing: 5
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    width: currentPage === "film" ? 52 : 32
                    height: currentPage === "film" ? 52 : 32
                    source: currentPage === "film" ? "images/navbar/filmon.png" : "images/navbar/film.png"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(currentPage!="film"){
                            stackView.replace("Films.qml")
                            currentPage = "film"
                            }
                        }
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }


            // Parking button
            Column {
                spacing: 5
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    width: currentPage === "parking" ? 52 : 32
                    height: currentPage === "parking" ? 52 : 32
                    source: currentPage === "parking" ? "images/navbar/parkon.png" : "images/navbar/park.png"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(currentPage!="parking"){
                            stackView.replace("Parking.qml")
                            currentPage = "parking"
                            }
                        }
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }

            // Settings button
            Column {
                spacing: 5
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    width: currentPage === "settings" ? 52 : 32
                    height: currentPage === "settings" ? 52 : 32
                    source: currentPage === "settings" ? "images/navbar/mapon.png" : "images/navbar/map.png"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(currentPage!="settings"){
                            stackView.replace("settings.qml")
                            currentPage = "settings"
                            }
                        }
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }







        }
    }
}
