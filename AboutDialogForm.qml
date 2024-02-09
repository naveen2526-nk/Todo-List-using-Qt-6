
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
    id: item1
    width: 400
    height: 400
    property alias appVersionText: appVersionText
    //property alias privacyPolicyTextAreaId: privacyPolicyTextAreaId
    property alias okButton: okButton
    property real policyOffset: 0.9

    ColumnLayout {
        id: column

        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter

        width: parent.width * policyOffset

        Text {
            id: appTitleText
            text: qsTr("Info")
            font.bold: true
            font.family: "Times New Roman"
            font.pixelSize: 20
            Layout.topMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: appVersionText
            text: qsTr("Application version: ")
            font.pixelSize: 12
            Layout.topMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter
        }

        /*TextArea {
            id: infoId
            Layout.topMargin: 10
            Layout.fillHeight: true
            readOnly: true
            font.pixelSize: 12
            textFormat: Text.RichText
            Layout.maximumWidth: parent.width
            wrapMode: TextEdit.WordWrap

            text: qsTr("<p><center><b>ToDo list</b></center><br>
                              This application used for the group of task compilation and individual as well as group tasks.")
            anchors.horizontalCenter: parent.horizontalCenter
        }*/

        Text {
            id: appCopyrightsText
            text: qsTr("kiityversion 1.0.0")
            font.pixelSize: 12
            Layout.topMargin: 10
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

        ToolButton {
            anchors.horizontalCenter: parent.horizontalCenter
            id:profileButton
            width: 1
            height: 5
            Layout.topMargin: 100



        }

        Button{
            anchors.horizontalCenter: parent.horizontalCenter
            id:okButton
            width: 100
            height: 50
            text: qsTr("OK")
            Layout.topMargin: 10
        }

    }
}
