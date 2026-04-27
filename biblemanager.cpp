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

    return QVariantMap();
}
int bibleManager::getBookLength(QString book2){
    QString bookName2 = book2.isEmpty()? m_book : book2;
    QString filePth = "C:\\Users\\USER\\AppData\\Roaming\\Sheperd_Bible\\" + m_version + "\\" + bookName2 + ".json";
    QFile file(filePth);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << "File not found at:" << filePth;
        return 0;
    }

    QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
    QJsonObject root = doc.object();
    QJsonArray bookss= root["chapters"].toArray();
    return bookss.size();
}