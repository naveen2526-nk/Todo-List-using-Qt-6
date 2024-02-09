import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts



Item {
    id: rootId
    property alias listView: listView
    property alias toolButton: aToDoButton
    property alias toDoTextField: toDoTextField
    property alias newTaskInputRowId: newTaskInputRowId
    property alias createTaskButtonId: createTaskButtonId
    property alias colorPickerId: colorPickerId
    property alias setDeadlineTimeId: setDeadlineTimeId


    property int colorPickerLeftMargin: 50

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent
        spacing: 30


        ToolButton {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom*0.8
            id: aToDoButton
            text: qsTr("Entry Task")
            font.italic: true
            background: Rectangle{

                color:"lightyellow"
            }
        }

        Text {
            id: blankListTextId
            anchors.centerIn: parent
            text: qsTr("Good job! Your To-Do list is blank.")
            visible: !listView.count
        }

        RowLayout {
            id: newTaskInputRowId
            visible: false
            anchors.leftMargin: 10
            z: 1
            TextField {
                id: toDoTextField
                enabled: false
                wrapMode: TextEdit.WordWrap
                Layout.maximumWidth: rootId.width - colorPickerId.width - colorPickerLeftMargin - createTaskButtonId.width
                placeholderText: "Add Tasks"
            }

            ColorPicker{
                id: colorPickerId
                anchors.leftMargin: colorPickerLeftMargin
                z: 1
                height: 25
            }
            ToolButton {
                id: setDeadlineTimeId
                icon.source: "qrc:/edit/stopwatch.png"

                width: 25
                height: 25
                Layout.alignment: Qt.AlignVCenter
                onClicked: {
                    popup.open();}
            }
            Popup {
                id: popup
                width: swipeViewId.width *0.5
                height: swipeViewId.height *0.5
                x:100
                y:100
                contentItem: TimeManager {}
                visible: false
                Layout.alignment: Qt.AlignVCenter
            }
           /* ToolButton{
                id:memTem
                icon.source: "qrc:/edit/group.png"
                width: 25
                height: 25
                Layout.alignment: Qt.AlignVCenter
                onClicked: {
                     //popupbox.open();
                    tcpClient.connectToServer()
                    if (onConnected()){
                    console.log("connected to server")}
                }

            }*/
            ToolButton {
                id: createTaskButtonId
                icon.source: "qrc:/edit/enter.png"
                width: 25
                height: 25
                Layout.alignment: Qt.AlignVCenter
            }


        }

        ListView {
            id: listView
            model: messageModel
            anchors {left: parent.left; right: parent.right}
            Layout.fillHeight: true
            boundsBehavior: Flickable.StopAtBounds
            highlightRangeMode: ListView.NoHighlightRange
        }
    }

}
