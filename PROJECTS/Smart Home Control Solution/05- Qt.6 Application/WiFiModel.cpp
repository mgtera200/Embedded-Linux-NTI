#include "WiFiModel.h"
#include "paths.h"
WiFiModel::WiFiModel(QObject *parent)
    : QObject{parent}, connectedNetworkName("")
{}

QStringList WiFiModel::updateNetworkList()
{
    QStringList networks;

    QProcess process;

    // connect(&process, QOverload<int, QProcess::ExitStatus>::of(&QProcess::finished),
    //         this, [this, &process](int exitCode, QProcess::ExitStatus exitStatus) {
    //     WiFiModel::handleProcessFinished(exitCode, exitStatus, &process);
    //         });

    QString program = "nmcli";  // Program to be executed
    QStringList arguments;
    arguments << "-f" << "SSID" << "device" << "wifi" << "list";  // List of arguments

    process.start(program, arguments);
    process.waitForFinished();
    QString output = process.readAllStandardOutput();

    networks = output.split("\n");
    for (QString &str : networks) {
        str = str.trimmed();  // Trim each element in the list
    }
    networks.removeAt(0);

    emit updateSuccessful();
    return networks;
}

void WiFiModel::connectToNetwork(const QString networkName, const QString password,int flag)
{
    if (connetprocess.state() != QProcess::NotRunning) {
        connetprocess.kill();  // Terminate the process if still running
        connetprocess.waitForFinished();  // Wait until it's fully finished
    }

    qDebug() << "Attempting to connect to network:" << networkName;
    qDebug() << "Using password:" << password;

    // QProcess to handle the external command
    disconnect(&connetprocess, nullptr, this, nullptr);
    connect(&connetprocess, QOverload<int, QProcess::ExitStatus>::of(&QProcess::finished),
            this, [this, networkName, password,flag](int exitCode, QProcess::ExitStatus exitStatus) {
                WiFiModel::handleNetConnectionProcessFinished(exitCode, exitStatus, networkName, password, flag);
            });

    QString program = "nmcli";  // The program to run
    QStringList arguments;  // Arguments for the command
    arguments << "device" << "wifi" << "connect" << networkName << "password" << password;

    // Check if process is running, terminate it if needed
    if (connetprocess.state() != QProcess::NotRunning) {
        qDebug() << "Process is already running, killing the process...";
        connetprocess.kill();  // Terminate the process if still running
        connetprocess.waitForFinished();  // Wait until it's fully finished
    }

    // Start the process
    qDebug() << "Starting process with arguments:" << arguments;
    connetprocess.start(program, arguments);

    // // Wait for the process to finish
    // if (!process.waitForFinished()) {
    //     qDebug() << "Process failed to finish. Error:" << process.errorString();
    //     emit connectionFailed();
    //     return;
    // }


}

void WiFiModel::readCredentialsAndConnect()
{
    QString filePath = NETWORK_SECRETS;  // Path to the file containing credentials
    QString networkName;
    QString password;

    QFile file(filePath);
    if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(&file);

        // Assuming the first line is the network name and the second line is the password
        networkName = in.readLine().trimmed();  // Trim any whitespace/newlines
        password = in.readLine().trimmed();     // Trim any whitespace/newlines
        file.close();

        // Check if the file is empty or credentials are missing
        if (networkName.isEmpty()) {
            qDebug() << "Network name is missing. Skipping connection.";
            return;  // Don't call connectToNetwork if either value is missing
        }

        qDebug() << "Stored credentials - Network:" << networkName << ", Password:" << password;
    } else {
        qDebug() << "Failed to open file for reading:" << file.errorString();
        return;  // Exit the function if the file cannot be opened
    }

    // Call the connectToNetwork function with the read network name and password
    connectToNetwork(networkName, password,1);
}

void WiFiModel::deleteCredentials()
{
    QString filePath = NETWORK_SECRETS;  // Path to the file containing credentials

    QFile file(filePath);
    if (file.open(QIODevice::WriteOnly | QIODevice::Truncate)) {
        // Opening the file in WriteOnly mode with Truncate will clear the file contents
        qDebug() << "Credentials deleted successfully.";
        file.close();
    } else {
        qDebug() << "Failed to open file for deleting credentials:" << file.errorString();
    }
}

void WiFiModel::handleNetConnectionProcessFinished(int exitCode, QProcess::ExitStatus exitStatus, const QString& networkName, const QString& password, int flag)
{
    if (connetprocess.exitStatus() != QProcess::NormalExit) {
        qDebug() << "Process did not exit normally. Error:" << connetprocess.errorString();
        emit connectionFailed();
        return;
    }
    // Print the output to the Qt console
    qDebug() << "Process finished with exit code:" << exitCode;

    // Read the output of the process
    QString result = connetprocess.readAllStandardOutput();
    qDebug() << "Process output:" << result;

    if (result.contains("success", Qt::CaseInsensitive)) {
        qDebug() << "Connection to network" << networkName << "was successful!";
        connectedNetworkName = networkName; // Store the connected network name
        emit connectedNetworkNameChanged();  // Emit the signal for network name change
        if (flag == 0)
        {
            emit connectionSuccessful();
        }
        else if(flag == 1)
        {
            emit autoconnectionSuccessful();

        }

        // Save the network name and password to a file (overwriting the file)
        QString filePath = NETWORK_SECRETS;  // Replace with the actual path

        QFile file(filePath);
        if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {  // Open in write-only mode
            QTextStream out(&file);
            out << networkName << "\n";
            out << password << "\n";
            file.close();
            qDebug() << "Network credentials saved to" << filePath;
        } else {
            qDebug() << "Failed to open file for writing:" << file.errorString();
        }

    } else {
        qDebug() << "Connection to network" << networkName << "failed.";
        emit connectionFailed();
    }
    qDebug() << "killing the process...";
    connetprocess.kill();  // Terminate the process if still running
    connetprocess.waitForFinished();  // Wait until it's fully finished
    qDebug() << "process killed";

}
