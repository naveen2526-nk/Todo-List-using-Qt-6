#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <backend.h>
#include <taskmodel.h>
#include <taskitem.h>
#include "timemanager.h"
#include "tcpserver.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;



    qRegisterMetaType<model::TaskItem*>("TaskItem*");
    qRegisterMetaType<Backend>("Backend*");
    qRegisterMetaType<TimeManager>("timeManager*");
    qmlRegisterType<model::TaskModel>("iprospps.besttodolist",1,0,"TaskModel");
    TCPServer tcpServer;
    engine.rootContext()->setContextProperty("tcpServer",&tcpServer);

    TimeManager timeManager;
    engine.rootContext()-> setContextProperty("timeManager",&timeManager);

    Backend backend;

    engine.rootContext()->setContextProperty("backend", &backend);
    //engine.load(QUrl(QLatin1String("qrc:/projectK/main.qml")));
    const QUrl url(u"qrc:/projectK/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
