// /*
// ==========================================================
//    Main Home View (Clock + Weather + Map)
//    Author: FEDIKOUKI
//    Description: Displays an analog/digital clock, weather info,
//                 and an interactive map using Qt Quick & QtLocation.
// ==========================================================
// */

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import QtLocation 5.15
import QtPositioning 5.15
import "WeatherUtils.js" as Utils

Item {
    id: root
    width: 1280
    height: 720
    anchors.fill: parent

    /* ----------- GLOBAL PROPERTIES ----------- */
    property bool showAnalogClock: false
    property string apiKey: "318dc03105230079c3c49dade4576b0c"
    property var weatherData: ({})
    property string iconCode: ""
    property real lan: 37.166666
    property real lat: 10.0333332

    /* ----------- COLORS & STYLES ----------- */
    readonly property string primaryColor: "#00314F"
    readonly property string secondaryColor: "#E66808"
    readonly property string textOutlineColor: "#00314F"

    /* ----------- BACKGROUND GRADIENT ----------- */
    Rectangle {
        anchors.fill: parent
        // gradient: Gradient {
        //     orientation: Gradient.Horizontal
        //     GradientStop { position: 0.0; color: "#9EEDF1" }
        //     GradientStop { position: 0.7; color: primaryColor }
        //     GradientStop { position: 1.0; color: "#9EEDF1" }
        // }
        Image {
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: Utils.weatherImageFor(weatherBackground.weatherDesc)
        }
    }
    Rectangle {
        id : shadow
        width:parent.width/3
        height:parent.height/2
        anchors.left: weatherBackground.left
        anchors.leftMargin: 100
        anchors.bottom: weatherBackground.bottom
        anchors.bottomMargin: 150
        radius: 30
        opacity: 0.5
        color:primaryColor
        z:4
    }

    //     /* ==========================================================
    //        LEFT COLUMN (Clock + Date + Quote)
    //     ========================================================== */
        Rectangle {
            id:dateInfo
            width:parent.width/2
            height:parent.height
            anchors.left:parent.left
            color: "transparent"

            Column {
                anchors.top: parent.top
                anchors.topMargin: 100
                spacing: 20
                anchors.fill: parent

                /* --- CLOCK SECTION --- */
                Item {
                    id: clockSection
                    width: parent.width
                    height: 220

                    /* Digital Time */
                    Text {
                        id: timeText
                        text: Qt.formatTime(new Date(), "hh:mm")
                        font.pixelSize: 100
                        font.bold: true
                        color: "white"
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.topMargin: 100
                        anchors.leftMargin: 150
                        style: Text.Outline
                        styleColor: textOutlineColor
                        opacity: showAnalogClock ? 0 : 1
                        Behavior on opacity { NumberAnimation { duration: 400; easing.type: Easing.InOutQuad } }
                    }

                    /* Analog Clock Canvas */
                    Clock {
                        id: clock
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.top: parent.top
                        anchors.topMargin: -(parent.height/4)
                        width: Math.min(dateInfo.width*0.9 , dateInfo.height*1)
                        height: width
                        analogVisible: showAnalogClock
                        onToggleRequested: showAnalogClock = !showAnalogClock
                        primaryColor: "#00314F"
                        secondaryColor: "#E66808"
                    }



                }

                /* Date Text */
                Text {
                    id: dateText
                    text: Qt.formatDate(new Date(), "dddd, dd MMMM yyyy")
                    font.pixelSize: 40
                    color: primaryColor
                    anchors.left: parent.left
                    anchors.leftMargin: 90
                    style: Text.Outline
                    styleColor: "#fff"
                    opacity: !showAnalogClock
                    Behavior on opacity { NumberAnimation { duration: 400; easing.type: Easing.InOutQuad } }
                }

                /* Quote */
                Text {
                    id: quoteText
                    width: 550
                    text: "The best way to predict the future is to create it.— Peter Drucker"
                    font.pixelSize: 24
                    color: "#fff"
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    wrapMode: Text.WordWrap
                    style: Text.Outline
                    styleColor: "#00314F"
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter   // <-- center alignment
                    opacity: !showAnalogClock
                    Behavior on opacity {
                        NumberAnimation { duration: 400; easing.type: Easing.InOutQuad }
                    }
                }
            }

            /* Update Digital Clock and Date */
            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: {
                    if (!showAnalogClock)
                        timeText.text = Qt.formatTime(new Date(), "hh:mm")
                    dateText.text = Qt.formatDate(new Date(), "dddd, dd MMMM yyyy")
                }
            }
        }


    //     /* --- Weather Background --- */
        Rectangle {
            id: weatherBackground
            width:parent.width/2
            height:parent.height
            anchors.left: dateInfo.right
            radius: 12
            color: "transparent"
            z:5
            property string weatherDesc: weatherData.state ? weatherData.state.toLowerCase() : "clear"



            /* Weather UI Content */
            Column {
                anchors.centerIn: parent
                spacing: 8
                width: parent.width

                Image {
                    width: 64; height: 64
                    source: iconCode !== "" ? "file:///C:/Users/fedikk/Documents/Cockpit/images/meteo/" + iconCode + "@2x.png" : ""
                    fillMode: Image.PreserveAspectFit
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text { text: weatherData.city || "--"; color: "white"; font.pixelSize: 22; font.bold: true; horizontalAlignment: Text.AlignHCenter; width: parent.width }
                Text { text: weatherData.temp !== undefined ? " " + weatherData.temp + "°" : "--"; color: "white"; font.pixelSize: 60; font.bold: true; horizontalAlignment: Text.AlignHCenter; width: parent.width }
                Text { text: weatherData.state || "--"; color: "white"; font.pixelSize: 30; font.bold: true; horizontalAlignment: Text.AlignHCenter; width: parent.width }

                /* Min/Max Temperature Bar */
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20

                    Text { text: weatherData.tempMin !== undefined ? " " + weatherData.tempMin + "°" : "--"; color: "white"; font.pixelSize: 20; font.bold: true }

                    Rectangle {
                        id: bar
                        width: 200; height: 3; radius: 20
                        anchors.verticalCenter: parent.verticalCenter
                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0.0; color: "#fffb00" }
                            GradientStop { position: 0.5; color: "#ffb300" }
                            GradientStop { position: 1.0; color: "#ff0000" }
                        }
                        property real value: (weatherData.tempMax !== weatherData.tempMin) ?
                            (weatherData.temp - weatherData.tempMin) / (weatherData.tempMax - weatherData.tempMin) : 0

                        Rectangle {
                            width: 12; height: 12; radius: 6
                            color: "white"
                            border.color: "black"
                            anchors.verticalCenter: parent.verticalCenter
                            x: bar.width * bar.value - width / 2
                        }
                    }

                    Text { text: weatherData.tempMax !== undefined ? " " + weatherData.tempMax + "°" : "--"; color: "white"; font.pixelSize: 20; font.bold: true }
                }

                /* Humidity, Rain, Wind */
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
                    Text { text: weatherData.humidity !== undefined ? "H: " + weatherData.humidity + "%" : "Humidity: --"; color: "#fff"; font.pixelSize: 14; font.bold: true }
                    Text { text: weatherData.rainChance !== undefined ? "Rain: " + weatherData.rainChance + "%" : "Rain: --"; color: "#fff"; font.pixelSize: 14; font.bold: true }
                    Text { text: weatherData.windSpeed !== undefined ? "Wind: " + (weatherData.windSpeed * 3.6).toFixed(1) + " km/h" : "Wind: --"; color: "#fff"; font.pixelSize: 14; font.bold: true }
                }
            }

            /* Fetch Weather on Load */
            Component.onCompleted: Utils.fetchWeather(lan, lat)
        }


}
