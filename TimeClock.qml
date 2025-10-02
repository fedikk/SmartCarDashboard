import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

Rectangle {
    width: 1280
    height: 720
    color: "black"

    property bool showAnalogClock: false

    Rectangle {
        id: mainClock
        width: parent.width / 3
        height: parent.height
        anchors.left: parent.left
        color: "transparent"

        // Click to toggle
        MouseArea {
            anchors.fill: parent
            onClicked: showAnalogClock = !showAnalogClock
        }

        // DIGITAL MODE
        Column {
            anchors.centerIn: parent
            spacing: 20
            visible: !showAnalogClock

            Text {
                id: timeText
                text: Qt.formatTime(new Date(), "hh:mm")
                font.pixelSize: 100
                color: "white"
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
            }

            Text {
                id: dateText
                text: Qt.formatDate(new Date(), "dddd, dd MMMM yyyy")
                font.pixelSize: 40
                color: "#aaaaaa"
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
            }

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: {
                    timeText.text = Qt.formatTime(new Date(), "hh:mm")
                    dateText.text = Qt.formatDate(new Date(), "dddd, dd MMMM yyyy")
                }
            }
        }

        // ANALOG MODE
        Canvas {
            id: analogClock
            anchors.centerIn: parent
            width: Math.min(parent.width, parent.height) * 0.9
            height: width
            visible: showAnalogClock

            onPaint: {
                var ctx = getContext("2d");
                var w = width;
                var h = height;
                var centerX = w / 2;
                var centerY = h / 2;
                var radius = Math.min(w, h) / 2 * 0.9;

                ctx.reset();
                ctx.clearRect(0, 0, w, h);
                ctx.translate(centerX, centerY);

                // Clock face
                ctx.beginPath();
                ctx.arc(0, 0, radius, 0, 2 * Math.PI);
                ctx.fillStyle = "#222";
                ctx.fill();
                ctx.lineWidth = 6;
                ctx.strokeStyle = "#fff";
                ctx.stroke();

                // Hour tick marks + numbers
                for (var i = 0; i < 12; ++i) {
                    var angle = (Math.PI / 6) * i;
                    var x1 = Math.cos(angle) * (radius * 0.9);
                    var y1 = Math.sin(angle) * (radius * 0.9);
                    var x2 = Math.cos(angle) * (radius * 0.8);
                    var y2 = Math.sin(angle) * (radius * 0.8);

                    ctx.beginPath();
                    ctx.moveTo(x1, y1);
                    ctx.lineTo(x2, y2);
                    ctx.lineWidth = 3;
                    ctx.strokeStyle = "#aaa";
                    ctx.stroke();

                    // Numbers
                    var numX = Math.cos(angle - Math.PI / 2) * (radius * 0.7);
                    var numY = Math.sin(angle - Math.PI / 2) * (radius * 0.7);
                    ctx.font = radius * 0.12 + "px sans-serif";
                    ctx.fillStyle = "#fff";
                    ctx.textAlign = "center";
                    ctx.textBaseline = "middle";
                    ctx.fillText(((i + 3) % 12 + 1).toString(), numX, numY);
                }

                // Time now
                var now = new Date();
                var hour = now.getHours() % 12;
                var minute = now.getMinutes();
                var second = now.getSeconds();

                // Hour hand
                ctx.save();
                ctx.rotate((Math.PI / 6) * (hour + minute / 60));
                ctx.beginPath();
                ctx.moveTo(0, 10);
                ctx.lineTo(0, -radius * 0.5);
                ctx.lineWidth = 8;
                ctx.lineCap = "round";
                ctx.strokeStyle = "#fff";
                ctx.stroke();
                ctx.restore();

                // Minute hand
                ctx.save();
                ctx.rotate((Math.PI / 30) * (minute + second / 60));
                ctx.beginPath();
                ctx.moveTo(0, 15);
                ctx.lineTo(0, -radius * 0.75);
                ctx.lineWidth = 6;
                ctx.lineCap = "round";
                ctx.strokeStyle = "#fff";
                ctx.stroke();
                ctx.restore();

                // Second hand
                ctx.save();
                ctx.rotate((Math.PI / 30) * second);
                ctx.beginPath();
                ctx.moveTo(0, 20);
                ctx.lineTo(0, -radius * 0.85);
                ctx.lineWidth = 2;
                ctx.strokeStyle = "#ff3c3c";
                ctx.stroke();
                ctx.restore();

                // Center circle
                ctx.beginPath();
                ctx.arc(0, 0, 8, 0, 2 * Math.PI);
                ctx.fillStyle = "#fff";
                ctx.fill();
            }

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: analogClock.requestPaint()
            }

            MouseArea {
                anchors.fill: parent
                onClicked: showAnalogClock = false
            }
        }
    }
}
