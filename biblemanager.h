#ifndef BIBLEMANAGER_H
#define BIBLEMANAGER_H

#include <QObject>
#include <QString>
#include <QDebug>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <QStandardPaths>
#include <QDir>

class bibleManager : public QObject
{
    Q_OBJECT
public:
    explicit bibleManager(QObject *parent = nullptr);
public:
    QString m_version;
    QString m_book;
    Q_PROPERTY(QString version READ version WRITE setVersion NOTIFY versionChanged)
    Q_PROPERTY(QString book READ book WRITE setBook NOTIFY bookChanged)
    Q_INVOKABLE QVariantMap getBook(const QString &bookName, int chapterNum);
    Q_INVOKABLE QStringList listOfBooks();
    QString version()  const {return m_version;}
    void setVersion(const QString version){
        m_version = version;
        emit versionChanged();
    }
    QString book()  const {return m_book;}
    void setBook(const QString chapter){
        if(listOfBooks().contains(chapter)){
            m_book = chapter;
            emit book();
        }
        qInfo()<<"book doesnt exist";
    }
    Q_INVOKABLE QVariantMap verses(const QString &chapterName, int chapterNum);
    Q_INVOKABLE int getBookLength(QString book2);
signals:
    void versionChanged();
    void bookChanged();
private:
    const QStringList canonicalOrder = {
        "Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy", "Joshua", "Judges",
        "Ruth", "I_Samuel", "II_Samuel", "I_Kings", "II_Kings", "I_Chronicles", "II_Chronicles",
        "Ezra", "Nehemiah", "Esther", "Job", "Psalms", "Proverbs", "Ecclesiastes",
        "Song_of_Solomon", "Isaiah", "Jeremiah", "Lamentations", "Ezekiel", "Daniel",
        "Hosea", "Joel", "Amos", "Obadiah", "Jonah", "Micah", "Nahum", "Habakkuk",
        "Zephaniah", "Haggai", "Zechariah", "Malachi", "Matthew", "Mark", "Luke",
        "John", "Acts", "Romans", "I_Corinthians", "II_Corinthians", "Galatians",
        "Ephesians", "Philippians", "Colossians", "I_Thessalonians", "II_Thessalonians",
        "I_Timothy", "II_Timothy", "Titus", "Philemon", "Hebrews", "James", "I_Peter",
        "II_Peter", "I_John", "II_John", "III_John", "Jude", "Revelation_of_John"
    };
};
#endif // BIBLEMANAGER_H
