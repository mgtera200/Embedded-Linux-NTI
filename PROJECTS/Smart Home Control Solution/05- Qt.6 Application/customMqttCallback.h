#ifndef CUSTOMMQTTCALLBACK_H
#define CUSTOMMQTTCALLBACK_H

#include <mqtt/async_client.h>
#include <functional>
#include <QDebug>

class CustomMQTTCallback : public virtual mqtt::callback {
public:
    // Constructor takes a lambda or function to handle messages
    CustomMQTTCallback(std::function<void(mqtt::const_message_ptr)> callback);

    // Override message_arrived to handle incoming MQTT messages
    void message_arrived(mqtt::const_message_ptr msg) override;

    // Handle connection lost
    void connection_lost(const std::string &cause) override;

private:
    std::function<void(mqtt::const_message_ptr)> onMessageArrived;
};

#endif // CUSTOMMQTTCALLBACK_H
