#ifndef MQTTCLIENT_H
#define MQTTCLIENT_H

#include <QObject>
#include <QTimer>
#include <mqtt/async_client.h>
#include <QDebug>
#include "customMqttCallback.h"
#include <sstream>

class MQTTClient : public QObject {
    Q_OBJECT


public:
    explicit MQTTClient(QObject *parent = nullptr);



    Q_INVOKABLE void buttonToggle(bool isOn,QString LedTopic);  // Method to publish "1" or "0" when button is toggled

    void publishToTopic(const QString &topic, const QString &message);
    void subscribeToTopic(const QStringList &topics);



public slots:
    void onMessageArrived(const std::string& topic, const std::string& payload);


signals:
    void subscribtionMessageHandlerON(QString topic);
    void subscribtionMessageHandlerOFF(QString topic);


private:
    mqtt::async_client *client;

};

#endif // MQTTCLIENT_H
