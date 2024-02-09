import QtQuick
import QtQuick.Controls
import QtQuick.Layouts



Item {
    width: Screen.width
    height: Screen.height
    property alias doneListView: doneListView

    Text {
        anchors.centerIn: parent
        text: qsTr("You don't have completed tasks yet!")
        visible: !doneListView.count
    }

    ColumnLayout {
        anchors.fill: parent

        ListView {
            id: doneListView
            anchors {left: parent.left; right: parent.right}
            Layout.fillHeight: true
            boundsBehavior: Flickable.StopAtBounds
            highlightRangeMode: ListView.NoHighlightRange
        }
    }
}
