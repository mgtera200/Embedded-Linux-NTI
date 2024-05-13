// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
//import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

import QtQuick.Window 2.15

import Process


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


        // inside Bedroom
        Page {
            id: mainPageContent2
            title: "Main Page"



            Rectangle {
                anchors.fill: parent
                color: "white"
            }
            Button {
                text: "Go Back"

                Rectangle {
                    //x:parent.width*0.0250
                    width: parent.width
                    height: parent.height*0.0250
                    //right: parent.right
                }
                anchors
                {
                    //right: parent.right
                }
                MouseArea {
                    anchors.fill: parent // Make the MouseArea cover the entire button
                    cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                    // Change cursor shape to default when mouse exits
                    onExited: {
                        Qt.application.setCursorShape(Qt.ArrowCursor);
                    }

                    onClicked: {
                        stackView.pop()
                    }
                }

            }
            // Item{
            //     id:layout
            //     anchors.fill: parent
            //     anchors {

            //         left: parent.left
            //         //right: parent.right
            //     }
            //     Rectangle {
            //         id: aside
            //         y:parent.width*0.0250
            //         width: parent.width/4
            //         height: parent.height
            //         color: "#0000FF"
            //         opacity: 0.6
            //         //left: parent.left
            //     }

            // }


            // Item {
            //     id: buttos
            //     anchors.fill: parent

            // Rectangle {
            //     x:parent.width*0.25
            //     width: parent.width*0.75
            //     height: parent.height
            //     //right: parent.right

            Button {
                text: "Lamp"

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


                width:parent.width/4
                height:parent.height/3

                contentItem: Image {

                    id: br_img
                    source: "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/lightbulbOff.png" // Specify the path to your PNG icon
                    fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

                    // Define a function to read the output and print it
                    function readOutput() {
                        //Boolean result;
                        var result = cmd.readAll().toString().trim(); // Convert to string and trim whitespace                        console.log("Command Output:", result);


                        if(result === "1")
                        {
                            br_img.source = "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/lightbulbOn.png";
                            console.log("Turn ON: ", result);

                        }
                        else
                        {
                            br_img.source = "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/lightbulbOff.png";
                            console.log("Turn OFF: ", result);

                        }


                        //return result;
                    }

                    // Define a function to handle the finished signal
                    function processFinished() {
                        // Disconnect the signals to avoid multiple connections
                        cmd.readyReadStandardOutput.disconnect(readOutput);
                        cmd.finished.disconnect(processFinished);
                    }

                    function changeImageSource() {

                        if (!('staticVar' in changeImageSource)) {

                            changeImageSource.staticVar = 0;

                        }

                        cmd.start("bash", ["-c", "cat /sys/class/leds/input3::capslock/brightness"]);

                        //cmd.start("bash", ["-c", "cat /home/ahmed/SimulateDevice/DD"]);

                        // Listen to the readyReadStandardOutput signal to get the output
                        cmd.readyReadStandardOutput.connect(readOutput);//readOutput

                        // var commandOutput = readOutput();
                        // console.log("Command Output:", commandOutput);

                        // Listen to the finished signal to indicate when the process has finished
                        cmd.finished.connect(processFinished);

                    }

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

                        br_img.changeImageSource()
                        //cmd.start("bash", ["-c", "echo '0000' | sudo -S sh -c 'echo $(($(cat /sys/class/leds/input3::capslock/brightness) ^ 1)) > /sys/class/leds/input3::capslock/brightness'"]);
                        //cmd.start("bash", ["-c", "echo $(($(cat /home/ahmed/SimulateDevice/DD) ^ 1)) > /home/ahmed/SimulateDevice/DD"]);
                    }
                }


            }

            Button {
                text: "Buzzer"

                anchors {

                    // right: parent.right
                    // left: parent.left
                    right: parent.right
                    top: parent.top
                    //bottom: parent.bottom
                    rightMargin: parent.width/8
                    //rightMargin: 20
                    topMargin: parent.height/8
                    //bottomMargin: 20
                }
                width:parent.width/4
                height:parent.height/3

                contentItem: Image {

                    id: bz_img
                    source: "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/bellOff.png" // Specify the path to your PNG icon
                    fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

                    // Define a function to read the output and print it
                    function readOutput() {
                        //Boolean result;
                        var result = cmd.readAll().toString().trim(); // Convert to string and trim whitespace                        console.log("Command Output:", result);


                        if(result === "1")
                        {
                            bz_img.source = "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/bellOn.png";
                            console.log("Turn ON: ", result);

                        }
                        else
                        {
                            bz_img.source = "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/bellOff.png";
                            console.log("Turn OFF: ", result);

                        }


                        //return result;
                    }

                    // Define a function to handle the finished signal
                    function processFinished() {
                        // Disconnect the signals to avoid multiple connections
                        cmd.readyReadStandardOutput.disconnect(readOutput);
                        cmd.finished.disconnect(processFinished);
                    }

                    function changeImageSource() {

                        if (!('staticVar' in changeImageSource)) {

                            changeImageSource.staticVar = 0;

                        }

                        cmd.start("bash", ["-c", "cat /sys/class/leds/input3::capslock/brightness"]);

                        //cmd.start("bash", ["-c", "cat /home/ahmed/SimulateDevice/DD"]);

                        // Listen to the readyReadStandardOutput signal to get the output
                        cmd.readyReadStandardOutput.connect(readOutput);//readOutput

                        // var commandOutput = readOutput();
                        // console.log("Command Output:", commandOutput);

                        // Listen to the finished signal to indicate when the process has finished
                        cmd.finished.connect(processFinished);

                    }

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

                        bz_img.changeImageSource()
                        //cmd.start("bash", ["-c", "echo '0000' | sudo -S sh -c 'echo $(($(cat /sys/class/leds/input3::capslock/brightness) ^ 1)) > /sys/class/leds/input3::capslock/brightness'"]);
                        //cmd.start("bash", ["-c", "echo $(($(cat /home/ahmed/SimulateDevice/DD) ^ 1)) > /home/ahmed/SimulateDevice/DD"]);
                    }
                }

            }

            // Button {

            //     text: "temperature"

            //     anchors {

            //         right: parent.right
            //         left: parent.left
            //         bottom: parent.bottom
            //         //bottom: parent.bottom
            //         rightMargin: parent.width/3
            //         leftMargin: parent.width/3

            //         //rightMargin: 20
            //         bottomMargin: parent.height/8
            //         //bottomMargin: 20
            //     }
            //     width:parent.width/4
            //     height:parent.height/3

            //     contentItem: Image {

            //         id: tmp_img
            //         source: "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/bellOff.png" // Specify the path to your PNG icon
            //         fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

            //         // Define a function to read the output and print it
            //         function readOutput() {
            //             //Boolean result;
            //             var result = cmd.readAll().toString().trim(); // Convert to string and trim whitespace                        console.log("Command Output:", result);


            //             if(result === "1")
            //             {
            //                 tmp_img.source = "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/bellOn.png";
            //                 console.log("Turn ON: ", result);

            //             }
            //             else
            //             {
            //                 tmp_img.source = "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/bellOff.png";
            //                 console.log("Turn OFF: ", result);

            //             }


            //             //return result;
            //         }

            //         // Define a function to handle the finished signal
            //         function processFinished() {
            //             // Disconnect the signals to avoid multiple connections
            //             cmd.readyReadStandardOutput.disconnect(readOutput);
            //             cmd.finished.disconnect(processFinished);
            //         }

            //         function changeImageSource() {

            //             if (!('staticVar' in changeImageSource)) {

            //                 changeImageSource.staticVar = 0;

            //             }

            //             cmd.start("bash", ["-c", "cat /sys/class/leds/input3::capslock/brightness"]);

            //             //cmd.start("bash", ["-c", "cat /home/ahmed/SimulateDevice/DD"]);

            //             // Listen to the readyReadStandardOutput signal to get the output
            //             cmd.readyReadStandardOutput.connect(readOutput);//readOutput

            //             // var commandOutput = readOutput();
            //             // console.log("Command Output:", commandOutput);

            //             // Listen to the finished signal to indicate when the process has finished
            //             cmd.finished.connect(processFinished);

            //         }

            //     }

            //     background: Rectangle {
            //         color: "white"
            //         border {
            //             width: 3 // Adjust border width as needed
            //             color: "black" // Adjust border color as needed
            //         }
            //     }

            //     MouseArea {
            //         anchors.fill: parent // Make the MouseArea cover the entire button
            //         cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

            //         // Change cursor shape to default when mouse exits
            //         onExited: {
            //             Qt.application.setCursorShape(Qt.ArrowCursor);
            //         }


            //         onClicked: {

            //             tmp_img.changeImageSource()
            //             //cmd.start("bash", ["-c", "echo '0000' | sudo -S sh -c 'echo $(($(cat /sys/class/leds/input3::capslock/brightness) ^ 1)) > /sys/class/leds/input3::capslock/brightness'"]);
            //             //cmd.start("bash", ["-c", "echo $(($(cat /home/ahmed/SimulateDevice/DD) ^ 1)) > /home/ahmed/SimulateDevice/DD"]);
            //         }
            //     }
            // }
            Button {
                id: temperatureButton
                text: "Temperature"
                anchors {
                    right: parent.right
                    left: parent.left
                    bottom: parent.bottom
                    rightMargin: parent.width / 3
                    leftMargin: parent.width / 3
                    bottomMargin: parent.height / 8
                }
                width: parent.width / 4
                height: parent.height / 3

                Text {
                    id: tempText
                    text: "Loading..." // Initial text before data is loaded
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16 // Adjust font size as needed
                }

                background: Rectangle {
                    color: "white"
                    border {
                        width: 3
                        color: "black"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onExited: {
                        cursorShape = Qt.ArrowCursor; // Set cursor shape to default
                    }

                    onClicked: {
                        temperatureButton.changeTemperatureText(); // Call the function using the Button's reference
                    }
                }

                function changeTemperatureText() {
                    var xhr = new XMLHttpRequest();
                    xhr.onreadystatechange = function() {
                        if (xhr.readyState === XMLHttpRequest.DONE) {
                            if (xhr.status === 200) {
                                tempText.text = xhr.responseText; // Update text with file data
                            } else {
                                console.error("Error:", xhr.statusText);
                            }
                        }
                    };
                    xhr.open("GET", "/sys/class/leds/input3::capslock/brightness"); // Path to your file
                    xhr.send();
                }
            }


        }

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
