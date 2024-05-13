// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
//import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

import QtQuick.Window 2.15

import Process

// main.qml

// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Layouts 1.15
// import QtQuick.Window 2.15

// Window {
//     visible: true
//     width: 400
//     height: 300
//     title: "Live Weather"

//     property string city: "YOUR_CITY_NAME"
//     property string weatherAPI: "https://www.metaweather.com/api/location/search/?query="
//     property var weatherData: []

//     Rectangle {
//         anchors.fill: parent
//         color: "lightblue"

//         ColumnLayout {
//             anchors.centerIn: parent
//             spacing: 10

//             Text {
//                 text: "City: " + city
//                 font.pixelSize: 20
//                 color: "white"
//                 horizontalAlignment: Text.AlignHCenter
//             }

//             Text {
//                 text: "Temperature: " + (weatherData.length > 0 ? weatherData[0].the_temp.toFixed(1) + "°C" : "N/A")
//                 font.pixelSize: 20
//                 color: "white"
//                 horizontalAlignment: Text.AlignHCenter
//             }

//             Text {
//                 text: "Weather: " + (weatherData.length > 0 ? weatherData[0].weather_state_name : "N/A")
//                 font.pixelSize: 20
//                 color: "white"
//                 horizontalAlignment: Text.AlignHCenter
//             }
//         }
//     }

//     Timer {
//         interval: 600000 // Update every 10 minutes
//         running: true
//         repeat: true
//         onTriggered: updateWeather()
//         Component.onCompleted: updateWeather()
//     }

//     function updateWeather() {
//         var xhr = new XMLHttpRequest();
//         xhr.onreadystatechange = function() {
//             if (xhr.readyState === XMLHttpRequest.DONE) {
//                 if (xhr.status === 200) {
//                     var response = JSON.parse(xhr.responseText);
//                     if (response.length > 0) {
//                         var woeid = response[0].woeid;
//                         fetchWeatherData(woeid);
//                     } else {
//                         console.error("City not found:", city);
//                     }
//                 } else {
//                     console.error("Failed to fetch weather data:", xhr.statusText);
//                 }
//             }
//         };
//         xhr.open("GET", weatherAPI + city);
//         xhr.send();
//     }

//     function fetchWeatherData(woeid) {
//         var weatherXhr = new XMLHttpRequest();
//         weatherXhr.onreadystatechange = function() {
//             if (weatherXhr.readyState === XMLHttpRequest.DONE) {
//                 if (weatherXhr.status === 200) {
//                     var weatherResponse = JSON.parse(weatherXhr.responseText);
//                     if (weatherResponse.hasOwnProperty('consolidated_weather') && weatherResponse.consolidated_weather.length > 0) {
//                         weatherData = weatherResponse.consolidated_weather;
//                     } else {
//                         console.error("Weather data not found or empty.");
//                     }
//                 } else {
//                     console.error("Failed to fetch weather data:", weatherXhr.statusText);
//                 }
//             }
//         };
//         weatherXhr.open("GET", "https://www.metaweather.com/api/location/" + woeid + "/");
//         weatherXhr.send();
//     }
// }





// //Live Date and Time
// Window {
//     visible: true
//     title: "Home Watcher"
//     visibility: Window.FullScreen
//     width: Style.screenWidth
//     height: Style.screenHeight

//     Rectangle {
//         anchors.fill: parent
//         color: "lightblue"

//         ColumnLayout {
//             anchors.centerIn: parent
//             spacing: 10

//             Text {
//                 id: dateText
//                 font.pixelSize: 20
//                 color: "white"
//                 horizontalAlignment: Text.AlignHCenter
//                 text: new Date().toLocaleDateString() // Initialize with current date
//             }

//             Text {
//                 id: timeText
//                 font.pixelSize: 30
//                 color: "white"
//                 horizontalAlignment: Text.AlignHCenter
//                 text: new Date().toLocaleTimeString() // Initialize with current time
//             }
//         }
//     }

//     Timer {
//         interval: 1000 // Update every second
//         running: true
//         repeat: true
//         onTriggered: {
//             dateText.text = new Date().toLocaleDateString()
//             timeText.text = new Date().toLocaleTimeString()
//         }
//     }
// }


Window {

    //id: root
    visible: true

    title: "Home Watcher"
    visibility: Window.FullScreen // Set visibility to FullScreen
    width: Style.screenWidth
    height: Style.screenHeight

    //color: palette.window

    Process {
        id: cmd
        property string output: ""

    }

    // StackView to manage navigation
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: mainPageContent
    }



    // Main page
    Page {
        id: mainPageContent
        title: "Main Page"

        Rectangle {
            anchors.fill: parent
            color: "white"
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 10

                Text {
                    id: dateText
                    font.pixelSize: 20
                    color: "black"
                    horizontalAlignment: Text.AlignHCenter
                    text: new Date().toLocaleDateString() // Initialize with current date
                }

                Text {
                    id: timeText
                    font.pixelSize: 30
                    color: "black"
                    horizontalAlignment: Text.AlignHCenter
                    text: new Date().toLocaleTimeString() // Initialize with current time
                }
            }
        }

        Timer {
            interval: 1000 // Update every second
            running: true
            repeat: true
            onTriggered: {
                dateText.text = new Date().toLocaleDateString()
                timeText.text = new Date().toLocaleTimeString()
            }
        }

        Button {
            text: "Door"


            width:parent.width/4
            height:parent.height/3
            // Set margins for the button

            anchors {
                left: parent.left
                //right: parent.right
                top: parent.top
                //bottom: parent.bottom
                leftMargin: parent.width/8
                //rightMargin: 20
                topMargin: parent.height/8
                //bottomMargin: 20
            }


            contentItem: Image {
                source: "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/door.png" // Specify the path to your PNG icon
                fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

            }
            background: Rectangle {
                color: "white"
                border {
                    width: 3 // Adjust border width as needed
                    color: "black" // Adjust border color as needed
                }
            }

            MouseArea {
                anchors.fill: parent // Make the MouseArea cover the entire button
                cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                // Change cursor shape to default when mouse exits
                onExited: {
                    Qt.application.setCursorShape(Qt.ArrowCursor);
                }

                onClicked: {
                    stackView.push(root)
                    // Ensure that main page buttons are hidden when navigating to other pages
                    //mainPageContent.visible = false
                }
            }

        }

        Button {
            text: "Bedroom"

            width:parent.width/4
            height:parent.height/3
            // Set margins for the button
            anchors {
                right: parent.right
                //right: parent.right
                top: parent.top
                //bottom: parent.bottom
                //leftMargin: 20
                rightMargin: parent.width/8
                topMargin: parent.height/8//20
                //bottomMargin: 20
            }

            contentItem: Image {
                source: "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/bedroom.png" // Specify the path to your PNG icon
                fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

            }

            background: Rectangle {
                color: "white"
                border {
                    width: 3 // Adjust border width as needed
                    color: "black" // Adjust border color as needed
                }
            }

            MouseArea {
                anchors.fill: parent // Make the MouseArea cover the entire button
                cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                // Change cursor shape to default when mouse exits
                onExited: {
                    Qt.application.setCursorShape(Qt.ArrowCursor);
                }

                onClicked: {
                    stackView.push(page2Content)
                    // Ensure that main page buttons are hidden when navigating to other pages
                    //mainPageContent.visible = false
                }
            }
        }

        Button {
            text: "Kitchen"


            width:parent.width/4
            height:parent.height/3
            // Set margins for the button
            anchors {
                left: parent.left
                //right: parent.right
                bottom: parent.bottom
                //bottom: parent.bottom
                leftMargin: parent.width/8
                //rightMargin: 20
                //topMargin: 20
                bottomMargin: parent.height/8
            }

            onClicked: {
                stackView.push(page3Content)
                // Ensure that main page buttons are hidden when navigating to other pages
                //mainPageContent.visible = false
            }
            contentItem: Image {
                source: "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/kitchen.png" // Specify the path to your PNG icon
                fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

            }

            background: Rectangle {
                color: "white"
                border {
                    width: 3 // Adjust border width as needed
                    color: "black" // Adjust border color as needed
                }
            }

            MouseArea {
                anchors.fill: parent // Make the MouseArea cover the entire button
                cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                // Change cursor shape to default when mouse exits
                onExited: {
                    Qt.application.setCursorShape(Qt.ArrowCursor);
                }

                onClicked: {
                    stackView.push(page2Content)
                    // Ensure that main page buttons are hidden when navigating to other pages
                    //mainPageContent.visible = false
                }
            }
        }

        Button {
            text: "Bathroom"
            width:parent.width/4
            height:parent.height/3
            // Set margins for the button
            anchors {
                right: parent.right
                //right: parent.right
                bottom: parent.bottom
                //bottom: parent.bottom
                //leftMargin: 20
                rightMargin: parent.width/8
                //topMargin: 20
                bottomMargin: parent.height/8
            }

            contentItem: Image {
                source: "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/bathtub.png" // Specify the path to your PNG icon
                fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

            }

            background: Rectangle {
                color: "white"
                border {
                    width: 3 // Adjust border width as needed
                    color: "black" // Adjust border color as needed
                }
            }

            MouseArea {
                anchors.fill: parent // Make the MouseArea cover the entire button
                cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                // Change cursor shape to default when mouse exits
                onExited: {
                    Qt.application.setCursorShape(Qt.ArrowCursor);
                }

                onClicked: {
                    stackView.push(page2Content)
                    // Ensure that main page buttons are hidden when navigating to other pages
                    //mainPageContent.visible = false
                }
            }
        }
    }


    // // Main page
    // Page {
    //     id: mainPageContent
    //     title: "Main Page"


    //     Rectangle {
    //         anchors.fill: parent
    //         color: "white"
    //         ColumnLayout {
    //             anchors.centerIn: parent
    //             spacing: 10

    //             Text {
    //                 id: dateText
    //                 font.pixelSize: 20
    //                 color: "black"
    //                 horizontalAlignment: Text.AlignHCenter
    //                 text: new Date().toLocaleDateString() // Initialize with current date
    //             }

    //             Text {
    //                 id: timeText
    //                 font.pixelSize: 30
    //                 color: "black"
    //                 horizontalAlignment: Text.AlignHCenter
    //                 text: new Date().toLocaleTimeString() // Initialize with current time
    //             }
    //         }
    //     }

    //     Timer {
    //         interval: 1000 // Update every second
    //         running: true
    //         repeat: true
    //         onTriggered: {
    //             dateText.text = new Date().toLocaleDateString()
    //             timeText.text = new Date().toLocaleTimeString()
    //         }
    //     }

    //     Button {
    //         text: "Door"


    //         width:parent.width/4
    //         height:parent.height/3
    //         // Set margins for the button

    //         anchors {
    //             left: parent.left
    //             //right: parent.right
    //             top: parent.top
    //             //bottom: parent.bottom
    //             leftMargin: parent.width/8
    //             //rightMargin: 20
    //             topMargin: parent.height/8
    //             //bottomMargin: 20
    //         }


    //         contentItem: Image {
    //             source: "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/door.png" // Specify the path to your PNG icon
    //             fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

    //         }
    //         background: Rectangle {
    //             color: "white"
    //             border {
    //                 width: 3 // Adjust border width as needed
    //                 color: "black" // Adjust border color as needed
    //             }
    //         }

    //         MouseArea {
    //             anchors.fill: parent // Make the MouseArea cover the entire button
    //             cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

    //             // Change cursor shape to default when mouse exits
    //             onExited: {
    //                 Qt.application.setCursorShape(Qt.ArrowCursor);
    //             }

    //             onClicked: {
    //                 stackView.push(root)
    //                 // Ensure that main page buttons are hidden when navigating to other pages
    //                 //mainPageContent.visible = false
    //             }
    //         }

    //     }

    //     Button {
    //         text: "Bedroom"

    //         width:parent.width/4
    //         height:parent.height/3
    //         // Set margins for the button
    //         anchors {
    //             right: parent.right
    //             //right: parent.right
    //             top: parent.top
    //             //bottom: parent.bottom
    //             //leftMargin: 20
    //             rightMargin: parent.width/8
    //             topMargin: parent.height/8//20
    //             //bottomMargin: 20
    //         }

    //         contentItem: Image {
    //             source: "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/bedroom.png" // Specify the path to your PNG icon
    //             fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

    //         }

    //         background: Rectangle {
    //             color: "white"
    //             border {
    //                 width: 3 // Adjust border width as needed
    //                 color: "black" // Adjust border color as needed
    //             }
    //         }

    //         MouseArea {
    //             anchors.fill: parent // Make the MouseArea cover the entire button
    //             cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

    //             // Change cursor shape to default when mouse exits
    //             onExited: {
    //                 Qt.application.setCursorShape(Qt.ArrowCursor);
    //             }

    //             onClicked: {
    //                 stackView.push(page2Content)
    //                 // Ensure that main page buttons are hidden when navigating to other pages
    //                 //mainPageContent.visible = false
    //             }
    //         }
    //     }

    //     Button {
    //         text: "Kitchen"


    //         width:parent.width/4
    //         height:parent.height/3
    //         // Set margins for the button
    //         anchors {
    //             left: parent.left
    //             //right: parent.right
    //             bottom: parent.bottom
    //             //bottom: parent.bottom
    //             leftMargin: parent.width/8
    //             //rightMargin: 20
    //             //topMargin: 20
    //             bottomMargin: parent.height/8
    //         }

    //         onClicked: {
    //             stackView.push(page3Content)
    //             // Ensure that main page buttons are hidden when navigating to other pages
    //             //mainPageContent.visible = false
    //         }
    //         contentItem: Image {
    //             source: "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/kitchen.png" // Specify the path to your PNG icon
    //             fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

    //         }

    //         background: Rectangle {
    //             color: "white"
    //             border {
    //                 width: 3 // Adjust border width as needed
    //                 color: "black" // Adjust border color as needed
    //             }
    //         }

    //         MouseArea {
    //             anchors.fill: parent // Make the MouseArea cover the entire button
    //             cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

    //             // Change cursor shape to default when mouse exits
    //             onExited: {
    //                 Qt.application.setCursorShape(Qt.ArrowCursor);
    //             }

    //             onClicked: {
    //                 stackView.push(page2Content)
    //                 // Ensure that main page buttons are hidden when navigating to other pages
    //                 //mainPageContent.visible = false
    //             }
    //         }
    //     }

    //     Button {
    //         text: "Bathroom"
    //         width:parent.width/4
    //         height:parent.height/3
    //         // Set margins for the button
    //         anchors {
    //             right: parent.right
    //             //right: parent.right
    //             bottom: parent.bottom
    //             //bottom: parent.bottom
    //             //leftMargin: 20
    //             rightMargin: parent.width/8
    //             //topMargin: 20
    //             bottomMargin: parent.height/8
    //         }

    //         contentItem: Image {
    //             source: "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/bathtub.png" // Specify the path to your PNG icon
    //             fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

    //         }

    //         background: Rectangle {
    //             color: "white"
    //             border {
    //                 width: 3 // Adjust border width as needed
    //                 color: "black" // Adjust border color as needed
    //             }
    //         }

    //         MouseArea {
    //             anchors.fill: parent // Make the MouseArea cover the entire button
    //             cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

    //             // Change cursor shape to default when mouse exits
    //             onExited: {
    //                 Qt.application.setCursorShape(Qt.ArrowCursor);
    //             }

    //             onClicked: {
    //                 stackView.push(page2Content)
    //                 // Ensure that main page buttons are hidden when navigating to other pages
    //                 //mainPageContent.visible = false
    //             }
    //         }
    //     }
    // }




  // Page {
    //     id: mainPageContent
    //     title: "Main Page"

    //     // Main layout dividing the window into two rectangles
    //     ColumnLayout {
    //         anchors.fill: parent
    //         spacing: 10

    //         // Upper rectangle for time and weather
    //         Rectangle {
    //             Layout.preferredHeight: parent.height * 0.33 // 1/3 of the window height
    //             color: "lightblue" // Adjust color as needed

    //             ColumnLayout {
    //                 anchors.fill: parent
    //                 spacing: 10

    //                 Text {
    //                     id: dateText
    //                     font.pixelSize: 20
    //                     color: "black"
    //                     horizontalAlignment: Text.AlignHCenter
    //                     text: new Date().toLocaleDateString() // Initialize with current date
    //                 }

    //                 Text {
    //                     id: timeText
    //                     font.pixelSize: 30
    //                     color: "black"
    //                     horizontalAlignment: Text.AlignHCenter
    //                     text: new Date().toLocaleTimeString() // Initialize with current time
    //                 }
    //             }
    //         }

    //         // Lower rectangle for buttons
    //         RowLayout {
    //             Layout.preferredHeight: parent.height * 0.66 // 2/3 of the window height
    //             spacing: 10

    //             // Lower rectangle for buttons
    //             GridLayout {
    //                 Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter // Center the grid within the rectangle
    //                 Layout.preferredHeight: parent.height * 0.66 // 2/3 of the window height
    //                 rows: 2 // 2 rows
    //                 columns: 2 // 2 columns
    //                 //spacing: 10 // Spacing between buttons

    //                 // First button
    //                 Button {
    //                     Layout.row: 0 // Row 0
    //                     Layout.column: 0 // Column 0
    //                     text: "Door"


    //                     width:parent.width/4
    //                     height:parent.height/3
    //                     // Set margins for the button

    //                     // anchors {
    //                     //     left: parent.left
    //                     //     //right: parent.right
    //                     //     top: parent.top
    //                     //     //bottom: parent.bottom
    //                     //     leftMargin: parent.width/8
    //                     //     //rightMargin: 20
    //                     //     topMargin: parent.height/8
    //                     //     //bottomMargin: 20

    //                     // }


    //                     contentItem: Image {
    //                         source: "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/door.png" // Specify the path to your PNG icon
    //                         fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

    //                     }
    //                     background: Rectangle {
    //                         color: "white"
    //                         border {
    //                             width: 3 // Adjust border width as needed
    //                             color: "black" // Adjust border color as needed
    //                         }
    //                     }

    //                     MouseArea {
    //                         anchors.fill: parent // Make the MouseArea cover the entire button
    //                         cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

    //                         // Change cursor shape to default when mouse exits
    //                         onExited: {
    //                             Qt.application.setCursorShape(Qt.ArrowCursor);
    //                         }

    //                         onClicked: {
    //                             stackView.push(root)
    //                             // Ensure that main page buttons are hidden when navigating to other pages
    //                             //mainPageContent.visible = false
    //                         }
    //                     }




    //                     // Define button properties
    //                 }

    //                 // Second button
    //                 Button {
    //                     Layout.row: 0 // Row 0
    //                     Layout.column: 1 // Column 1
    //                     // Define button properties
    //                 }

    //                 // Third button
    //                 Button {
    //                     Layout.row: 1 // Row 1
    //                     Layout.column: 0 // Column 0
    //                     // Define button properties
    //                 }

    //                 // Fourth button
    //                 Button {
    //                     Layout.row: 1 // Row 1
    //                     Layout.column: 1 // Column 1
    //                     // Define button properties
    //                 }
    //             }

    //         }
    //     }

    //     Timer {
    //         interval: 1000 // Update every second
    //         running: true
    //         repeat: true
    //         onTriggered: {
    //             dateText.text = new Date().toLocaleDateString()
    //             timeText.text = new Date().toLocaleTimeString()
    //         }
    //     }
    // }


    //Page 1
    Page
    {
        id: root
        Rectangle
        {
            width: parent.width
            height: 50
            color: "black"
        }
        Button {
            text: "Go Back"
            anchors
            {
                right: parent.right
            }
            onClicked: {
                stackView.pop()
            }
        }

        onWidthChanged:{
            Style.calculateRatio(root.width, root.height)
        }

        VideoOutput {
            id: videoOutput
            width: parent.width
            height: parent.height/0.95
            //anchors.fill: parent
            visible: !playback.playing
        }

        Popup {
            id: recorderError
            anchors.centerIn: Overlay.overlay
            Text { id: recorderErrorText }
        }

        CaptureSession {

            id: captureSession
            recorder: recorder
            audioInput: controls.audioInput
            camera: controls.camera
            screenCapture: controls.screenCapture
            windowCapture: controls.windowCapture
            videoOutput: videoOutput
        }

        MediaRecorder {
            id: recorder
            onRecorderStateChanged:
                (state) => {
                    if (state === MediaRecorder.StoppedState) {
                        root.contentOrientation = Qt.PrimaryOrientation
                        mediaList.append()
                    } else if (state === MediaRecorder.RecordingState && captureSession.camera) {
                        // lock orientation while recording and create a preview image
                        root.contentOrientation = root.screen.orientation;
                        videoOutput.grabToImage(function(res) { mediaList.mediaThumbnail = res.url })
                    }
                }
            onActualLocationChanged: (url) => { mediaList.mediaUrl = url }
            onErrorOccurred: { recorderErrorText.text = recorder.errorString; recorderError.open(); }
            outputLocation: "/home/ahmed/records"

        }

        Playback {
            id: playback
            // width: parent.width
            // height: parent.height/0.95
            anchors {
                fill: parent
                margins: 50
            }
            active: controls.capturesVisible
        }
        //////////////////////////////
        Frame {
            id: mediaListFrame
            height: parent.height*0.975
            width: 150//parent.width/10//150
            anchors.bottom: parent.bottom//controlsFrame.top

            x: controls.capturesVisible ? parent.width-150: parent.width //0 : parent.width
            background: Rectangle {
                ///anchors.fill: parent
                color: palette.base
                opacity: 0.8
            }

            Behavior on x { NumberAnimation { duration: 200 } }

            MediaList {
                id: mediaList
                height: parent.height*0.95
                width: 150
                //anchors.fill: parent

                playback: playback
            }
        }

        Frame {
            id: controlsFrame
            // width:parent.width/10
            // height:parent.height*0.95
            // anchors {
            //     left: parent.left
            //     right: parent.right
            //     bottom: parent.bottom
            // }
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                topMargin: parent.height*0.025
                //topPadding: parent.width/8
            }

            width: controls.width + Style.interSpacing * 2// + (settingsEncoder.visible? settingsEncoder.height : 0) +(settingsMetaData.visible? settingsMetaData.height : 0)

            background: Rectangle {
                //width:parent.width/10
                //height:parent.height*0.95
                // anchors.fill: parent
                color: palette.base
                opacity: 0.8
            }

            Behavior on width { NumberAnimation { duration: 100 } }

            ColumnLayout {

                //width:400//parent.width/10
                //height:400//parent.height*0.95
                //anchors.fill: parent

                Controls {
                    Layout.alignment: Qt.AlignHCenter
                    id: controls
                    recorder: recorder
                }

                StyleRectangle {
                    Layout.alignment: Qt.AlignHCenter
                    visible: controls.settingsVisible
                    width: controls.width
                    height: 1
                }

                //  SettingsEncoder {

                //      id:settingsEncoder
                //      Layout.alignment: Qt.AlignHCenter
                //      visible: controls.settingsVisible
                //      padding: Style.interSpacing
                //      recorder: recorder
                //  }

                //  SettingsMetaData {
                //      id: settingsMetaData
                //      Layout.alignment: Qt.AlignHCenter
                //      visible: !Style.isMobile() && controls.settingsVisible
                //      recorder: recorder
                // }

            }


        }

    }//End of page 1


    // Page 2
    Page {
        id: page2Content
        title: "Page 2"

        // StackView to manage navigation
        StackView {
            id: stackView2
            anchors.fill: parent
            initialItem: mainPageContent2
        }

        // Main page
        Page {
            id: mainPageContent2
            title: "Main Page"

            // Rectangle
            // {
            //     width: parent.width
            //     height: 50
            //     color: "black"
            // }
            // StackView {
            //     id: stackView3
            //     anchors.fill: parent
            //     initialItem: mainPageContent3
            // }
            Button {
                text: "Go Back"
                anchors
                {
                    //right: parent.right
                }
                onClicked: {
                    stackView.pop()
                }
            }

            Button {
                text: "Light 1"

                width:parent.width/4
                height:parent.height/4
                // Set margins for the button

                anchors {

                    left: parent.left
                    //right: parent.right
                    top: parent.top
                    //bottom: parent.bottom
                    leftMargin: parent.width/8
                    //rightMargin: 20
                    topMargin: parent.height/8
                    //bottomMargin: 20


                }

                // onClicked: {

                //     stackView.push(page2_page1Content)
                //     // Ensure that main page buttons are hidden when navigating to other pages
                //     //mainPageContent.visible = false
                // }
                MouseArea {
                    anchors.fill: parent // Make the MouseArea cover the entire button
                    cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                    // Change cursor shape to default when mouse exits
                    onExited: {
                        Qt.application.setCursorShape(Qt.ArrowCursor);
                    }

                    onClicked: {
                        // Manually trigger the onClicked event of the button
                        cmd.start("bash", ["-c", "echo '0000' | sudo -S sh -c 'echo 1 > /sys/class/leds/input3::capslock/brightness'"]);
                    }
                }
            }

            Button {
                text: "Light 2"

                width:parent.width/4
                height:parent.height/4
                // Set margins for the button
                anchors {
                    right: parent.right
                    //right: parent.right
                    top: parent.top
                    //bottom: parent.bottom
                    //leftMargin: 20
                    rightMargin: parent.width/8
                    topMargin: parent.height/8//20
                    //bottomMargin: 20
                }


                MouseArea {
                    anchors.fill: parent // Make the MouseArea cover the entire button
                    cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                    // Change cursor shape to default when mouse exits
                    onExited: {
                        Qt.application.setCursorShape(Qt.ArrowCursor);
                    }

                    onClicked: {
                        // Manually trigger the onClicked event of the button
                        cmd.start("bash", ["-c", "echo '0000' | sudo -S sh -c 'echo 1 > /sys/class/leds/input3::capslock/brightness'"]);
                    }
                }

            }

            Button {
                text: "Shutter"


                width:parent.width/4
                height:parent.height/4
                // Set margins for the button
                anchors {
                    left: parent.left
                    //right: parent.right
                    bottom: parent.bottom
                    //bottom: parent.bottom
                    leftMargin: parent.width/8
                    //rightMargin: 20
                    //topMargin: 20
                    bottomMargin: parent.height/8
                }

                // onClicked: {
                //     stackView.push(page2_page3Content)
                //     // Ensure that main page buttons are hidden when navigating to other pages
                //     //mainPageContent.visible = false
                // }
                MouseArea {
                    anchors.fill: parent // Make the MouseArea cover the entire button
                    cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                    // Change cursor shape to default when mouse exits
                    onExited: {
                        Qt.application.setCursorShape(Qt.ArrowCursor);
                    }

                    onClicked: {
                        // Manually trigger the onClicked event of the button
                        cmd.start("bash", ["-c", "echo '0000' | sudo -S sh -c 'echo 1 > /sys/class/leds/input3::capslock/brightness'"]);
                    }
                }
            }

            Button {
                text: "TV"
                width:parent.width/4
                height:parent.height/4
                // Set margins for the button
                anchors {
                    right: parent.right
                    //right: parent.right
                    bottom: parent.bottom
                    //bottom: parent.bottom
                    //leftMargin: 20
                    rightMargin: parent.width/8
                    //topMargin: 20
                    bottomMargin: parent.height/8
                }

                // onClicked: {
                //     stackView.push(page2_page4Content)
                //     // Ensure that main page buttons are hidden when navigating to other pages
                //     //mainPageContent.visible = false
                // }
                MouseArea {
                    anchors.fill: parent // Make the MouseArea cover the entire button
                    cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                    // Change cursor shape to default when mouse exits
                    onExited: {
                        Qt.application.setCursorShape(Qt.ArrowCursor);
                    }

                    onClicked: {
                        // Manually trigger the onClicked event of the button
                        cmd.start("bash", ["-c", "echo '0000' | sudo -S sh -c 'echo 1 > /sys/class/leds/input3::capslock/brightness'"]);
                    }
                }
            }
        }


        // // Page 3
        // Page {
        //     id: page2_page1Content
        //     title: "Page 3"

        //     Button {
        //         text: "Go Back"
        //         onClicked: {
        //             stackView.pop()
        //             // Show main page buttons when navigating back from other pages
        //             //mainPageContent.visible = true
        //         }
        //     }
        // }

        // // Page 2
        // Page {
        //     id: page2_page2Content
        //     title: "Page 4"

        //     Button {
        //         text: "Go Back"
        //         onClicked: {
        //             stackView.pop()
        //             // Show main page buttons when navigating back from other pages
        //             //mainPageContent.visible = true
        //         }
        //     }
        // }


        // // Page 3
        // Page {
        //     id: page2_page3Content
        //     title: "Page 3"

        //     Button {
        //         text: "Go Back"
        //         onClicked: {
        //             stackView.pop()
        //             // Show main page buttons when navigating back from other pages
        //             //mainPageContent.visible = true
        //         }
        //     }
        // }

        // // Page 4
        // Page {
        //     id: page2_page4Content
        //     title: "Page 4"

        //     Button {
        //         text: "Go Back"
        //         onClicked: {
        //             stackView.pop()
        //             // Show main page buttons when navigating back from other pages
        //             //mainPageContent.visible = true
        //         }
        //     }
        // }

        // Binding {
        //     target: page1_page2Content
        //     property: "visible"
        //     value: stackView2.currentItem === page1_page2Content
        // }

        // Binding {
        //     target: page2_page2Content
        //     property: "visible"
        //     value: stackView2.currentItem === page2_page2Content
        // }

        // Binding {
        //     target: page2_page3Content
        //     property: "visible"
        //     value: stackView2.currentItem === page2_page3Content
        // }
        // Binding {
        //     target: page2_page4Content
        //     property: "visible"
        //     value: stackView2.currentItem === page2_page4Content
        // }

    }

    // Page 3
    Page {
        id: page3Content
        title: "Page 3"

        // StackView to manage navigation
        StackView {
            id: stackView3
            anchors.fill: parent
            initialItem: mainPageContent3
        }

        // Main page
        Page {
            id: mainPageContent3
            title: "Main Page"



            Button {
                text: "Go Back"
                anchors
                {
                    //right: parent.right
                }
                onClicked: {
                    stackView.pop()
                }
            }

            Button {
                text: "Light 1"

                width:parent.width/4
                height:parent.height/4
                // Set margins for the button

                anchors {

                    left: parent.left
                    //right: parent.right
                    top: parent.top
                    //bottom: parent.bottom
                    leftMargin: parent.width/8
                    //rightMargin: 20
                    topMargin: parent.height/8
                    //bottomMargin: 20


                }


                MouseArea {
                    anchors.fill: parent // Make the MouseArea cover the entire button
                    cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                    // Change cursor shape to default when mouse exits
                    onExited: {
                        Qt.application.setCursorShape(Qt.ArrowCursor);
                    }

                    onClicked: {
                        // Manually trigger the onClicked event of the button
                        cmd.start("bash", ["-c", "echo '0000' | sudo -S sh -c 'echo 1 > /sys/class/leds/input3::capslock/brightness'"]);
                    }
                }
            }

            Button {
                text: "Light 2"

                width:parent.width/4
                height:parent.height/4
                // Set margins for the button
                anchors {
                    right: parent.right
                    //right: parent.right
                    top: parent.top
                    //bottom: parent.bottom
                    //leftMargin: 20
                    rightMargin: parent.width/8
                    topMargin: parent.height/8//20
                    //bottomMargin: 20
                }


                MouseArea {
                    anchors.fill: parent // Make the MouseArea cover the entire button
                    cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                    // Change cursor shape to default when mouse exits
                    onExited: {
                        Qt.application.setCursorShape(Qt.ArrowCursor);
                    }

                    onClicked: {
                        // Manually trigger the onClicked event of the button
                        cmd.start("bash", ["-c", "echo '0000' | sudo -S sh -c 'echo 1 > /sys/class/leds/input3::capslock/brightness'"]);
                    }
                }

            }

            Button {
                text: "Shutter"


                width:parent.width/4
                height:parent.height/4
                // Set margins for the button
                anchors {
                    left: parent.left
                    //right: parent.right
                    bottom: parent.bottom
                    //bottom: parent.bottom
                    leftMargin: parent.width/8
                    //rightMargin: 20
                    //topMargin: 20
                    bottomMargin: parent.height/8
                }


                MouseArea {
                    anchors.fill: parent // Make the MouseArea cover the entire button
                    cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                    // Change cursor shape to default when mouse exits
                    onExited: {
                        Qt.application.setCursorShape(Qt.ArrowCursor);
                    }

                    onClicked: {
                        // Manually trigger the onClicked event of the button
                        cmd.start("bash", ["-c", "echo '0000' | sudo -S sh -c 'echo 1 > /sys/class/leds/input3::capslock/brightness'"]);
                    }
                }
            }

            Button {
                text: "TV"
                width:parent.width/4
                height:parent.height/4
                // Set margins for the button
                anchors {
                    right: parent.right
                    //right: parent.right
                    bottom: parent.bottom
                    //bottom: parent.bottom
                    //leftMargin: 20
                    rightMargin: parent.width/8
                    //topMargin: 20
                    bottomMargin: parent.height/8
                }


                MouseArea {
                    anchors.fill: parent // Make the MouseArea cover the entire button
                    cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                    // Change cursor shape to default when mouse exits
                    onExited: {
                        Qt.application.setCursorShape(Qt.ArrowCursor);
                    }

                    onClicked: {
                        // Manually trigger the onClicked event of the button
                        cmd.start("bash", ["-c", "echo '0000' | sudo -S sh -c 'echo 1 > /sys/class/leds/input3::capslock/brightness'"]);
                    }
                }
            }
        }

    }

    Page {
        id: page4Content
        title: "Page 3"

        // StackView to manage navigation
        StackView {
            id: stackView4
            anchors.fill: parent
            initialItem: mainPageContent4
        }

        // Main page
        Page {
            id: mainPageContent4
            title: "Main Page"

            Button {
                text: "Go Back"
                anchors
                {
                    //right: parent.right
                }
                onClicked: {
                    stackView.pop()
                }
            }

            Button {
                text: "Light 1"

                width:parent.width/4
                height:parent.height/4
                // Set margins for the button

                anchors {

                    left: parent.left
                    //right: parent.right
                    top: parent.top
                    //bottom: parent.bottom
                    leftMargin: parent.width/8
                    //rightMargin: 20
                    topMargin: parent.height/8
                    //bottomMargin: 20


                }

                MouseArea {
                    anchors.fill: parent // Make the MouseArea cover the entire button
                    cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                    // Change cursor shape to default when mouse exits
                    onExited: {
                        Qt.application.setCursorShape(Qt.ArrowCursor);
                    }

                    onClicked: {
                        // Manually trigger the onClicked event of the button
                        cmd.start("bash", ["-c", "echo '0000' | sudo -S sh -c 'echo 1 > /sys/class/leds/input3::capslock/brightness'"]);
                    }
                }
            }

            Button {
                text: "Light 2"

                width:parent.width/4
                height:parent.height/4
                // Set margins for the button
                anchors {
                    right: parent.right
                    //right: parent.right
                    top: parent.top
                    //bottom: parent.bottom
                    //leftMargin: 20
                    rightMargin: parent.width/8
                    topMargin: parent.height/8//20
                    //bottomMargin: 20
                }


                MouseArea {
                    anchors.fill: parent // Make the MouseArea cover the entire button
                    cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                    // Change cursor shape to default when mouse exits
                    onExited: {
                        Qt.application.setCursorShape(Qt.ArrowCursor);
                    }

                    onClicked: {
                        // Manually trigger the onClicked event of the button
                        cmd.start("bash", ["-c", "echo '0000' | sudo -S sh -c 'echo 1 > /sys/class/leds/input3::capslock/brightness'"]);
                    }
                }

            }

            Button {
                text: "Shutter"

                width:parent.width/4
                height:parent.height/4
                // Set margins for the button
                anchors {
                    left: parent.left
                    //right: parent.right
                    bottom: parent.bottom
                    //bottom: parent.bottom
                    leftMargin: parent.width/8
                    //rightMargin: 20
                    //topMargin: 20
                    bottomMargin: parent.height/8
                }

                MouseArea {
                    anchors.fill: parent // Make the MouseArea cover the entire button
                    cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                    // Change cursor shape to default when mouse exits
                    onExited: {
                        Qt.application.setCursorShape(Qt.ArrowCursor);
                    }

                    onClicked: {
                        // Manually trigger the onClicked event of the button
                        cmd.start("bash", ["-c", "echo '0000' | sudo -S sh -c 'echo 1 > /sys/class/leds/input3::capslock/brightness'"]);
                    }
                }
            }

            Button {
                text: "TV"
                width:parent.width/4
                height:parent.height/4
                // Set margins for the button
                anchors {
                    right: parent.right
                    //right: parent.right
                    bottom: parent.bottom
                    //bottom: parent.bottom
                    //leftMargin: 20
                    rightMargin: parent.width/8
                    //topMargin: 20
                    bottomMargin: parent.height/8
                }

                MouseArea {
                    anchors.fill: parent // Make the MouseArea cover the entire button
                    cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                    // Change cursor shape to default when mouse exits
                    onExited: {
                        Qt.application.setCursorShape(Qt.ArrowCursor);
                    }

                    onClicked: {
                        // Manually trigger the onClicked event of the button
                        cmd.start("bash", ["-c", "echo '0000' | sudo -S sh -c 'echo 1 > /sys/class/leds/input3::capslock/brightness'"]);
                    }
                }
            }
        }

    }

    // Toggle button visibility based on current item
    Binding {
        target: mainPageContent
        property: "visible"
        value: stackView.currentItem === mainPageContent
    }

    Binding {
        target: root
        property: "visible"
        value: stackView.currentItem === root
    }

    Binding {
        target: page2Content
        property: "visible"
        value: stackView.currentItem === page2Content
    }

    Binding {
        target: page3Content
        property: "visible"
        value: stackView.currentItem === page3Content
    }
    Binding {
        target: page4Content
        property: "visible"
        value: stackView.currentItem === page4Content
    }
}
