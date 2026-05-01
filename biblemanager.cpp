#include "biblemanager.h"
bibleManager::bibleManager(QObject *parent)
    : QObject{parent}
{}
QVariantMap bibleManager::getBook(const QString &bookName, int chapterNum)
{
    QString bookName2 = bookName.isEmpty()?m_book:bookName;
    QString filePth = "C:\\Users\\USER\\AppData\\Roaming\\Sheperd_Bible\\" + m_version + "\\" + bookName2 + ".json";
    QFile file(filePth);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << "File not found at:" << filePth;
        return QVariantMap();
    }

    QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
    QJsonObject root = doc.object();
    QJsonObject bookss= root["chapters"].toObject();
    return bookss.toVariantMap();
}

QStringList bibleManager::listOfBooks(){return canonicalOrder;}
QVariantMap bibleManager::verses(const QString &chapterName, int chapterNum)   {
    QString filePth = "C:\\Users\\USER\\AppData\\Roaming\\Sheperd_Bible\\" + m_version + "\\" + chapterName + ".json";
    QFile file(filePth);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << "File not found at:" << filePth;
        return QVariantMap();
    }

    QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
    QJsonObject root = doc.object();
    QJsonArray chapters = root["chapters"].toArray();

    for (const QJsonValue &v : chapters) {
        QJsonObject chapObj = v.toObject();
        if (chapObj["chapter"].toInt() == chapterNum) {
            QJsonObject verseObj = chapObj["verses"].toObject();
            return verseObj.toVariantMap();
        }
    }
    qInfo()<<"not found length of "<<filePth;

    file.close();
    return QVariantMap();

}
int bibleManager::getBookLength(QString book2){
    QString bookName2 = book2.isEmpty()? m_book : book2;
    m_book = book2;
    QString filePth = "C:\\Users\\USER\\AppData\\Roaming\\Sheperd_Bible\\" + m_version + "\\" + bookName2 + ".json";
    QFile file(filePth);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << "File not found at:" << filePth;
        return 0;
    }

    QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
    QJsonObject root = doc.object();
    QJsonArray bookss= root["chapters"].toArray();
    qInfo()<<"gotten book size "+bookss.size();
    file.close();
    return bookss.size();
}
QVariantList bibleManager::getVerses(int chapter)
{
    QString filePth = "C:\\Users\\USER\\AppData\\Roaming\\Sheperd_Bible\\" + m_version + "\\" + m_book + ".json";
    QFile file(filePth);
    if (!file.open(QIODevice::ReadOnly)) return QVariantList();

    QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
    QJsonArray chapters = doc.object()["chapters"].toArray();

    for(const QJsonValue &value : chapters){
        QJsonObject chapObj = value.toObject();
        if(chapObj["chapter"].toInt() == chapter){
            // Use toVariantList() because "verses" is an array [] in your JSON
            return chapObj["verses"].toArray().toVariantList();
        }
    }
    return QVariantList();
}

int bibleManager::verseLength(int chapter)
{
    qInfo("clled function");
    QString filePth = "C:\\Users\\USER\\AppData\\Roaming\\Sheperd_Bible\\" + m_version + "\\" + m_book+ ".json";
    QFile file(filePth);
    if (!file.open(QIODevice::ReadOnly)) {
        qInfo()<<"hi my file nol they open "+filePth;
        return 0;
    }
    QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
    QJsonArray chapters = doc.object()["chapters"].toArray();

    for(const QJsonValue &value : chapters){
        QJsonObject chapObj = value.toObject();
        if(chapObj["chapter"].toInt() == chapter){
            qInfo()<<"verselength"+chapObj["verses"].toArray().size();
            file.close();
            return chapObj["verses"].toArray().size(); // Correctly get array size
        }
    }
    file.close();
    return 0;
}
