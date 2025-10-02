import QtQuick 2.15

Item {
    id: root
    property bool analogVisible: false
    property color primaryColor: "#00314F"
    property color secondaryColor: "#E66808"
    property int clockSize: 500

    // signal the parent when the clock was clicked (parent toggles the bound variable)
    signal toggleRequested()

    width: clockSize
    height: clockSize

    Canvas {
        id: canvas
        anchors.fill: parent
        opacity: root.analogVisible ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 400; easing.type: Easing.InOutQuad } }

        onPaint: {
            // `getContext` is available here because we are inside Canvas
            var ctx = getContext("2d")
            // guard in case ctx.reset is not available on some Qt versions
            if (ctx.reset) ctx.reset()
            var centerX = width / 2
            var centerY = height / 2
            var radius = Math.min(centerX, centerY) * 0.9

            ctx.clearRect(0, 0, width, height)

            /* Clock Face */
            ctx.beginPath()
            ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI)
            ctx.fillStyle = "#fff"
            ctx.fill()
            ctx.strokeStyle = "#fff"
            ctx.lineWidth = 5
            ctx.stroke()

            /* Hour Marks */
            for (var i = 0; i < 12; i++) {
                var angle = i * Math.PI / 6
                var innerRadius = radius * 0.85
                var outerRadius = radius * 0.95
                ctx.beginPath()
                ctx.moveTo(centerX + innerRadius * Math.sin(angle), centerY - innerRadius * Math.cos(angle))
                ctx.lineTo(centerX + outerRadius * Math.sin(angle), centerY - outerRadius * Math.cos(angle))
                ctx.strokeStyle = root.primaryColor
                ctx.lineWidth = 5
                ctx.lineCap = "round"
                ctx.stroke()
            }

            /* Clock Hands */
            var now = new Date()
            var sec = now.getSeconds()
            var min = now.getMinutes()
            var hr = now.getHours() % 12
            var secAngle = sec * Math.PI / 30
            var minAngle = (min + sec / 60) * Math.PI / 30
            var hrAngle = (hr + min / 60) * Math.PI / 6

            // Hour Hand
            ctx.beginPath()
            ctx.moveTo(centerX, centerY)
            ctx.lineTo(centerX + radius * 0.45 * Math.sin(hrAngle),
                       centerY - radius * 0.45 * Math.cos(hrAngle))
            ctx.strokeStyle = root.primaryColor
            ctx.lineWidth = 15
            ctx.stroke()

            // Minute Hand
            ctx.beginPath()
            ctx.moveTo(centerX, centerY)
            ctx.lineTo(centerX + radius * 0.65 * Math.sin(minAngle),
                       centerY - radius * 0.65 * Math.cos(minAngle))
            ctx.strokeStyle = root.primaryColor
            ctx.lineWidth = 15
            ctx.stroke()

            // Center Circle (big)
            ctx.beginPath()
            ctx.arc(centerX, centerY, 20, 0, 2 * Math.PI)
            ctx.fillStyle = root.primaryColor
            ctx.fill()

            // Second Hand
            ctx.beginPath()
            ctx.moveTo(centerX, centerY)
            ctx.lineTo(centerX + radius * 0.75 * Math.sin(secAngle),
                       centerY - radius * 0.75 * Math.cos(secAngle))
            ctx.strokeStyle = root.secondaryColor
            ctx.lineWidth = 8
            ctx.stroke()

            // Center Circle (small)
            ctx.beginPath()
            ctx.arc(centerX, centerY, 12, 0, 2 * Math.PI)
            ctx.fillStyle = root.secondaryColor
            ctx.fill()
        }

        // repaint every second
        Timer {
            interval: 1000; running: true; repeat: true
            onTriggered: canvas.requestPaint()
        }
    }

    // Let the parent own state changes. We simply ask for a toggle.
    MouseArea {
        anchors.fill: parent
        onClicked: root.toggleRequested()
        cursorShape: Qt.PointingHandCursor
    }
}
