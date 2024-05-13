// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

import QtQuick.Window 2.15

import Process


Window {

    visible: true

    title: "Home Watcher"
    visibility: Window.FullScreen // Set visibility to FullScreen
    width: Style.screenWidth
    height: Style.screenHeight

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
            color: "#F0F0F0"
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
                top: parent.top
                leftMargin: parent.width/8
                topMargin: parent.height/8
            }


            contentItem: Image {
                source: "file:./imgs/door.png"
                fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon
            }


            background: Rectangle {
                color: "#F0F0F0"
                border {
                    width: 3 // Adjust border width as needed
                    color: "#7f8c7f" // Adjust border color as needed
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
                top: parent.top
                rightMargin: parent.width/8
                topMargin: parent.height/8//20
            }

            contentItem: Image {
                source: "file:./imgs/bedroom.png" // Specify the path to your PNG icon
                fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

            }

            background: Rectangle {
                color: "#F0F0F0"
                border {
                    width: 3 // Adjust border width as needed
                    color: "#7f8c7f" // Adjust border color as needed
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
                bottom: parent.bottom
                leftMargin: parent.width/8
                bottomMargin: parent.height/8
            }

            onClicked: {
                stackView.push(page3Content)
            }
            contentItem: Image {
                source: "file:./imgs/kitchen.png" // Specify the path to your PNG icon
                fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

            }

            background: Rectangle {
                color: "#F0F0F0"
                border {
                    width: 3 // Adjust border width as needed
                    color: "#7f8c7f" // Adjust border color as needed
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
                    stackView.push(page3Content)
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
                bottom: parent.bottom
                rightMargin: parent.width/8
                bottomMargin: parent.height/8
            }

            contentItem: Image {
                source: "file:./imgs/bathtub.png" // Specify the path to your PNG icon
                fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon
            }

            background: Rectangle {
                color: "#F0F0F0"
                border {
                    width: 3 // Adjust border width as needed
                    color: "#7f8c7f" // Adjust border color as needed
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
                    stackView.push(page4Content)
                }
            }
        }


        Timer {

            interval: 10 // Update every 100 milliseconds
            running: true
            repeat: true
            property int val: 0 // Define 'val' as a property of the Timer element

            onTriggered: {
                switch(val) {
                case 0:
                    console.log("One");
                    br_img.changeImageSource()
                    val = 1;
                    break;
                case 1:
                    console.log("Two");
                    ki_br_img.changeImageSource()
                    val = 2;
                    break;
                case 2:
                    console.log("Three");
                    bt_br_img.changeImageSource()
                    val = 3;
                    break;
                case 3:
                    console.log("Four");
                    ki_br_img.changeImageSource()
                    val = 4;
                    break;
                case 4:
                    console.log("Five");
                    ki_bz_img.changeImageSource()
                    val = 5;
                    break;
                case 5:
                    console.log("Five");
                    bt_bz_img.changeImageSource()
                    val = 6;
                    break;
                case 6:
                    console.log("Six");
                    bz_img.changeImageSource()
                    val = 0;
                    break;
                default:
                    //Do Nothing
                    break;
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
            outputLocation: "./records"

        }

        Playback {
            id: playback
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
                color: palette.base
                opacity: 0.8
            }

            Behavior on x { NumberAnimation { duration: 200 } }

            MediaList {
                id: mediaList
                height: parent.height*0.95
                width: 150
                playback: playback
            }
        }

        Frame {
            id: controlsFrame
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                topMargin: parent.height*0.025
            }

            width: controls.width + Style.interSpacing * 2// + (settingsEncoder.visible? settingsEncoder.height : 0) +(settingsMetaData.visible? settingsMetaData.height : 0)

            background: Rectangle {
                color: palette.base
                opacity: 0.8
            }

            Behavior on width { NumberAnimation { duration: 100 } }

            ColumnLayout {
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


            }


        }

    }//End of page 1

    // Page 2 Bedroom
    Page {

        id: page2Content
        title: "Page 4"

        // StackView to manage navigation
        StackView {
            id: stackView2
            anchors.fill: parent
            initialItem: mainPageContent2
        }

        // Page 2
        Page {
            id: mainPageContent2
            title: "Bedroom"
            Rectangle{
                id:layout3
                anchors.fill: parent
                color:"white"

                Rectangle {
                    id: aside3
                    width: parent.width/4
                    height: parent.height
                    color: "#0000FF"
                    opacity: 0.45


                    Text{

                        text:"Ahmed"
                        color:"white"
                        font.pixelSize: 50
                        font.bold: true

                        anchors
                        {
                            top:parent.top
                            left:parent.left
                            leftMargin:150
                            topMargin:520
                        }

                    }

                }

                Rectangle
                {
                    width:200
                    height:200
                    radius:100

                    anchors
                    {

                        top:parent.top
                        left:parent.left
                        leftMargin:130
                        topMargin:300

                    }
                    Image {
                        anchors.fill: parent // Make the image fill the entire Rectangle
                        source: "file:./imgs/profile.png"        // Provide the path to your image file
                        fillMode: Image.PreserveAspectFit // Choose the fill mode as per your requirement
                    }

                }

                Rectangle {
                    id: container3
                    x: parent.width/4
                    y:0
                    width: parent.width - parent.width/4
                    height: parent.height
                    color: "white"
                    opacity: 1//0.6

                    //Back
                    Button {
                        text: "Go Back"

                        x:50
                        y:3
                        width: 100//parent.width
                        height: 100//parent.height*0.0250


                        anchors
                        {
                        }
                        background: Rectangle {
                            color: "white"
                        }
                        contentItem: Image {

                            id: backArrow_img3
                            source: "file:./imgs/backarrow.png" // Specify the path to your PNG icon
                            fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

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


                    Text {
                        text: "My Smart Home"
                        color: "#0000FF"
                        x: 65
                        y:  120
                        opacity: 0.45
                        font.pixelSize: 70 // Set font size to 32 pixels
                    }

                    //Bedroom statistics
                    Rectangle
                    {
                        x:65
                        y:240
                        width: 450
                        height: 400
                        radius: 15
                        //color:"gray"
                        color: "#F0F0F0" // Lighter shade of gray
                        Rectangle
                        {
                            // x:65
                            // y:150
                            width: 170
                            height: 170
                            radius: 15
                            Image {
                                anchors.fill: parent // Make the image fill the entire rectangle
                                source: "file:./imgs/bedroom2.png" // Provide the path to your image file
                                fillMode: Image.PreserveAspectFit // Choose the fill mode as per your requirement
                            }
                            anchors
                            {
                                top:parent.top
                                left:parent.left
                                topMargin:20
                                leftMargin:20
                            }
                        }


                        Text {

                            text: "Bedroom"
                            color: "#0000FF"
                            x: 200
                            y:  20
                            opacity: 0.45
                            font.pixelSize: 50 // Set font size to 32 pixels
                        }

                        Text {

                            font.pixelSize: 44
                            color: "gray"
                            horizontalAlignment: Text.AlignHCenter
                            text: "Temperature"//new Date().toLocaleTimeString() // Initialize with current time

                            // Anchoring the Text element to the bottom of the parent Rectangle
                            anchors {
                                horizontalCenter: parent.horizontalCenter // Center horizontally
                                bottom: parent.bottom // Align to the bottom of the parent Rectangle
                                bottomMargin: parent.height/3 // Adjust margin as needed
                            }
                        }
                        Text {
                            id: bt_timeText0
                            font.pixelSize: 44
                            color: "gray"
                            horizontalAlignment: Text.AlignHCenter
                            text: "0"//new Date().toLocaleTimeString() // Initialize with current time

                            // Anchoring the Text element to the bottom of the parent Rectangle
                            anchors {
                                horizontalCenter: parent.horizontalCenter // Center horizontally
                                bottom: parent.bottom // Align to the bottom of the parent Rectangle
                                bottomMargin: parent.height/6.5 // Adjust margin as needed
                            }
                        }

                        Timer {
                            interval: 999 // Update every second
                            running: true
                            repeat: true
                            onTriggered: {

                                function readOutput() {
                                    var result = cmd.readAll().toString().trim(); // Convert to string and trim whitespace                        console.log("Command Output:", result);

                                    // Format the temperature string
                                    var temperatureString = result + " °C";

                                    bt_timeText0.text = temperatureString;
                                }

                                // Define a function to handle the finished signal
                                function processFinished() {
                                    // Disconnect the signals to avoid multiple connections
                                    cmd.readyReadStandardOutput.disconnect(readOutput);
                                    cmd.finished.disconnect(processFinished);
                                }

                                cmd.start("bash", ["-c", "cat /home/ahmed/SimulateDevice/bedroom/Temp"]);

                                // Listen to the readyReadStandardOutput signal to get the output
                                cmd.readyReadStandardOutput.connect(readOutput);//readOutput

                                // Listen to the finished signal to indicate when the process has finished
                                cmd.finished.connect(processFinished);
                            }
                        }




                    }

                    Rectangle
                    {
                        x:65
                        y:670
                        width: 450
                        height: 400
                        radius: 15
                        color: "#F0F0F0" // Lighter shade of gray
                        Rectangle
                        {
                            width: 200
                            height: 200
                            x:125
                            y:125

                            radius: 100

                            Button {

                                text: "Lamp"

                                anchors.horizontalCenter: parent.horizontalCenter

                                width: 200
                                height: 200
                                contentItem: Image {

                                    id: br_img
                                    source: "file:./imgs/lightbulbOff.png" // Specify the path to your PNG icon
                                    fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

                                    // Define a function to read the output and print it
                                    function readOutput() {
                                        var result = cmd.readAll().toString().trim(); // Convert to string and trim whitespace                        console.log("Command Output:", result);

                                        if(result === "1")
                                        {
                                            br_img.source = "file:./imgs/lightbulbOn.png";
                                            console.log("Turn ON: ", result);

                                        }
                                        else
                                        {
                                            br_img.source = "file:./imgs/lightbulbOff.png";
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

                                        cmd.start("bash", ["-c", "cat /home/ahmed/SimulateDevice/bedroom/Lamp"]);

                                        // Listen to the readyReadStandardOutput signal to get the output
                                        cmd.readyReadStandardOutput.connect(readOutput);//readOutput

                                        // Listen to the finished signal to indicate when the process has finished
                                        cmd.finished.connect(processFinished);

                                    }

                                }

                                background: Rectangle {
                                    color: "#F0F0F0"
                                    radius: 100
                                }

                                MouseArea {
                                    anchors.fill: parent // Make the MouseArea cover the entire button
                                    cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                                    // Change cursor shape to default when mouse exits
                                    onExited: {
                                        Qt.application.setCursorShape(Qt.ArrowCursor);
                                    }


                                    onClicked: {
                                        cmd.start("bash", ["-c", "echo $(($(cat /home/ahmed/SimulateDevice/bedroom/Lamp) ^ 1)) > /home/ahmed/SimulateDevice/bedroom/Lamp"]);
                                    }
                                }


                            }
                        }

                        Text {

                            text: "Lamp"
                            color: "#0000FF"
                            x: 170
                            y:  20
                            opacity: 0.45
                            font.pixelSize: 50 // Set font size to 32 pixels
                            anchors.horizontalCenter: parent.horizontalCenter

                        }
                    }

                    Rectangle
                    {
                        x:600
                        y:670
                        width: 450
                        height: 400
                        radius: 15
                        //color:"gray"
                        color: "#F0F0F0" // Lighter shade of gray
                        Rectangle
                        {
                            width: 200
                            height: 200
                            x:125
                            y:125

                            radius: 100

                            Button {
                                text: "Buzzer"

                                anchors.horizontalCenter: parent.horizontalCenter

                                width: 200
                                height: 200

                                contentItem: Image {

                                    id: bz_img
                                    source: "file:./imgs/bellOff.png" // Specify the path to your PNG icon
                                    fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

                                    // Define a function to read the output and print it
                                    function readOutput() {
                                        //Boolean result;
                                        var result = cmd.readAll().toString().trim(); // Convert to string and trim whitespace                        console.log("Command Output:", result);


                                        if(result === "1")
                                        {
                                            bz_img.source = "file:./imgs/bellRed.png";
                                            console.log("Turn ON: ", result);

                                        }
                                        else
                                        {
                                            bz_img.source = "file:./imgs/bellOff.png";
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

                                        cmd.start("bash", ["-c", "cat /home/ahmed/SimulateDevice/bedroom/Buzzer"]);

                                        // Listen to the readyReadStandardOutput signal to get the output
                                        cmd.readyReadStandardOutput.connect(readOutput);//readOutput

                                        // Listen to the finished signal to indicate when the process has finished
                                        cmd.finished.connect(processFinished);

                                    }

                                }

                                background: Rectangle {
                                    color: "#F0F0F0"
                                }

                                MouseArea {
                                    anchors.fill: parent // Make the MouseArea cover the entire button
                                    cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                                    // Change cursor shape to default when mouse exits
                                    onExited: {
                                        Qt.application.setCursorShape(Qt.ArrowCursor);
                                    }


                                    onClicked: {
                                    }
                                }

                            }
                        }


                        Text {

                            text: "Bell"
                            color: "#0000FF"
                            x: 170
                            y:  20
                            opacity: 0.45
                            font.pixelSize: 50 // Set font size to 32 pixels
                            anchors.horizontalCenter: parent.horizontalCenter

                        }
                    }


                }
            }
        }
    }

    // Page 3 Kitchen
    Page {

        id: page3Content
        title: "Page 3"

        // StackView to manage navigation
        StackView {
            id: stackView3
            anchors.fill: parent
            initialItem: mainPageContent3
        }

        // Page 2
        Page {
            id: mainPageContent3
            title: "Main Page"
            Rectangle{
                id:layout
                anchors.fill: parent
                color:"white"

                Rectangle {
                    id: aside
                    width: parent.width/4
                    height: parent.height
                    color: "#0000FF"
                    opacity: 0.45

                    // anchors
                    // {

                    //     top:parent.top
                    //     left:parent.left
                    //     leftMargin:130
                    //     topMargin:300
                    // }

                    Text{

                        text:"Ahmed"
                        color:"white"
                        font.pixelSize: 50
                        font.bold: true

                        anchors
                        {

                            top:parent.top
                            left:parent.left
                            leftMargin:150
                            topMargin:520
                        }

                    }

                }

                Rectangle
                {
                    width:200
                    height:200
                    radius:100

                    anchors
                    {

                        top:parent.top
                        left:parent.left
                        leftMargin:130
                        topMargin:300

                    }
                    Image {
                        anchors.fill: parent // Make the image fill the entire Rectangle
                        source: "file:./imgs/profile.png" // Provide the path to your image file
                        fillMode: Image.PreserveAspectFit // Choose the fill mode as per your requirement
                    }

                }

                Rectangle {
                    id: container
                    x: parent.width/4
                    y:0
                    width: parent.width - parent.width/4
                    height: parent.height
                    color: "white"
                    opacity: 1//0.6

                    //Back
                    Button {
                        text: "Go Back"

                        x:50
                        y:3
                        width: 100//parent.width
                        height: 100//parent.height*0.0250


                        anchors
                        {
                        }
                        background: Rectangle {
                            color: "white"
                        }
                        contentItem: Image {

                            id: backArrow_img
                            source: "file:./imgs/backarrow.png" // Specify the path to your PNG icon
                            fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

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


                    Text {
                        id: name
                        text: "My Smart Home"
                        color: "#0000FF"
                        x: 65
                        y:  120
                        opacity: 0.45
                        font.pixelSize: 70 // Set font size to 32 pixels
                    }

                    //Bathroom statistics

                    Rectangle
                    {
                        x:65
                        y:240
                        width: 450
                        height: 400
                        radius: 15
                        //color:"gray"
                        color: "#F0F0F0" // Lighter shade of gray
                        Rectangle
                        {
                            // x:65
                            // y:150
                            width: 170
                            height: 170
                            radius: 15
                            Image {
                                anchors.fill: parent // Make the image fill the entire rectangle
                                source: "file:./imgs/cooking.png" // Provide the path to your image file
                                fillMode: Image.PreserveAspectFit // Choose the fill mode as per your requirement
                            }
                            anchors
                            {
                                top:parent.top
                                left:parent.left

                                topMargin:20
                                leftMargin:20

                            }

                        }


                        Text {

                            text: "Kitchen"
                            color: "#0000FF"
                            x: 200
                            y:  20
                            opacity: 0.45
                            font.pixelSize: 50 // Set font size to 32 pixels
                        }

                        Text {

                            font.pixelSize: 44
                            color: "gray"
                            horizontalAlignment: Text.AlignHCenter
                            text: "Temperature"//new Date().toLocaleTimeString() // Initialize with current time

                            // Anchoring the Text element to the bottom of the parent Rectangle
                            anchors {
                                horizontalCenter: parent.horizontalCenter // Center horizontally
                                bottom: parent.bottom // Align to the bottom of the parent Rectangle
                                bottomMargin: parent.height/3 // Adjust margin as needed
                            }
                        }
                        Text {
                            id: bt_timeText4
                            font.pixelSize: 44
                            color: "gray"
                            horizontalAlignment: Text.AlignHCenter
                            text: "0"//new Date().toLocaleTimeString() // Initialize with current time

                            // Anchoring the Text element to the bottom of the parent Rectangle
                            anchors {
                                horizontalCenter: parent.horizontalCenter // Center horizontally
                                bottom: parent.bottom // Align to the bottom of the parent Rectangle
                                bottomMargin: parent.height/6.5 // Adjust margin as needed
                            }
                        }

                        Timer {
                            interval: 399 // Update every second
                            running: true
                            repeat: true
                            onTriggered: {

                                function readOutput() {
                                    //Boolean result;
                                    var result = cmd.readAll().toString().trim(); // Convert to string and trim whitespace                        console.log("Command Output:", result);

                                    // Format the temperature string
                                    var temperatureString = result + " °C";

                                    bt_timeText4.text = temperatureString;
                                }

                                // Define a function to handle the finished signal
                                function processFinished() {
                                    // Disconnect the signals to avoid multiple connections
                                    cmd.readyReadStandardOutput.disconnect(readOutput);
                                    cmd.finished.disconnect(processFinished);
                                }

                                cmd.start("bash", ["-c", "cat /home/ahmed/SimulateDevice/kitchen/Temp"]);

                                // Listen to the readyReadStandardOutput signal to get the output
                                cmd.readyReadStandardOutput.connect(readOutput);//readOutput

                                // Listen to the finished signal to indicate when the process has finished
                                cmd.finished.connect(processFinished);
                            }
                        }

                    }

                    Rectangle
                    {
                        x:65
                        y:670
                        width: 450
                        height: 400
                        radius: 15
                        color: "#F0F0F0" // Lighter shade of gray
                        Rectangle
                        {
                            width: 200
                            height: 200
                            x:125
                            y:125

                            radius: 100

                            Button {

                                text: "Lamp"

                                anchors.horizontalCenter: parent.horizontalCenter

                                width: 200
                                height: 200
                                contentItem: Image {

                                    id: ki_br_img
                                    source: "ffile:./imgs/lightbulbOff.png" // Specify the path to your PNG icon
                                    fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

                                    // Define a function to read the output and print it
                                    function readOutput() {
                                        //Boolean result;
                                        var result = cmd.readAll().toString().trim(); // Convert to string and trim whitespace                        console.log("Command Output:", result);


                                        if(result === "1")
                                        {
                                            ki_br_img.source = "file:./imgs/lightbulbOn.png";
                                            console.log("Turn ON: ", result);

                                        }
                                        else
                                        {
                                            ki_br_img.source = "file:./imgs/lightbulbOff.png";
                                            console.log("Turn OFF: ", result);

                                        }


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

                                        cmd.start("bash", ["-c", "cat /home/ahmed/SimulateDevice/kitchen/Lamp"]);

                                        // Listen to the readyReadStandardOutput signal to get the output
                                        cmd.readyReadStandardOutput.connect(readOutput);//readOutput

                                        // Listen to the finished signal to indicate when the process has finished
                                        cmd.finished.connect(processFinished);

                                    }

                                }
                                background: Rectangle {
                                    color: "#F0F0F0"
                                    radius: 100
                                }

                                MouseArea {
                                    anchors.fill: parent // Make the MouseArea cover the entire button
                                    cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                                    // Change cursor shape to default when mouse exits
                                    onExited: {
                                        Qt.application.setCursorShape(Qt.ArrowCursor);
                                    }


                                    onClicked: {
                                        // cmd.start("bash", ["-c", "cat /home/ahmed/SimulateDevice/bathroom/Lamp"]);
                                        cmd.start("bash", ["-c", "echo $(($(cat /home/ahmed/SimulateDevice/kitchen/Lamp) ^ 1)) > /home/ahmed/SimulateDevice/kitchen/Lamp"]);

                                        //                        bt_br_img.changeImageSource()
                                        //cmd.start("bash", ["-c", "echo '0000' | sudo -S sh -c 'echo $(($(cat /sys/class/leds/input3::capslock/brightness) ^ 1)) > /sys/class/leds/input3::capslock/brightness'"]);
                                        //cmd.start("bash", ["-c", "echo $(($(cat /home/ahmed/SimulateDevice/DD) ^ 1)) > /home/ahmed/SimulateDevice/DD"]);
                                    }
                                }


                            }


                        }


                        Text {

                            text: "Lamp"
                            color: "#0000FF"
                            x: 170
                            y:  20
                            opacity: 0.45
                            font.pixelSize: 50 // Set font size to 32 pixels
                            anchors.horizontalCenter: parent.horizontalCenter

                        }
                    }

                    Rectangle
                    {
                        x:600
                        y:670
                        width: 450
                        height: 400
                        radius: 15
                        color: "#F0F0F0" // Lighter shade of gray
                        Rectangle
                        {
                            width: 200
                            height: 200
                            x:125
                            y:125

                            radius: 100

                            Button {
                                text: "Buzzer"

                                anchors.horizontalCenter: parent.horizontalCenter

                                width: 200
                                height: 200

                                contentItem: Image {

                                    id: ki_bz_img
                                    source: "file:./imgs/bellOff.png" // Specify the path to your PNG icon
                                    fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

                                    // Define a function to read the output and print it
                                    function readOutput() {
                                        //Boolean result;
                                        var result = cmd.readAll().toString().trim(); // Convert to string and trim whitespace                        console.log("Command Output:", result);


                                        if(result === "1")
                                        {
                                            ki_bz_img.source = "file:./imgs/bellRed.png";
                                            console.log("Turn ON: ", result);

                                        }
                                        else
                                        {
                                            ki_bz_img.source = "file:./imgs/bellOff.png";
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

                                        cmd.start("bash", ["-c", "cat /home/ahmed/SimulateDevice/kitchen/Buzzer"]);

                                        // Listen to the readyReadStandardOutput signal to get the output
                                        cmd.readyReadStandardOutput.connect(readOutput);//readOutput

                                        // Listen to the finished signal to indicate when the process has finished
                                        cmd.finished.connect(processFinished);

                                    }

                                }

                                background: Rectangle {
                                    color: "#F0F0F0"
                                }

                                MouseArea {
                                    anchors.fill: parent // Make the MouseArea cover the entire button
                                    cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                                    // Change cursor shape to default when mouse exits
                                    onExited: {
                                        Qt.application.setCursorShape(Qt.ArrowCursor);
                                    }


                                    onClicked: {
                                    }
                                }

                            }
                        }


                        Text {

                            text: "Bell"
                            color: "#0000FF"
                            x: 170
                            y:  20
                            opacity: 0.45
                            font.pixelSize: 50 // Set font size to 32 pixels
                            anchors.horizontalCenter: parent.horizontalCenter

                        }
                    }
                }
            }
        }

    }

    // Page 4 Bathroom
    Page {

        id: page4Content
        title: "Page 4"

        // StackView to manage navigation
        StackView {
            id: stackView4
            anchors.fill: parent
            initialItem: mainPageContent4
        }

        // Page 2
        Page {
            id: mainPageContent4
            title: "Main Page"
            Rectangle{
                id:layout2
                anchors.fill: parent
                color:"white"

                Rectangle {
                    id: aside2
                    width: parent.width/4
                    height: parent.height
                    color: "#0000FF"
                    opacity: 0.45

                    // anchors
                    // {

                    //     top:parent.top
                    //     left:parent.left
                    //     leftMargin:130
                    //     topMargin:300
                    // }

                    Text{

                        text:"Ahmed"
                        color:"white"
                        font.pixelSize: 50
                        font.bold: true

                        anchors
                        {

                            top:parent.top
                            left:parent.left
                            leftMargin:150
                            topMargin:520
                        }

                    }

                }

                Rectangle
                {
                    width:200
                    height:200
                    radius:100

                    anchors
                    {

                        top:parent.top
                        left:parent.left
                        leftMargin:130
                        topMargin:300

                    }
                    Image {
                        anchors.fill: parent // Make the image fill the entire Rectangle
                        source: "file:./imgs/profile.png" // Provide the path to your image file
                        fillMode: Image.PreserveAspectFit // Choose the fill mode as per your requirement
                    }

                }

                Rectangle {
                    id: container2
                    x: parent.width/4
                    y:0
                    width: parent.width - parent.width/4
                    height: parent.height
                    color: "white"
                    opacity: 1//0.6

                    //Back
                    Button {
                        text: "Go Back"

                        x:50
                        y:3
                        width: 100//parent.width
                        height: 100//parent.height*0.0250


                        anchors
                        {
                        }
                        background: Rectangle {
                            color: "white"
                        }
                        contentItem: Image {

                            id: backArrow_img2
                            source: "file:./imgs/backarrow.png" // Specify the path to your PNG icon
                            fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

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


                    Text {
                        text: "My Smart Home"
                        color: "#0000FF"
                        x: 65
                        y:  120
                        opacity: 0.45
                        font.pixelSize: 70 // Set font size to 32 pixels
                    }

                    //Bathroom statistics

                    Rectangle
                    {
                        x:65
                        y:240
                        width: 450
                        height: 400
                        radius: 15
                        //color:"gray"
                        color: "#F0F0F0" // Lighter shade of gray
                        Rectangle
                        {
                            // x:65
                            // y:150
                            width: 170
                            height: 170
                            radius: 15
                            Image {
                                anchors.fill: parent // Make the image fill the entire rectangle
                                source: "file:./imgs/bathroom.png" // Provide the path to your image file
                                fillMode: Image.PreserveAspectFit // Choose the fill mode as per your requirement
                            }
                            anchors
                            {
                                top:parent.top
                                left:parent.left

                                topMargin:20
                                leftMargin:20

                            }

                        }


                        Text {

                            text: "Bathroom"
                            color: "#0000FF"
                            x: 200
                            y:  20
                            opacity: 0.45
                            font.pixelSize: 50 // Set font size to 32 pixels
                        }

                        Text {

                            font.pixelSize: 44
                            color: "gray"
                            horizontalAlignment: Text.AlignHCenter
                            text: "Temperature"//new Date().toLocaleTimeString() // Initialize with current time

                            // Anchoring the Text element to the bottom of the parent Rectangle
                            anchors {
                                horizontalCenter: parent.horizontalCenter // Center horizontally
                                bottom: parent.bottom // Align to the bottom of the parent Rectangle
                                bottomMargin: parent.height/3 // Adjust margin as needed
                            }
                        }
                        Text {
                            id: bt_timeText3
                            font.pixelSize: 44
                            color: "gray"
                            horizontalAlignment: Text.AlignHCenter
                            text: "0"//new Date().toLocaleTimeString() // Initialize with current time

                            // Anchoring the Text element to the bottom of the parent Rectangle
                            anchors {
                                horizontalCenter: parent.horizontalCenter // Center horizontally
                                bottom: parent.bottom // Align to the bottom of the parent Rectangle
                                bottomMargin: parent.height/6.5 // Adjust margin as needed
                            }
                        }

                        Timer {
                            interval: 499 // Update every second
                            running: true
                            repeat: true
                            onTriggered: {

                                function readOutput() {
                                    //Boolean result;
                                    var result = cmd.readAll().toString().trim(); // Convert to string and trim whitespace                        console.log("Command Output:", result);

                                    // Format the temperature string
                                    var temperatureString = result + " °C";

                                    // Update the text of br_dateText and br_timeText
                                    //br_dateText.text = temperatureString;
                                    bt_timeText3.text = temperatureString;
                                    //return result;
                                }

                                // Define a function to handle the finished signal
                                function processFinished() {
                                    // Disconnect the signals to avoid multiple connections
                                    cmd.readyReadStandardOutput.disconnect(readOutput);
                                    cmd.finished.disconnect(processFinished);
                                }

                                cmd.start("bash", ["-c", "cat /home/ahmed/SimulateDevice/kitchen/Temp"]);

                                // Listen to the readyReadStandardOutput signal to get the output
                                cmd.readyReadStandardOutput.connect(readOutput);//readOutput

                                // Listen to the finished signal to indicate when the process has finished
                                cmd.finished.connect(processFinished);
                            }
                        }




                    }

                    Rectangle
                    {
                        x:65
                        y:670
                        width: 450
                        height: 400
                        radius: 15
                        //color:"gray"
                        color: "#F0F0F0" // Lighter shade of gray
                        Rectangle
                        {
                            width: 200
                            height: 200
                            x:125
                            y:125

                            radius: 100

                            Button {

                                text: "Lamp"

                                anchors.horizontalCenter: parent.horizontalCenter

                                width: 200
                                height: 200

                                // width:parent.width/4
                                // height:parent.height/3

                                contentItem: Image {

                                    id: bt_br_img
                                    source: "file:./imgs/lightbulbOff.png" // Specify the path to your PNG icon
                                    fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

                                    // Define a function to read the output and print it
                                    function readOutput() {
                                        //Boolean result;
                                        var result = cmd.readAll().toString().trim(); // Convert to string and trim whitespace                        console.log("Command Output:", result);


                                        if(result === "1")
                                        {
                                            bt_br_img.source = "file:./imgs/lightbulbOn.png";
                                            console.log("Turn ON: ", result);

                                        }
                                        else
                                        {
                                            bt_br_img.source = "file:./imgs/lightbulbOff.png";
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

                                        cmd.start("bash", ["-c", "cat /home/ahmed/SimulateDevice/bathroom/Lamp"]);

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
                                    color: "#F0F0F0"
                                    radius: 100
                                }

                                MouseArea {
                                    anchors.fill: parent // Make the MouseArea cover the entire button
                                    cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                                    // Change cursor shape to default when mouse exits
                                    onExited: {
                                        Qt.application.setCursorShape(Qt.ArrowCursor);
                                    }


                                    onClicked: {
                                        // cmd.start("bash", ["-c", "cat /home/ahmed/SimulateDevice/bathroom/Lamp"]);
                                        cmd.start("bash", ["-c", "echo $(($(cat /home/ahmed/SimulateDevice/bathroom/Lamp) ^ 1)) > /home/ahmed/SimulateDevice/bathroom/Lamp"]);

                                        //                        bt_br_img.changeImageSource()
                                        //cmd.start("bash", ["-c", "echo '0000' | sudo -S sh -c 'echo $(($(cat /sys/class/leds/input3::capslock/brightness) ^ 1)) > /sys/class/leds/input3::capslock/brightness'"]);
                                        //cmd.start("bash", ["-c", "echo $(($(cat /home/ahmed/SimulateDevice/DD) ^ 1)) > /home/ahmed/SimulateDevice/DD"]);
                                    }
                                }


                            }


                        }


                        Text {

                            text: "Lamp"
                            color: "#0000FF"
                            x: 170
                            y:  20
                            opacity: 0.45
                            font.pixelSize: 50 // Set font size to 32 pixels
                            anchors.horizontalCenter: parent.horizontalCenter

                        }
                    }

                    // Rectangle
                    // {
                    //     x:600
                    //     y:670
                    //     width: 450
                    //     height: 400
                    //     radius: 15
                    //     //color:"gray"
                    //     color: "#F0F0F0" // Lighter shade of gray
                    //     Rectangle
                    //     {
                    //         width: 200
                    //         height: 200
                    //         x:125
                    //         y:125

                    //         radius: 100

                    //         Button {
                    //             text: "Buzzer"

                    //             anchors.horizontalCenter: parent.horizontalCenter

                    //             width: 200
                    //             height: 200

                    //             contentItem: Image {

                    //                 id: bt_bz_img
                    //                 source: "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/bellOff.png" // Specify the path to your PNG icon
                    //                 fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

                    //                 // Define a function to read the output and print it
                    //                 function readOutput() {
                    //                     //Boolean result;
                    //                     var result = cmd.readAll().toString().trim(); // Convert to string and trim whitespace                        console.log("Command Output:", result);


                    //                     if(result === "1")
                    //                     {
                    //                         bt_bz_img.source = "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/bellRed.png";
                    //                         console.log("Turn ON: ", result);

                    //                     }
                    //                     else
                    //                     {
                    //                         bt_bz_img.source = "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/bellOff.png";
                    //                         console.log("Turn OFF: ", result);

                    //                     }


                    //                     //return result;
                    //                 }

                    //                 // Define a function to handle the finished signal
                    //                 function processFinished() {
                    //                     // Disconnect the signals to avoid multiple connections
                    //                     cmd.readyReadStandardOutput.disconnect(readOutput);
                    //                     cmd.finished.disconnect(processFinished);
                    //                 }

                    //                 function changeImageSource() {

                    //                     if (!('staticVar' in changeImageSource)) {

                    //                         changeImageSource.staticVar = 0;

                    //                     }

                    //                     cmd.start("bash", ["-c", "cat /home/ahmed/SimulateDevice/bathroom/Buzzer"]);

                    //                     // Listen to the readyReadStandardOutput signal to get the output
                    //                     cmd.readyReadStandardOutput.connect(readOutput);//readOutput

                    //                     // Listen to the finished signal to indicate when the process has finished
                    //                     cmd.finished.connect(processFinished);

                    //                 }

                    //             }

                    //             background: Rectangle {
                    //                 color: "#F0F0F0"
                    //             }

                    //             MouseArea {
                    //                 anchors.fill: parent // Make the MouseArea cover the entire button
                    //                 cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                    //                 // Change cursor shape to default when mouse exits
                    //                 onExited: {
                    //                     Qt.application.setCursorShape(Qt.ArrowCursor);
                    //                 }


                    //                 onClicked: {
                    //                 }
                    //             }

                    //         }
                    //     }


                    //     Text {

                    //         text: "Bell"
                    //         color: "#0000FF"
                    //         x: 170
                    //         y:  20
                    //         opacity: 0.45
                    //         font.pixelSize: 50 // Set font size to 32 pixels
                    //         anchors.horizontalCenter: parent.horizontalCenter

                    //     }
                    // }


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
