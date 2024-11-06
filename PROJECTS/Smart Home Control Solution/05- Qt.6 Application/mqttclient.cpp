#include <mqtt/async_client.h>
#include <mqtt/exception.h>
#include <QString>
#include <QDebug>
#include "mqttclient.h"
#include "customMqttCallback.h"


MQTTClient::MQTTClient(QObject *parent)
    : QObject(parent),
    client(new mqtt::async_client("tcp://localhost:1883", "MQTTClient"))
{
    // Connect to the MQTT server
    try {
        client->connect()->wait();
        qDebug() << "Connected to MQTT broker";
    } catch (const mqtt::exception &exc) {
        qDebug() << "Error connecting to MQTT broker:" << exc.what();
        return;
    }


    // Subscribe to the battery topic
    subscribeToTopic({"Bedroom/Led","Bedroom/Buzzer","Kitchen/Led","Kitchen/Buzzer","Bathroom/Led"});

}

void MQTTClient::buttonToggle(bool isOn,QString LedTopic)
{
    if (isOn)
    {
        publishToTopic(LedTopic, "1");
    }
    else {
        publishToTopic(LedTopic, "0");

    }
}

void MQTTClient::publishToTopic(const QString &topic, const QString &message)
{
    try {
        std::string payload = message.toStdString();
        client->publish(topic.toStdString(), payload.c_str(), payload.size(), 1, false);
        qDebug() << "Message published: " << message << " Topic: " << topic;
    } catch (const mqtt::exception &exc) {
        qDebug() << "Error publishing message:" << exc.what();
    }
}

void MQTTClient::subscribeToTopic(const QStringList &topics)
{
    auto callbackHandler = new CustomMQTTCallback([this](mqtt::const_message_ptr msg) {
        std::string payload = msg->get_payload_str();
        qDebug() << "Message received: " << QString::fromStdString(payload);
        onMessageArrived(msg->get_topic(), payload);
    });

    // Set the custom callback handler to the client
    client->set_callback(*callbackHandler);

    for (const QString &topic : topics) {
        client->subscribe(topic.toStdString(), 1);  // QoS level 1
        qDebug() << "Subscribed to topic:" << topic;
    }
}

void MQTTClient::onMessageArrived(const std::string &topic, const std::string &payload)
{
    // Check the payload for "1" or "0"
    if (payload == "1") {
        qDebug() << "Received '1' - Turning ON the LED for topic:" << QString::fromStdString(topic);
        emit subscribtionMessageHandlerON(QString::fromStdString(topic));
    }
    else if (payload == "0") {
        qDebug() << "Received '0' - Turning OFF the LED for topic:" << QString::fromStdString(topic);
        emit subscribtionMessageHandlerOFF(QString::fromStdString(topic));
    }
    else {
        qDebug() << "Unknown payload received: " << QString::fromStdString(payload);
    }
}
