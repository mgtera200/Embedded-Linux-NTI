// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "mqttclient.h"
#include <QDebug>
#include <QQmlContext>
#include "WiFiModel.h"


#if QT_CONFIG(permissions)
  #include <QPermission>
#endif

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));  // Set environment variable

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    MQTTClient mqttClient;;
    engine.rootContext()->setContextProperty("mqttClient", &mqttClient);

    WiFiModel wifiModel;
    engine.rootContext()->setContextProperty("wifiModel", &wifiModel);


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
            &engine, &QQmlApplicationEngine::objectCreated, &app,
            [url](QObject *obj, const QUrl &objUrl) {
                if (!obj && url == objUrl)
                    QCoreApplication::exit(-1);
            },
            Qt::QueuedConnection);




    engine.load(url);

    return app.exec();
}
