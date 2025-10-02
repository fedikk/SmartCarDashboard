import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Effects
import QtMultimedia 6.9

Item {
    width: parent.width
    height: parent.height
    property int currentIndex: 0
    property bool isFavorit: false
    property bool isplaying: false
    property bool repeatEnabled: false
    property bool manualChange: false
    property bool isMuted: false

    function msToTime(ms) {
        var totalSeconds = Math.floor(ms / 1000);
        var minutes = Math.floor(totalSeconds / 60);
        var seconds = totalSeconds % 60;
        return minutes + ":" + (seconds < 10 ? "0" + seconds : seconds);
    }


    // Base sizes
    property real baseSize: 300 // main album width
    property real sideSize: baseSize * 0.85     // size for side albums
    property real smallSize: baseSize * 0.65    // size for 2nd side albums
    property real spacing: -baseSize * 0.25      // spacing between albums
    property var albums: [
        {
            title: "ya hasra - BALTI",
            image: "file:///C:/Users/fedikk/Documents/Cockpit/images/balti1.jpg",
            audio: "file:///C:/Users/fedikk/Documents/Cockpit/audio/BaltiYaHasra.mp3"
        },
        {
            title: "3ayech Maak - SAMARA",
            image: "file:///C:/Users/fedikk/Documents/Cockpit/images/samara1.jpg",
            audio: "file:///C:/Users/fedikk/Documents/Cockpit/audio/3ayechMaak.mp3"
        },
        {
            title: "Manabrach - SAMARA",
            image: "file:///C:/Users/fedikk/Documents/Cockpit/images/samara2.jpg",
            audio: "file:///C:/Users/fedikk/Documents/Cockpit/audio/SamaraManabrach.mp3"
        },
        {
            title: "Alo Alo - BALTI",
            image: "file:///C:/Users/fedikk/Documents/Cockpit/images/balti2.jpg",
            audio: "file:///C:/Users/fedikk/Documents/Cockpit/audio/BaltiAllo.mp3"
        },
        {
            title: "Layem - Nordo",
            image: "file:///C:/Users/fedikk/Documents/Cockpit/images/nordo.jpg",
            audio: "file:///C:/Users/fedikk/Documents/Cockpit/audio/layem.mp3"
        },
        {
            title: "KIFKIF - Kaso Feat Empire",
            image: "file:///C:/Users/fedikk/Documents/Cockpit/images/kaso2.jpg",
            audio: "file:///C:/Users/fedikk/Documents/Cockpit/audio/Kifkif.mp3"
        },
        {
            title: "THANNA - Kaso",
            image: "file:///C:/Users/fedikk/Documents/Cockpit/images/kaso.jpg",
            audio: "file:///C:/Users/fedikk/Documents/Cockpit/audio/THANNA.mp3"
        }
    ]


    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "#000" }
            GradientStop { position: 0.35; color: "#132B38" }
            GradientStop { position: 0.65; color: "#132B38" }
            GradientStop { position: 1.0; color: "#000" }
        }

        z: -1
    }

    Rectangle {
        width: 180
        height: 60
        color: "transparent"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 20
        anchors.rightMargin: 20
        z: 100  // Make sure it's on top of other elements

        Row {
            spacing: 10
            anchors.verticalCenter: parent.verticalCenter
            // 👤 User Name
            Text {
                text: "Fedikouki"  // Replace with your user name
                color: "white"
                font.pixelSize: 16
                verticalAlignment: Text.AlignVCenter
                anchors.top: parent.top
                anchors.topMargin: 10
            }
            // 🖼 Circular Image
            Rectangle {
                width: 40
                height: 40
                radius: 20
                clip: true
                border.color: "#ffffff"
                border.width: 2

                Image {
                    anchors.fill: parent
                    source: "file:///C:/Users/fedikk/Documents/Cockpit/images/usericon.png"  // replace with your user image
                    fillMode: Image.PreserveAspectCrop
                }
            }
        }
    }

    Column {
        anchors.fill: parent
        spacing: 20
        anchors.margins: 40
        // 🎵 Album Cards Row (2nd Prev-Prev - Current - Next-2nd Next)
        // Replace your Row with this Item container
        Item {
            id: albumContainer
            width: parent.width
            height: parent.height * 0.5  // Half of screen height
            anchors.top: parent.top
            anchors.topMargin: 100

            //Audio player
            MediaPlayer {
                id: audioplayer
                source: "file:///C:/Users/fedikk/Documents/Cockpit/audio/BaltiYaHasra.mp3"
                audioOutput: AudioOutput {
                    id: output
                }
                loops: repeatEnabled ? MediaPlayer.Infinite : 1
                onPlaybackStateChanged: {
                    if (playbackState === MediaPlayer.StoppedState && isplaying) {
                        if (repeatEnabled) {
                            audioplayer.play();  // Repeat same song
                        } else {
                            if (!manualChange) {
                                currentIndex = (currentIndex + 1) % albums.length
                                audioplayer.source = albums[currentIndex].audio
                                audioplayer.play()
                            } else {
                                manualChange = false  // Reset flag after manual change handled
                            }
                        }
                    }
                }


            }

            // 2nd Previous album
            Rectangle {
                width: smallSize
                height: smallSize
                radius: 15
                color: "transparent"
                opacity: 0.6
                anchors.verticalCenter: parent.verticalCenter
                x: albumContainer.width / 2 - (baseSize + smallSize*1.15)
                Image {
                    anchors.fill: parent
                    anchors.margins: 5
                    source: albums[(currentIndex - 2 + albums.length) % albums.length].image
                    fillMode: Image.PreserveAspectFit
                }
            }

            // Previous album
            Rectangle {
                width: sideSize
                height: sideSize
                radius: 15
                color: "transparent"
                opacity: 1
                anchors.verticalCenter: parent.verticalCenter
                x: albumContainer.width / 2 - (baseSize / 2 + spacing*0.5 + sideSize)

                Image {
                    anchors.fill: parent
                    anchors.margins: 5
                    source: albums[(currentIndex - 1 + albums.length) % albums.length].image
                    fillMode: Image.PreserveAspectFit
                }
            }

            Rectangle {
                id: albumCard
                width: baseSize
                height: baseSize
                radius: 10
                color: "#011f4b"
                anchors.verticalCenter: parent.verticalCenter
                x: albumContainer.width / 2 - baseSize / 2
                z: 10
                clip: true  // Important to ensure video doesn't overflow


                // 🎨 Album image on top
                Image {
                    anchors.fill: parent
                    anchors.margins: 5
                    source: albums[currentIndex].image
                    fillMode: Image.PreserveAspectFit
                    z: 1
                }

                // 💡 Visual effect layer if needed
                MultiEffect {
                    anchors.fill: parent
                    source: albumCard
                    z: 2
                }

            }

            Rectangle {
                width: 290
                height: 310
                color: "TRANSPARENT"
                z:-2
                anchors.verticalCenter: parent.verticalCenter-50
                x: albumContainer.width / 2 - baseSize / 2 + 5
                y: -120

                MediaPlayer {
                    id: player
                    source: "file:///C:/Users/fedikk/Documents/Cockpit/videos/test.mp4"
                    videoOutput: videoOutput
                    autoPlay: true
                    loops: MediaPlayer.Infinite
                }

                VideoOutput {
                    id: videoOutput
                    anchors.fill: parent
                    visible: isplaying
                    anchors.top:albumCard.top
                }
            }

            // Next album
            Rectangle {
                width: sideSize
                height: sideSize
                radius: 15
                color: "transparent"
                opacity: 1
                anchors.verticalCenter: parent.verticalCenter
                x: albumContainer.width / 2 + baseSize / 2 + spacing*0.5
                z: 5

                Image {
                    anchors.fill: parent
                    anchors.margins: 5
                    source: albums[(currentIndex + 1) % albums.length].image
                    fillMode: Image.PreserveAspectFit
                }
            }

            // 2nd Next album
            Rectangle {
                width: smallSize
                height: smallSize
                radius: 15
                color: "transparent"
                opacity: 0.6
                anchors.verticalCenter: parent.verticalCenter
                x: albumContainer.width / 2 + baseSize / 2 + spacing  + smallSize*1.25
                z: 2

                Image {
                    anchors.fill: parent
                    anchors.margins: 5
                    source: albums[(currentIndex + 2) % albums.length].image
                    fillMode: Image.PreserveAspectFit
                }
            }
        }


        // 🧱 Spacer (optional)
        Item {
            id: spacer
        }

        // 🎛️ Music Info + Controls at Bottom
        Rectangle {
            id: controlpanel
            width: parent.width -80
            height: 170
            radius: 30
            color: "#011f4b"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            Image {
                anchors.fill: parent
                source: "file:///C:/Users/fedikk/Documents/Cockpit/images/bg.jpg"
                fillMode: Image.PreserveAspectCrop  // or Image.Stretch or PreserveAspectFit as needed
                smooth: true
            }

            z: -1
            Column {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: albums[currentIndex].title
                    color: "white"
                    font.pixelSize: 25
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                    wrapMode: Text.Wrap
                }




                Row {
                    spacing: 30
                    // anchors.horizontalCenter: parent.horizontalCenter

                    // ⏮ Previous
                    Column {
                        spacing: 5
                        anchors.top:parent.top
                        anchors.topMargin: 15
                        Image {
                            source: "file:///C:/Users/fedikk/Documents/Cockpit/images/privious.png"
                            width: 32
                            height: 32
                            fillMode: Image.PreserveAspectFit
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    manualChange = true
                                    currentIndex = (currentIndex === 0) ? albums.length - 1 : currentIndex - 1
                                    audioplayer.source = albums[currentIndex].audio
                                    audioplayer.play()
                                    isplaying = true
                                    player.play()
                                }


                            }
                        }
                    }

                    // ⏯ Play
                    Image {
                        id: playimg
                        source: !isplaying? "file:///C:/Users/fedikk/Documents/Cockpit/images/play.png" : "file:///C:/Users/fedikk/Documents/Cockpit/images/pause.png"
                        width: 64
                        height: 64
                        fillMode: Image.PreserveAspectFit
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                isplaying= !isplaying
                                if (isplaying) {
                                    audioplayer.source = albums[currentIndex].audio
                                    audioplayer.play()
                                    } else {
                                        audioplayer.pause()
                                    }
                            }
                        }
                    }



                    // ⏭ Next (wrapped in Column for vertical control)
                    Column {
                        spacing: 5
                        anchors.top:parent.top
                        anchors.topMargin: 15
                        Image {
                            source: "file:///C:/Users/fedikk/Documents/Cockpit/images/next.png"
                            width: 32
                            height: 32
                            fillMode: Image.PreserveAspectFit
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    manualChange = true
                                    currentIndex = (currentIndex === albums.length - 1) ? 0 : currentIndex + 1
                                    audioplayer.source = albums[currentIndex].audio
                                    audioplayer.play()
                                    isplaying = true
                                    player.play()
                                }



                            }
                        }
                    }

                    // 🔁 Repeat (same idea)
                    Column {
                        spacing: 5
                        anchors.top:parent.top
                        anchors.topMargin: 15

                        Image {
                            source: repeatEnabled ?
                                "file:///C:/Users/fedikk/Documents/Cockpit/images/repeaton.png" :
                                "file:///C:/Users/fedikk/Documents/Cockpit/images/repeat.png"

                            width: 32
                            height: 32
                            fillMode: Image.PreserveAspectFit
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    repeatEnabled = !repeatEnabled
                                    console.log("Repeat mode: " + repeatEnabled)
                                }
                            }
                        }
                    }



                    //Favorite
                    Column {
                        spacing: 5
                        anchors.top:parent.top
                        anchors.topMargin: 15
                    Image {
                        source: isFavorit? "file:///C:/Users/fedikk/Documents/Cockpit/images/hearton.png":"file:///C:/Users/fedikk/Documents/Cockpit/images/heart.png"
                        width: 32
                        height: 32
                        fillMode: Image.PreserveAspectFit
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                isFavorit= !isFavorit
                                console.log("love clicked")
                            }
                        }
                    }
                    }

                    //Spacer
                    // Spacer that pushes the volume control to the far right
                        Item {
                            id: spacerItem
                            width: controlpanel.width/2.5   //3.4
                            height: 1
                        }

                        //Favorite
                        Column {
                            spacing: 5
                            anchors.top:parent.top
                            anchors.topMargin: 15
                        Image {
                            source:((mySlider.value===0)||(isMuted))?"file:///C:/Users/fedikk/Documents/Cockpit/images/volume-mute.png":"file:///C:/Users/fedikk/Documents/Cockpit/images/volume.png"
                            width: 32
                            height: 32
                            fillMode: Image.PreserveAspectFit
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if(isMuted===true){
                                       mySlider.value=5
                                    }
                                    else {
                                        mySlider.value=0
                                    }

                                    isMuted=!isMuted

                                }
                            }
                        }
                        }
                    //Volume Slider
                    Column
                    {
                        spacing: 5
                        anchors.top:parent.top
                        anchors.topMargin: 20

                        width:200

                        Slider
                        {
                            id: mySlider
                            width: parent.width * 0.8
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
                                color: "#b3cde0"

                                Rectangle
                                {
                                    width: mySlider.visualPosition == 0 ? 0 : mySlider.handle.x  + mySlider.handle.width / 2
                                    height: parent.height
                                    color: "#ffffff"
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
                                color: mySlider.pressed ? "#fff" : "#011f4b"
                                border.color: "#ffffff"
                                border.width: 2
                            }
                        }
                    }
                }
                Row {
                    width: parent.width * 0.8
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: 10

                    // Current time text
                    Text {
                        text: msToTime(audioplayer.position)
                        color: "white"
                        font.pixelSize: 14
                        width: 50
                        horizontalAlignment: Text.AlignLeft
                    }

                    // Slider grows to fill available space
                    Slider {
                        id: songSlider
                        from: 0
                        to: audioplayer.duration > 0 ? audioplayer.duration : 1
                        value: audioplayer.position
                        width: parent.width - 110   // total width minus widths of two Texts + spacing
                        onMoved: {
                            audioplayer.position = songSlider.value

                        }

                        background: Rectangle {
                            x: songSlider.leftPadding
                            y: songSlider.topPadding + songSlider.availableHeight / 2 - height / 2
                            implicitWidth: 200
                            implicitHeight: 10
                            width: songSlider.availableWidth
                            height: implicitHeight
                            radius: height / 2
                            color: "#b3cde0"

                            Rectangle {
                                width: songSlider.visualPosition === 0 ? 0 : songSlider.handle.x + songSlider.handle.width / 2
                                height: parent.height
                                color: "#ffffff"
                                radius: height / 2
                            }
                        }

                        handle: Rectangle {
                            x: songSlider.leftPadding + songSlider.visualPosition * (songSlider.availableWidth - width)
                            y: songSlider.topPadding + songSlider.availableHeight / 2 - height / 2
                            implicitHeight: 20
                            implicitWidth: 20
                            radius: implicitWidth / 2
                            color: songSlider.pressed ? "#fff" : "#011f4b"
                            border.color: "#ffffff"
                            border.width: 2
                        }
                    }

                    // Total duration text
                    Text {
                        text: msToTime(audioplayer.duration)
                        color: "white"
                        font.pixelSize: 14
                        width: 50
                        horizontalAlignment: Text.AlignRight
                    }
                }

            }

        }

    }
}
