import QtQuick
import QtQuick.Controls
Window {
    id:root
    width: 750
    height: 480
    minimumWidth:750
    minimumHeight: 400
    visible: true
    color:appData.bg1
    title: qsTr("Hello World")
    property var listOfBooks: ({})
    Item{
        id:appData
        Component.onCompleted: {
            root.listOfBooks = BibleManager.listOfBooks()
        }
        property var currentChapterData: ({})
        property string bg: "#1f1f1f"
        property string bg1:"#2f2f2f"
        property string bg2:"#4f4f4f"
        property string bg3:"#6f6f6f"
        property string bg4:"#8f8f8f"
        property string accent : "purple"
        property string fg: "white"
        property string version:BibleManager.version
        property string curBook: "Choose A Chapter"
        property int curChapter:0
    }
    Component.onCompleted: {
        console.log(listOfBooks)
        console.log(appData.version)
    }

    SideBar{id:sideBar}
    BiblePage{id:biblePage}
    /*Rectangle {
        id: root2
        anchors.fill: parent
        color: appData.bg1

        property var currentChapterData: ({})

        Button {
            id: loadBtn
            text: "Load Acts Chapter 1"
            anchors.centerIn: parent

            onClicked: {
                BibleManager.version = "UKJV"
                // 2. ASSIGN the return value to your property
                root2.currentChapterData = BibleManager.getChapter("Acts", 1)

                console.log("Loaded verses:", root2.currentChapterData.verses.length)
            }
        }

        ListView {
            width: parent.width
            height: parent.height - loadBtn.height
            anchors.top: loadBtn.bottom
            clip: true

            // Use the property we just updated
            model: root2.currentChapterData.verses

            delegate: Row {
                spacing: 10
                padding: 10
                Text {
                    text: modelData.verse
                    color: "white"
                    font.bold: true
                }
                Text {
                    text: modelData.text
                    color: "white"
                    width: root2.width - 50
                    wrapMode: Text.WordWrap
                }
            }
        }
    }
    */
    property var listOfVerses:({})
    function getlistOfChapters(){
         BibleManager.version = "UKJV"
        root.listOfBooks = BibleManager.listOfBooks()
        root.listOfVerses = BibleManager.verses("Isaiah",1);
        var list = root.listOfVerses
        console.log("got"+root.listOfBook)
        console.log("verses length"+list[1])
        console.log(appData.version)
    }
    function gBookLength(){
        return BibleManager.getBookLength("")
    }
}

