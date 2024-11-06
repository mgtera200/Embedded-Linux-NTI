// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls
import QtQuick.Window
import Qt.labs.folderlistmodel
import QtQuick.VirtualKeyboard
import QtQuick.VirtualKeyboard.Settings
import QtMultimedia
import QtQuick.Layouts


Window {

    visible: true

    title: "Home Watcher"
    visibility: Window.FullScreen // Set visibility to FullScreen




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
        Component.onCompleted: {
            wifiModel.readCredentialsAndConnect();  // Call this when the app starts
        }
        Rectangle {
            id: dateRecID
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



        // WiFi Image
        Image {
            id: wifiImage
            source: "qrc:/imgs/wifiDisconnected.png"
            width: 38
            height: 38
            anchors {
                top: stackView.top
            }

            Text {
                id: networkNameText
                text: wifiModel.connectedNetworkName // Bind to the property
                anchors.top: wifiImage.bottom
                anchors.horizontalCenter: wifiImage.horizontalCenter
                anchors.topMargin: 3
                font.pixelSize: 8
            }
            MouseArea {
                anchors.fill: parent
                onClicked: wifiWindow.visible = true
            }
        }


        Connections {
            target: wifiModel
            function onConnectedNetworkNameChanged() {
                networkNameText.text = wifiModel.connectedNetworkName; // Update text when the network name changes
            }
        }
        property string networkName: ""
        property var returnData
        Dialog {
            property real fontScaleFactorMain: wifiWindow.width / 400

            id: wifiWindow

            visible: false
            width: stackView.width * 0.8
            height: stackView.height * 0.8
            title: "Available Networks"
            // modality: Qt.ApplicationModal
            // flags: Qt.Dialog | Qt.WindowStaysOnTopHint
            // Ensure the dialog is centered on the main screen
            x : stackView.width * 0.11
            y :stackView.height * 0.1

            // Background Image
            background: Image {
                id: backgroundImage
                source: "qrc:/imgs/backgroundWithoutLogo.jpg"
                anchors.fill: parent
                visible: true
                anchors.centerIn: stackView
            }
            Rectangle {
                id: rectangleSpaceID
                color: "transparent"
                width: parent.width
                height: parent.height * 0.15
            }

            ListView {
                id: networkList
                property int flag: 0
                property int selectedIndex: -1
                // anchors.fill: parent
                anchors.margins: 20
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.top: rectangleSpaceID.bottom
                model: mainPageContent.returnData
                delegate: Rectangle {
                    property real fontScaleFactor5: wifiWindow.width / 400

                    id: rectangleDelegateID
                    width: parent.width
                    height: 50 * fontScaleFactor5
                    radius: 10
                    color: index === networkList.selectedIndex ? "#6495ED" : "transparent"

                    Text {
                        property real fontScaleFactor2: wifiWindow.width / 400

                        id: networkNameID
                        text: modelData
                        x: 10 * fontScaleFactor2
                        y: 5 * fontScaleFactor2
                        anchors.centerIn: parent
                        font.pixelSize: fontScaleFactor2 * 20
                        verticalAlignment: Text.AlignVCenter // Vertically align text within the delegate
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: function () {
                            // Set the clicked item as the selected item
                            if (networkList.selectedIndex !== index) {
                                networkList.selectedIndex = index
                                mainPageContent.networkName = modelData
                            } else {
                                // If the selected item is clicked again, reset it
                                networkList.selectedIndex = -1
                                mainPageContent.networkName = ""
                            }
                        }
                    }
                }
            }
            Button {
                property real fontScaleFactor4: wifiWindow.width /400

                id: connectButtonID
                text: "Connect"
                font.pixelSize: fontScaleFactor4 * 13
                anchors.bottom: parent.bottom

                width: parent.width
                height: 40 * fontScaleFactor4
                // anchors.horizontalCenter: parent
                // anchors.right: networkRowID.right
                onClicked: {
                    passwordDialog.open()
                }
            }

            onVisibleChanged: {
                if (wifiWindow.visible) {
                    mainPageContent.returnData = wifiModel.updateNetworkList(
                                ) // Call the function to update the network list
                    myTimer.start()
                }
            }
            Text {
                property real fontScaleFactor1: wifiWindow.width / 400

                id: refreshText
                color: "grey"
                visible: true
                text: "Refreshing..."
                anchors.bottom: connectButtonID.top
                anchors.margins: 5 * fontScaleFactor1
                font.pixelSize: fontScaleFactor1 * 13
            }
            Text {
                property real fontScaleFactor1: wifiWindow.width / 400

                id: connectedText
                color: "grey"
                visible: false
                text: "Connected to: " + mainPageContent.networkName
                anchors.bottom: connectButtonID.top
                x: 250 * fontScaleFactor1
                anchors.margins: 5 * fontScaleFactor1
                font.pixelSize: fontScaleFactor1 * 13
            }
            Connections {
                target: wifiModel

                function onConnectionSuccessful() {
                    connectedText.visible = true
                    wifiImage.source = "qrc:/imgs/wifiConnected.png"
                    autoconnectDialog.visible = true
                }
                function onAutoconnectionSuccessful() {
                    connectedText.visible = true
                    wifiImage.source = "qrc:/imgs/wifiConnected.png"
                }
            }
            Dialog {

                id: autoconnectDialog
                visible: false
                width: parent.width * 0.5 // Adjust as needed
                height: parent.height * 0.35 // Adjust as needed
                modal: true

                background: Image {
                    source: "qrc:/imgs/backgroundWithoutLogo.jpg"
                }

                Text {
                    text: "Do you want to auto connect on this Network next time?"
                    wrapMode: Text.Wrap
                    font.pixelSize: width * 0.05 // Dynamic font size
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                }

                Button {
                    text: "Yes"
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    width: 50 * wifiWindow.fontScaleFactorMain
                    height: 20 * wifiWindow.fontScaleFactorMain
                    anchors.left: parent.left // Align to the left of the row
                    anchors.leftMargin: parent.width * 0.1 // Margin from the left

                    onClicked: autoconnectDialog.visible = false
                }
                Button {
                    text: "No"
                    width: 50 * wifiWindow.fontScaleFactorMain
                    height: 20 * wifiWindow.fontScaleFactorMain
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    anchors.right: parent.right // Align to the right of the row
                    anchors.rightMargin: parent.width * 0.1 // Margin from the right
                    onClicked: {
                        autoconnectDialog.visible = false
                        wifiModel.deleteCredentials()
                    }
                }
            }

            Timer {
                id: myTimer
                interval: 2000
                repeat: true
                running: false
                onTriggered: {
                    mainPageContent.returnData = wifiModel.updateNetworkList()
                    refreshText.text = "Last refreshed at: " + new Date().toLocaleTimeString()
                    myTimer.interval = 10000
                }
            }

            Dialog {
                modal: true // Keep it open until explicitly closed
                closePolicy: Popup.NoAutoClose
                id: passwordDialog
                title: "Enter Password"
                width: wifiWindow.width * 0.8
                height: wifiWindow.height * 0.3
                anchors.centerIn: wifiWindow.horizontalCenter
                x: (wifiWindow.width - passwordDialog.width) / 2.15
                background: Image {
                    source: "qrc:/imgs/backgroundWithoutLogo.jpg"
                }
                Row {
                    spacing: 25
                    Text {
                        text: "Connecting to: " + mainPageContent.networkName
                        font.pixelSize: passwordDialog.width * 0.03
                    }
                    TextField {
                        id: passwordField
                        placeholderText: "Enter password"
                        echoMode: TextInput.Password

                        // Focus behavior: only activate the input panel when this field gains focus
                        onFocusChanged: {
                            if (focus) {
                                inputPanel.active = true // Show keyboard
                                inputPanel.visible = true // Show keyboard
                                Qt.inputMethod.show()
                            }
                        }
                    }

                    Button {
                        text: "Connect"
                        onClicked: {
                            wifiModel.connectToNetwork(mainPageContent.networkName,
                                                       passwordField.text, 0)
                            passwordDialog.close()
                        }
                    }

                    Button {
                        text: "Close"
                        onClicked: {
                            passwordDialog.close() // Close the dialog when clicked
                        }
                    }
                }
                // Set focus to the password field when the dialog is opened
                onOpened: {
                    passwordField.forceActiveFocus()
                    inputPanel.active = true // Show keyboard
                    inputPanel.visible = true // Show keyboard
                    Qt.inputMethod.show()  // Show virtual keyboard on open
                }
                onClosed: {
                    inputPanel.visible = false
                    inputPanel.active = false
                }


            }
            InputPanel {
                id: inputPanel
                z: 1
                visible: false
                anchors.fill: parent
                active: false // Keep it false initially
            }



            onClosed: {
                inputPanel.visible = false
                inputPanel.active = false
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
                source: "qrc:/imgs/bedroom.png" // Specify the path to your PNG icon
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
                source: "qrc:/imgs/kitchen.png" // Specify the path to your PNG icon
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
                source: "qrc:/imgs/bathtub.png" // Specify the path to your PNG icon
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
                onClicked: {
                    stackView.push(page4Content)
                }
            }
        }



    }



    // Page 2 Bedroom
    Page {

        id: page2Content
        title: "Page 2"

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
                    color: "black"
                    opacity: 0.97


                    Text{

                        text:"TERA"
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
                        source: "qrc:/imgs/profile.png"        // Provide the path to your image file
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
                            source: "qrc:/imgs/backarrow.png" // Specify the path to your PNG icon
                            fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

                        }

                        MouseArea {
                            anchors.fill: parent // Make the MouseArea cover the entire button
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
                                source: "qrc:/imgs/bedroom2.png" // Provide the path to your image file
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
                                id: lampButtonID

                                property int flag: 0

                                text: "Lamp"

                                anchors.horizontalCenter: parent.horizontalCenter

                                width: 200
                                height: 200
                                contentItem: Image {

                                    id: br_img
                                    source: "qrc:/imgs/lightbulbOff.png" // Specify the path to your PNG icon
                                    fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon


                                }

                                background: Rectangle {
                                    color: "#F0F0F0"
                                    radius: 100
                                }

                                MouseArea {
                                    anchors.fill: parent // Make the MouseArea cover the entire button
                                    onClicked: function (){

                                        if(lampButtonID.flag == 0){
                                            mqttClient.buttonToggle(true,"Bedroom/Led");
                                            br_img.source = "qrc:/imgs/lightbulbOn.png"
                                            lampButtonID.flag = 1;
                                            console.log("Toggle On");
                                        }
                                        else if(lampButtonID.flag == 1){
                                            mqttClient.buttonToggle(false,"Bedroom/Led");
                                            br_img.source = "qrc:/imgs/lightbulbOff.png"
                                            lampButtonID.flag = 0;
                                            console.log("Toggle Off");
                                        }

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
                                id: buzzerButtonID
                                text: "Buzzer"
                                property int flag: 0
                                anchors.horizontalCenter: parent.horizontalCenter

                                width: 200
                                height: 200

                                contentItem: Image {

                                    id: bz_img
                                    source: "qrc:/imgs/bellOff.png" // Specify the path to your PNG icon
                                    fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon





                                }

                                background: Rectangle {
                                    color: "#F0F0F0"
                                }

                                MouseArea {
                                    anchors.fill: parent // Make the MouseArea cover the entire button
                                    onClicked: function (){

                                        if(buzzerButtonID.flag == 0){
                                            mqttClient.buttonToggle(true,"Bedroom/Buzzer");
                                            bz_img.source = "qrc:/imgs/bellOn.png"
                                            buzzerButtonID.flag = 1;
                                            console.log("Toggle On");
                                        }
                                        else if(buzzerButtonID.flag == 1){
                                            mqttClient.buttonToggle(false,"Bedroom/Buzzer");
                                            bz_img.source = "qrc:/imgs/bellOff.png"
                                            buzzerButtonID.flag = 0;
                                            console.log("Toggle Off");
                                        }

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


                    Text{

                        text:"OWNER"
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
                        source: "qrc:/imgs/profile.png" // Provide the path to your image file
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
                            source: "qrc:/imgs/backarrow.png" // Specify the path to your PNG icon
                            fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

                        }

                        MouseArea {
                            anchors.fill: parent // Make the MouseArea cover the entire button
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
                                source: "qrc:/imgs/cooking.png" // Provide the path to your image file
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
                                id: kitchenLampButtonID

                                property int flag: 0

                                text: "Lamp"

                                anchors.horizontalCenter: parent.horizontalCenter

                                width: 200
                                height: 200
                                contentItem: Image {

                                    id: ki_br_img
                                    source: "qrc:/imgs/lightbulbOff.png" // Specify the path to your PNG icon
                                    fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon


                                }

                                background: Rectangle {
                                    color: "#F0F0F0"
                                    radius: 100
                                }

                                MouseArea {
                                    anchors.fill: parent // Make the MouseArea cover the entire button
                                    onClicked: function (){

                                        if(kitchenLampButtonID.flag == 0){
                                            mqttClient.buttonToggle(true,"Kitchen/Led");
                                            ki_br_img.source = "qrc:/imgs/lightbulbOn.png"
                                            kitchenLampButtonID.flag = 1;
                                            console.log("Kitchen Lamp Toggle On");
                                        }
                                        else if(kitchenLampButtonID.flag == 1){
                                            mqttClient.buttonToggle(false,"Kitchen/Led");
                                            ki_br_img.source = "qrc:/imgs/lightbulbOff.png"
                                            kitchenLampButtonID.flag = 0;
                                            console.log("Kitchen Lamp Toggle Off");
                                        }

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
                                id: kitchenBuzzorButtonID
                                text: "Buzzer"
                                property int flag: 0
                                anchors.horizontalCenter: parent.horizontalCenter

                                width: 200
                                height: 200

                                contentItem: Image {

                                    id: ki_bz_img
                                    source: "qrc:/imgs/bellOff.png" // Specify the path to your PNG icon
                                    fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon





                                }

                                background: Rectangle {
                                    color: "#F0F0F0"
                                }

                                MouseArea {
                                    anchors.fill: parent // Make the MouseArea cover the entire button
                                    onClicked: function (){

                                        if(kitchenBuzzorButtonID.flag == 0){
                                            mqttClient.buttonToggle(true,"Kitchen/Buzzer");
                                            ki_bz_img.source = "qrc:/imgs/bellOn.png"
                                            kitchenBuzzorButtonID.flag = 1;
                                            console.log("Kitchen Buzzer Toggle On");
                                        }
                                        else if(kitchenBuzzorButtonID.flag == 1){
                                            mqttClient.buttonToggle(false,"Kitchen/Buzzer");
                                            ki_bz_img.source = "qrc:/imgs/bellOff.png"
                                            kitchenBuzzorButtonID.flag = 0;
                                            console.log("Kitchen Buzzer Toggle Off");
                                        }

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


                    Text{

                        text:"OWNER"
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
                        source: "qrc:/imgs/profile.png" // Provide the path to your image file
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
                            source: "qrc:/imgs/backarrow.png" // Specify the path to your PNG icon
                            fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

                        }

                        MouseArea {
                            anchors.fill: parent // Make the MouseArea cover the entire button

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
                                source: "qrc:/imgs/bathroom.png" // Provide the path to your image file
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
                                property int flag: 0
                                id:bathroomLedButtonID
                                text: "Lamp"

                                anchors.horizontalCenter: parent.horizontalCenter

                                width: 200
                                height: 200


                                contentItem: Image {

                                    id: bt_br_img
                                    source: "qrc:/imgs/lightbulbOff.png" // Specify the path to your PNG icon
                                    fillMode: Image.PreserveAspectFit // Preserve the aspect ratio of the icon

                                }

                                background: Rectangle {
                                    color: "#F0F0F0"
                                    radius: 100
                                }

                                MouseArea {
                                    anchors.fill: parent // Make the MouseArea cover the entire button

                                    onClicked: function (){

                                        if(bathroomLedButtonID.flag == 0){
                                            bt_br_img.source = "qrc:/imgs/lightbulbOn.png"
                                            mqttClient.buttonToggle(true,"Bathroom/Led");

                                            bathroomLedButtonID.flag = 1;
                                            console.log("Bathroom Lamp Toggle On");
                                        }
                                        else if(bathroomLedButtonID.flag == 1){
                                            mqttClient.buttonToggle(false,"Bathroom/Led");
                                            bt_br_img.source = "qrc:/imgs/lightbulbOff.png"
                                            bathroomLedButtonID.flag = 0;
                                            console.log("Bathroom Lamp Toggle Off");
                                        }

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

    Connections {
        target: mqttClient
        function onSubscribtionMessageHandlerON(topic) {

            if(topic === "Bedroom/Led")
            {
                br_img.source = "qrc:/imgs/lightbulbOn.png";
                lampButtonID.flag = 1;
            }
            else if(topic === "Bedroom/Buzzer")
            {
                bz_img.source = "qrc:/imgs/bellOn.png";
                lampButtonID.flag = 1;
            }
            else if(topic === "Kitchen/Led")
            {
                ki_br_img.source = "qrc:/imgs/lightbulbOn.png";
                kitchenBuzzorButtonID.flag = 1;
            }
            else if(topic === "Kitchen/Buzzer")
            {
                ki_bz_img.source = "qrc:/imgs/bellOn.png";
                kitchenBuzzorButtonID.flag = 1;
            }
            else if(topic === "Bathroom/Led")
            {
                bt_br_img.source = "qrc:/imgs/lightbulbOn.png";
                bathroomLedButtonID.flag = 1;
            }
        }

        function onSubscribtionMessageHandlerOFF(topic) {

            if(topic === "Bedroom/Led")
            {
                br_img.source = "qrc:/imgs/lightbulbOff.png";
                lampButtonID.flag = 0;
            }
            else if(topic === "Bedroom/Buzzer")
            {
                bz_img.source = "qrc:/imgs/bellOff.png";
                lampButtonID.flag = 0;
            }
            else if(topic === "Kitchen/Led")
            {
                ki_br_img.source = "qrc:/imgs/lightbulbOff.png";
                kitchenBuzzorButtonID.flag = 0;
            }
            else if(topic === "Kitchen/Buzzer")
            {
                ki_bz_img.source = "qrc:/imgs/bellOff.png";
                kitchenBuzzorButtonID.flag = 0;
            }
            else if(topic === "Bathroom/Led")
            {
                bt_br_img.source = "qrc:/imgs/lightbulbOff.png";
                bathroomLedButtonID.flag = 0;
            }
        }
    }
}


