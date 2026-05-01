#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "biblemanager.h"
#include <QQmlContext>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    bibleManager manager;
    engine.rootContext()->setContextProperty("BibleManager", &manager);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("OurVersionBibleApp", "Main");
    return QCoreApplication::exec();
}
