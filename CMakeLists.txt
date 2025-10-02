cmake_minimum_required(VERSION 3.16)

project(Cockpit VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Quick3D)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appCockpit
    main.cpp
)

qt_add_qml_module(appCockpit
    URI Cockpit
    VERSION 1.0
    QML_FILES
        Main.qml


        images/navbar/home.png images/navbar/homeon.png images/navbar/park.png images/navbar/parkon.png
        images/navbar/music.png images/navbar/musicon.png images/navbar/map.png images/navbar/mapon.png
        images/navbar/phone.png images/navbar/phoneon.png images/navbar/film.png images/navbar/filmon.png

        QML_FILES Home.qml
        QML_FILES WeatherUtils.js
        QML_FILES Clock.qml
        images/meteo/01d@2x.png images/meteo/02d@2x.png images/meteo/03d@2x.png images/meteo/04d@2x.png images/meteo/09d@2x.png images/meteo/10d@2x.png images/meteo/11d@2x.png
        images/meteo/13d@2x.png images/meteo/50d@2x.png images/meteo/clearbg.jpg images/meteo/rainbg.png
        images/meteo/01n@2x.png images/meteo/02n@2x.png images/meteo/03n@2x.png images/meteo/04n@2x.png images/meteo/09n@2x.png images/meteo/10n@2x.png images/meteo/11n@2x.png
        images/meteo/13n@2x.png images/meteo/50n@2x.png images/meteo/clearbg.jpg images/meteo/rainbg.png




        QML_FILES music.qml
        RESOURCES images/balti1.jpg
        images/balti2.jpg images/nordo.jpg images/samara1.jpg images/samara2.jpg images/pause.png images/play.png
        images/next.png images/privious.png images/kaso.jpg images/kaso2.jpg
        images/repeat.png images/repeaton.png images/heart.png images/hearton.png
        videos/test.mp4
        audio/3ayechmaak.mp3
        audio/SamaraManabrach.mp3 audio/THANNA.mp3
        audio/BaltiYaHasra.mp3 audio/BaltiAllo.mp3 audio/layem.mp3 audio/Kifkif.mp3
        images/volume.png images/bg.jpg  images/volume-mute.png

        QML_FILES phonepage.qml
        QML_FILES CallingPage.qml
        images/phone/1.png images/phone/2.png images/phone/3.png images/phone/4.png images/phone/5.png images/phone/6.png images/phone/7.png images/phone/8.png images/phone/9.png
        images/phone/10.png images/phone/11.png images/phone/12.png images/phone/phone-call.png images/phone/delete.png
        images/phone/microphone.png images/phone/calloff.png images/phone/label_keypad.png images/phone/speaker.png images/phone/microphoneoff.png images/phone/bluetooth.png
        images/phone/hold.png images/usericon.png

        QML_FILES Films.qml
        QML_FILES Filmselection.qml
        images/Film/liloandstitch.jpg images/Film/stitchtitle.png images/Film/stitchbg.png
        images/Film/openheimer.jpg  images/Film/openheimerbg.png images/Film/openheimertitle.png
        images/Film/venom.jpg images/Film/venombg.jpg images/Film/venomtitle.png
        images/Film/missionimpo.jpg images/Film/missionimpobg.jpg images/Film/missionimpotitle.png
        images/Film/howtotrain.jpg images/Film/howtotrainbg.jpg images/Film/howtotraintitle.png
        images/Film/time.png images/Film/year.png images/Film/star.png images/Film/staroff.png
        images/Film/beekeep.jpg images/Film/beekeepbg.jpg images/Film/beekeeptitle.png
        images/Film/deepcover.jpg images/Film/mincraftmovie.jpg images/Film/jurrasicworld.jpg
        images/Film/f4.jpg images/Film/zootopia.jpg
        images/Film/play.png

        QML_FILES Parking.qml
        images/Park/car.png images/Park/car2.png images/Park/car2lightfront.png images/Park/car2lightback.png images/Park/car2lightall.png
        images/Park/road.jpg images/Park/frame.png images/Park/steeringwheel.png




        QML_FILES settings.qml
        images/settings/seat0.png images/settings/seat1.png images/settings/seat2.png images/settings/seat3.png images/settings/reardef.png images/settings/frontdef.png
        images/settings/freshair.png images/settings/resair.png





)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appCockpit PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appCockpit
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appCockpit
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appCockpit
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
