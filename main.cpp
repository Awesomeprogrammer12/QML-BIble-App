#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "biblemanager.h"
#include <QQmlContext>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("OurVersionBibleApp", "Main");
    bibleManager manager;
    engine.rootContext()->setContextProperty("BibleManager", &manager);
    return QCoreApplication::exec();
}
