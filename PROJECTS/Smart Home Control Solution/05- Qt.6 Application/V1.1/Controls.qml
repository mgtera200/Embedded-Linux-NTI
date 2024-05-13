// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import Process

Column {

    id: root

    required property MediaRecorder recorder

    property bool settingsVisible: false
    property bool capturesVisible: false

    //property alias audioInput: audioInputSelect.selected
    property alias camera: videoSourceSelect.selectedCamera
    property alias screenCapture: videoSourceSelect.selectedScreenCapture
    property alias windowCapture: videoSourceSelect.selectedWindowCapture

    spacing: Style.interSpacing * Style.ratio

    Process {
            id: cmd
            property string output: ""

        }

    Column {
        id: inputControls
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: Style.intraSpacing
        VideoSourceSelect { id: videoSourceSelect }
    }

    Column {
        width: recordButton.width
        anchors.horizontalCenter: parent.horizontalCenter
        RecordButton {

            id: recordButton
            recording: recorder.recorderState === MediaRecorder.RecordingState
            onClicked: recording ? recorder.stop() : recorder.record()
        }
        Text {
            id: recordingTime
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 30//Style.fontSize
            color: palette.text
        }
    }

    Column {
        id: optionButtons
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: Style.intraSpacing
        Button {

            leftPadding: Style.height
            rightPadding: Style.height
            topPadding: Style.height
            bottomPadding: Style.height
            height: Style.height*5
            width: Style.height*5
            anchors.horizontalCenter: parent.horizontalCenter

            contentItem: Image {

                source: "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/video-player.png" // Specify the path to your PNG icon
                fillMode: Image.PreserveAspectFit//Image.PreserveAspectFit // Preserve the aspect ratio of the icon

            }

             background: Rectangle {
                 height: Style.height*5
                 width: Style.height*5//Style.widthMedium

                color: "white" // Set the color to match the parent's background color
                radius: Style.height*5 // Optional: Adds rounded corners to the button
                opacity: 0.5
                border.color: "black"
                border.width: 1
                Rectangle {
                    height: Style.height*4.5
                    width: Style.height*4.5//Style.widthMedium
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter

                   color: "pink" // Set the color to match the parent's background color
                   radius: Style.height*4.5 // Optional: Adds rounded corners to the button
               }
            }

            text: "Records"
            MouseArea {
                anchors.fill: parent // Make the MouseArea cover the entire button
                cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                // Change cursor shape to default when mouse exits
                onExited: {
                    Qt.application.setCursorShape(Qt.ArrowCursor);
                }

                onClicked: {
                    // Manually trigger the onClicked event of the button
                    root.capturesVisible = !root.capturesVisible
                }
            }
        }

        Rectangle {
            width: Style.height // Adjust the height of spacing as needed
            height: Style.height
            color: "transparent"
        }

        Button {
            leftPadding: Style.height
            rightPadding: Style.height
            topPadding: Style.height
            bottomPadding: Style.height
            height: Style.height*5//150 //Style.height + 50
            width:  Style.height*5//150//Style.widthMedium
            anchors.horizontalCenter: parent.horizontalCenter
            // Use an Image instead of text
            contentItem: Image {
                source: "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/person.png" // Specify the path to your PNG icon
                fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

            }

            background: Rectangle {
                height: Style.height*5
                width: Style.height*5//Style.widthMedium

               // width: 100//Style.widthMedium
               color: "white" // Set the color to match the parent's background color
               radius: Style.height*5 // Optional: Adds rounded corners to the button
               opacity: 0.5
               border.color: "black"
               border.width: 1
               Rectangle {
                   height: Style.height*4.5
                   width: Style.height*4.5//Style.widthMedium
                   anchors.horizontalCenter: parent.horizontalCenter
                   anchors.verticalCenter: parent.verticalCenter

                  // width: 100//Style.widthMedium
                  color: "gray" // Set the color to match the parent's background color
                  radius: Style.height*4.5 // Optional: Adds rounded corners to the button
              }
           }

            text: "Open Door"

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

            font.pointSize: Style.fontSize
            font.pixelSize: 30
        }
        Rectangle {
            width: Style.height // Adjust the height of spacing as needed
            height: Style.height
            color: "transparent"
        }
        Button {
            leftPadding: 0//Style.height
            rightPadding: Style.height//40
            topPadding: Style.height
            bottomPadding: Style.height
            height: Style.height*5//Style.height + 50
            width: Style.height*5//Style.widthMedium
            anchors.horizontalCenter: parent.horizontalCenter

            // Use an Image instead of text
            contentItem: Image {
                source: "file:///home/ahmed/Qt6/Examples/Qt-6.7.0/multimedia/video/recorder/imgs/people.png" // Specify the path to your PNG icon
                fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

            }

            background: Rectangle {
                height: Style.height*5
                width: Style.height*5//Style.widthMedium

               color: "white" // Set the color to match the parent's background color
               radius: Style.height*5 // Optional: Adds rounded corners to the button
               opacity: 0.5
               border.color: "black"
               border.width: 1
               Rectangle {
                   height: Style.height*4.5
                   width: Style.height*4.5//Style.widthMedium
                   anchors.horizontalCenter: parent.horizontalCenter
                   anchors.verticalCenter: parent.verticalCenter

                  color: "gray" // Set the color to match the parent's background color
                  radius: Style.height*4.5 // Optional: Adds rounded corners to the button
              }
            }
            text: "Close Door"
            MouseArea {
                anchors.fill: parent // Make the MouseArea cover the entire button
                cursorShape: Qt.PointingHandCursor // Set cursor shape to pointing hand when hovering

                // Change cursor shape to default when mouse exits
                onExited: {
                    Qt.application.setCursorShape(Qt.ArrowCursor);
                }

                onClicked: {
                    // Manually trigger the onClicked event of the button
                    cmd.start("bash", ["-c", "echo '0000' | sudo -S sh -c 'echo 0 > /sys/class/leds/input3::capslock/brightness'"]);
                                                }
            }

            font.pointSize: Style.fontSize
            font.pixelSize: 30
        }

    }

    Timer {

        running: true; interval: 100; repeat: true
        onTriggered: {
            var m = Math.floor(recorder.duration / 60000)
            var ms = (recorder.duration / 1000 - m * 60).toFixed(1)
            recordingTime.text = `${m}:${ms.padStart(4, 0)}`
        }
    }
}
