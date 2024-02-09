import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import "qrc:/edit"

ApplicationWindow {
    id: rootId
    visible: true
    width: 360
    height: 640
    Image {
        source:"qrc:/edit/k.png"
        width: parent.width
        height: parent.height
    }
    header:ToolBar{
        background: Rectangle {
                    color: "transparent"
                }

        Text {
            id: todo
            text: qsTr("TASKS")
            font.bold:true
            anchors.centerIn: parent

        }
    }

    footer: ToolBar {

        ToolButton{
            id:memTem
            icon.source: "qrc:/edit/group.png"
            width: 25
            height: 25
            Layout.alignment: Qt.AlignVCenter
            onClicked: {

                tcpServer.connectToClient()
            }

        }
        ToolButton {
            icon.source: pageIndicator.currentIndex === 0 ? ("qrc:/edit/check-list.png") : ("qrc:/edit/check-mark.png")
            anchors.centerIn: parent
            font.bold: true
        }

        ToolButton {
            icon.source:  pageIndicator.currentIndex === 0 ? ("qrc:/edit/check-mark.png") : ("qrc:/edit/check-list.png")
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            onClicked: swipeViewId.setCurrentIndex(pageIndicator.currentIndex === 0 ? 1 : 0)
        }
    }



    Dialog {
        id: aboutDialogId
        contentItem: AboutDialog {
            id: aboutContentItemId
            anchors.fill: parent
            okButton.onClicked: {
                aboutDialogId.close()
            }
        }
        standardButtons: StandardButton.Ok
    }

    SwipeView {
        id: swipeViewId

        currentIndex: pageIndicator.currentIndex
        anchors.fill: parent

        MainPage {
        }

        DonePage {

        }
    }

    PageIndicator {
          id: pageIndicator
          interactive: true
          count: swipeViewId.count
          currentIndex: swipeViewId.currentIndex

          anchors.bottom: parent.bottom
          anchors.horizontalCenter: parent.horizontalCenter
      }

}
