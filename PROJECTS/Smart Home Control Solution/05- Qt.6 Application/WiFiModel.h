#ifndef WIFIMODEL_H
#define WIFIMODEL_H

#include <QObject>
#include <QStringList>
#include <QProcess>
#include <QDebug>  // For logging
#include <QFile>

class WiFiModel : public QObject
{
    Q_OBJECT
public:
    explicit WiFiModel(QObject *parent = nullptr);
    Q_INVOKABLE QStringList updateNetworkList();
    // flag =1 if the function is called using auto connection
    Q_INVOKABLE void connectToNetwork(const QString networkName, const QString password, int flag);
    Q_INVOKABLE void readCredentialsAndConnect();
    Q_INVOKABLE void deleteCredentials();


    // Property for connected network name
    Q_PROPERTY(QString connectedNetworkName READ getConnectedNetworkName NOTIFY connectedNetworkNameChanged)

    QString getConnectedNetworkName() const { return connectedNetworkName; }


signals:
    void updateSuccessful();
    void connectionSuccessful();
    void autoconnectionSuccessful();
    void connectionFailed();
    void connectedNetworkNameChanged(); // New signal for network name changes
public slots:
    void handleNetConnectionProcessFinished(int exitCode, QProcess::ExitStatus exitStatus, const QString& networkName, const QString& password, int flag);

private:
    QString connectedNetworkName; // Store the name of the connected network
    QProcess connetprocess;

};

#endif // WIFIMODEL_H
