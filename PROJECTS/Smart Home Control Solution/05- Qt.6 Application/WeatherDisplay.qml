import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import QtQuick.Dialogs 1.3
import QtNetwork 2.15

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 400
    height: 300
    title: "Weather & Humidity Display"

    property string apiKey: "YOUR_OPENWEATHERMAP_API_KEY"
    property string city: "YOUR_CITY_NAME"

    Rectangle {
        color: "#f0f0f0"
        anchors.fill: parent

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 10

            Text {
                text: "Weather in " + mainWindow.city
                font.bold: true
                font.pointSize: 18
            }

            Text {
                id: weatherText
                text: "Loading..."
            }

            Text {
                text: "Humidity"
                font.bold: true
                font.pointSize: 18
            }

            Text {
                id: humidityText
                text: "Loading..."
            }
        }
    }

    Connections {
        target: weatherLoader
        onStatusChanged: {
            if (weatherLoader.status === Loader.Ready) {
                var data = JSON.parse(weatherLoader.item.responseText);
                weatherText.text = "Weather: " + data.weather[0].description;
                humidityText.text = "Humidity: " + data.main.humidity + "%";
            }
        }
    }

    Loader {
        id: weatherLoader
        source: "http://api.openweathermap.org/data/2.5/weather?q=" + mainWindow.city + "&appid=" + mainWindow.apiKey
        asynchronous: true
    }
}

