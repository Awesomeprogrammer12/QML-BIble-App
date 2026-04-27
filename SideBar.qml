import QtQuick
import QtQuick.Controls

Rectangle{
    id:sideBar
    width:Math.max(60,parent.width*0.056)
    height:parent.height

    x:0
    y:0
    color:appData.bg
    property string mode : "home"
    property string src: "qrc:/qt/qml/OurVersionBibleApp/"
    Column{
        id:mainColumn
        anchors{top:parent.top;topMargin:5;horizontalCenter: parent.horizontalCenter}
        width:parent.width*0.6
        height:width*5
        spacing:8

        Button{
            id:homeBtn
            width:parent.width
            height:width
            Rectangle{id:homeFiller;color:sideBar.color;anchors.fill: parent}
            Rectangle{id:homeFiller2;color:homeMouse.pressed?appData.bg4:(homeMouse.containsMouse?appData.bg3:(mode === "home"?appData.bg4:sideBar.color));anchors.fill: parent;radius:10}
            MouseArea{id:homeMouse;anchors.fill: parent;hoverEnabled: true;onClicked:{mode = "home"} }
            icon.source: src+"home.png"
            icon.width: parent.width*0.6
            icon.height: parent.width*0.6
            icon.color: appData.fg
        }

        Button{
            id:bibleBtn
            width:parent.width
            height:width
            Rectangle{id:bibleFiller;color:sideBar.color;anchors.fill: parent}
            Rectangle{id:bibleFiller2;color:bibleMouse.pressed?appData.bg4:(bibleMouse.containsMouse?appData.bg3:(mode === "bible"?appData.bg4:sideBar.color));anchors.fill: parent;radius:10}
            MouseArea{id:bibleMouse;anchors.fill: parent;hoverEnabled: true;onClicked:{mode = "bible"}}
            icon.source: src+"bible.png"
            icon.height: parent.width*0.6
            icon.width:parent.width*0.6
            icon.color: appData.fg
        }

        Button{
            id:tasksBtn
            width:parent.width
            height:width
            Rectangle{id:tasksFiller;color:sideBar.color;anchors.fill: parent}
            Rectangle{id:tasksFiller2;color:tasksMouse.pressed?appData.bg4:(tasksMouse.containsMouse?appData.bg3:(mode === "tasks"?appData.bg4:sideBar.color));anchors.fill: parent;radius:10}
            MouseArea{id:tasksMouse;anchors.fill: parent;hoverEnabled: true;onClicked:{mode = "tasks"}}
            icon.source: src+"tasks.png"
            icon.width: parent.width*0.6
            icon.height:parent.width*0.6
            icon.color: appData.fg
        }

        Button{
            id:searchBtn
            width:parent.width
            height:width
            Rectangle{id:searchFiller;color:sideBar.color;anchors.fill: parent}
            Rectangle{id:searhcFiller2;color:searchMouse.pressed?appData.bg4:(searchMouse.containsMouse?appData.bg3:(mode === "search"?appData.bg4:sideBar.color));anchors.fill: parent;radius:10}
            MouseArea{id:searchMouse;anchors.fill: parent;hoverEnabled: true;onClicked:{mode = "search"}}
            icon.source: src + "fallback-search.png"
            icon.width: parent.width*0.6
            icon.height: parent.width*0.6
            icon.color: appData.fg
        }

        Button{
            id:youBtn
            width:parent.width
            height:width
            Rectangle{id:youFiller;color:sideBar.color;anchors.fill: parent}
            Rectangle{id:youFiller2;color:youMouse.pressed?appData.bg4:(youMouse.containsMouse?appData.bg3:(mode === "you"?appData.bg4:sideBar.color));anchors.fill: parent;radius:10}
            MouseArea{id:youMouse;anchors.fill: parent;hoverEnabled: true;onClicked:{mode = "you"}}
            icon.source: src+"you.png"
            icon.width: parent.width*0.6
            icon.height: parent.width*0.6
            icon.color: appData.fg
        }

    }
    Button{
        id:settingsBtn
        width:parent.width
        height:width
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle{id:settingsFiller;color:sideBar.color;anchors.fill: parent}
        Rectangle{id:settingsFiller2;color:settingsMouse.pressed?appData.bg4:(settingsMouse.containsMouse?appData.bg3:(mode === "settings"?appData.bg4:sideBar.color));anchors.fill: parent;radius:10}
        MouseArea{id:settingsMouse;anchors.fill: parent;hoverEnabled: true;onClicked:{mode = "settings"} }
        icon.source: src+"settings.png"
        icon.width: parent.width*0.6
        icon.height: parent.width*0.6
        icon.color: appData.fg
    }
    Rectangle {
        id: indicator
        x: 2
        width: 4
        radius: 2
        color: appData.accent
        readonly property Item targetButton: {
            if (mode === "bible") return bibleBtn;
            if (mode === "tasks") return tasksBtn;
            if (mode === "search") return searchBtn;
            if (mode === "you") return youBtn;
            if(mode === "settings")return settingsBtn;
            return homeBtn;
        }
        ParallelAnimation{
            id:movement
            NumberAnimation { target: indicator; property: "y";
                to:{
                    let baseY = indicator.targetButton.y
                    if(indicator.targetButton.y  !== settingsBtn){
                        baseY += mainColumn.anchors.topMargin
                    }
                    return baseY+2
                }
                duration: 300 ;easing.type:Easing.OutInQuad
            }
            SequentialAnimation{
                NumberAnimation { target: indicator; property: "height";from:indicator.targetButton.height * 0.7; to: indicator.targetButton.height * 0.9; duration:200;easing.type:Easing.OutQuad }
                NumberAnimation { target: indicator; property: "height";from:indicator.targetButton.height * 0.9; to: indicator.targetButton.height * 0.7; duration:250;easing.type:Easing.InQuad}
            }
        }
    }
    onModeChanged: movement.restart()
    Component.onCompleted: movement.restart()
}






























