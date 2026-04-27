import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id:biblePage
    anchors{top:parent.top;bottom:parent.bottom;left:sideBar.right;right:parent.right}
    color:appData.bg2
    radius:10
    gradient:Gradient{
        GradientStop{position:0;color:appData.bg3}
        GradientStop{position:0.2;color:"transparent"}
        GradientStop{position:0.8;color:"transparent"}
        GradientStop{position:1;color:appData.bg3}
    }
    Rectangle{
        id:selector
        z:1
        anchors.top:parent.top
        width:parent.width
        height:parent.height*0.1
        radius:10
        color:appData.bg3
        Button{
            id:chapterChoosBtn
            width:parent.width*0.25
            height:parent.height*0.8
            x:2
            anchors.verticalCenter:  parent.verticalCenter
            text:appData.curBook;palette.buttonText: appData.fg
            Rectangle{id:chapFiller;color:appData.bg3;anchors.fill: parent}
            Rectangle{id:chapFill;color:chapMouse.pressed?appData.bg2:(chapMouse.containsMouse?appData.bg4:appData.bg3);anchors.fill: parent;radius:10}
            MouseArea{id:chapMouse;anchors.fill: parent;hoverEnabled: true;
                onClicked: {
                    select.open()
                    root.getlistOfChapters()
                }
            }
            Popup{
                id:select
                width:biblePage.width*0.5
                height: biblePage.height
                x:parent.x+15
                y:parent.y
                background: Rectangle{
                    color:appData.bg2
                    radius:10
                    border.color: "gold"
                    border.width: 2
                }
                Flickable{
                    id:bookSelect
                    anchors.fill: parent
                    x:-2
                    y:0
                    width:parent.width*0.6
                    scale:0.9
                    height:parent.height
                    contentHeight: buttonGrid.height
                    contentWidth: width
                    boundsBehavior: Flickable.FollowBoundsBehavior
                    Rectangle{id:action;width:parent.width;height:30;color:appData.bg;
                        Text{id:versionSpecified;text:"Version:"+appData.version;anchors{centerIn:parent;}font.bold: true;font.pixelSize: 15;color:appData.fg}}
                    Grid{
                        id:buttonGrid
                        width:parent.width
                        x:0
                        y:33
                        columns:4
                        scale:0.95
                        spacing:10
                        height:900
                        Repeater{
                            id:buttonModel
                            model:root.listOfBooks
                            Button{
                                id:button
                                width: (buttonGrid.width ) / buttonGrid.columns
                                height: buttonGrid.height/20
                                Text {
                                    text: modelData.replace(/_/g, " ")
                                    anchors.fill: parent
                                    z:2
                                    font.pixelSize: (root.width+root.height)*0.008;
                                    color: appData.fg;font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }

                                Rectangle {id: parent2;anchors.fill: parent;color: appData.bg;border.width: 4;border.color: modelData === appData.curBook?appData.accent:parent2.color}
                                onClicked: {
                                    chapSelect.visible = true
                                    bookSelect.visible = false
                                    appData.curBook = modelData
                                }
                            }
                        }
                    }
                }
                Flickable{
                    id:chapSelect
                    anchors.fill: parent
                    visible:false
                    x:-2
                    y:0
                    width:parent.width*0.6
                    scale:0
                    z:20
                    height:parent.height
                    contentHeight: buttonGrid.height
                    contentWidth: width
                    boundsBehavior: Flickable.FollowBoundsBehavior
                    Rectangle{id:action2;width:parent.width;height:30;color:appData.bg;
                        Text{id:versionSpecified2;text:"Chapter:"+appData.curBook;anchors{centerIn:parent;}font.bold: true;font.pixelSize: 15;color:appData.fg}}
                    Grid{
                        id:buttonGrid2
                        width:parent.width
                        x:0
                        y:33
                        columns:4
                        scale:0.95
                        spacing:10
                        height:500
                        Repeater{
                            id:buttonModel2
                            model:root.gBookLength()
                            Button{
                                id:button2
                                width: (buttonGrid.width ) / buttonGrid.columns
                                height: buttonGrid.height/buttonModel2.model
                                Text {
                                    text: modelData
                                    anchors.fill: parent
                                    z:2
                                    font.pixelSize: (root.width+root.height)*0.008;
                                    color: appData.fg;font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                Component.onCompleted: {
                                    if (modelData === appData.curChapter){
                                        parent22.border.width = 2
                                        parent22.border.color = appData.accent
                                    }
                                 }
                                Rectangle {id: parent22;anchors.fill: parent;color: appData.bg}
                                onClicked: {
                                    bookSelect.visible = false
                                    appData.curChapter = modelData
                                }
                            }
                        }
                    }
                }

            }
        }
    }
}


