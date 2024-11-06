#include "customMqttCallback.h"

// Constructor that takes a callback function for handling messages
CustomMQTTCallback::CustomMQTTCallback(std::function<void(mqtt::const_message_ptr)> callback)
    : onMessageArrived(callback) {}

// Implementation of the message_arrived method
void CustomMQTTCallback::message_arrived(mqtt::const_message_ptr msg) {
    // Call the passed lambda or function when a message arrives
    if (onMessageArrived) {
        onMessageArrived(msg);
    } else {
        qDebug() << "No message handler set.";
    }
}

// Optional implementation of connection_lost method
void CustomMQTTCallback::connection_lost(const std::string &cause) {
    qDebug() << "Connection lost: " << QString::fromStdString(cause);
}
