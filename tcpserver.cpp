#include "tcpserver.h"

TCPServer::TCPServer(QObject *parent) : QObject(parent)
{
    server = new QTcpServer(this);
    connect(server, &QTcpServer::newConnection, this, &TCPServer::onNewConnection);
    //QHostAddress ipAddress(Any);
    quint16 port =12345;

    if (!server->listen(QHostAddress::Any,port)) // Change to the appropriate port
    {
        qDebug() << "Server could not start.";
    }
    else
    {
        qDebug() << "Server started.";
    }
}

void TCPServer::onNewConnection()
{
    QTcpSocket *clientSocket = server->nextPendingConnection();
    clients.append(clientSocket);

    connect(clientSocket, &QTcpSocket::readyRead, this, &TCPServer::onReadyRead);
    connect(clientSocket, &QTcpSocket::disconnected, this, &TCPServer::onDisconnected);

    qDebug() << "New client connected.";
}

void TCPServer::onReadyRead()
{
    QTcpSocket *clientSocket = qobject_cast<QTcpSocket *>(sender());
    if (!clientSocket)
        return;

    QString message = QString::fromUtf8(clientSocket->readAll());
    qDebug() << "Received message:" << message;

    // Emit the messageReceived signal
    emit messageReceived(message);
}

void TCPServer::onDisconnected()
{
    QTcpSocket *clientSocket = qobject_cast<QTcpSocket *>(sender());
    if (!clientSocket)
        return;

    clients.removeOne(clientSocket);
    clientSocket->deleteLater();

    qDebug() << "Client disconnected.";
}
