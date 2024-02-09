import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: item1
    width: 400
    height: 400
    property alias appVersionText: appVersionText
   // property alias privacyPolicyTextAreaId: privacyPolicyTextAreaId
    property alias okButton: okButton
    property real policyOffset: 0.9

    ColumnLayout {
        id: column

        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter

        width: parent.width * policyOffset

        Text {
            id: appTitleText
            text: qsTr("Best To-Do List")
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
            id: privacyPolicyTextAreaId
            Layout.topMargin: 10
            Layout.fillHeight: true
            readOnly: true
            font.pixelSize: 12
            textFormat: Text.RichText
            Layout.maximumWidth: parent.width
            wrapMode: TextEdit.WordWrap

            text: qsTr("<p><center><b>ABD</b></center><br>
                              hi.")
            anchors.horizontalCenter: parent.horizontalCenter
        }*/

        Text {
            id: appCopyrightsText
            text: qsTr("kiityversion, 1.0.0")
            font.pixelSize: 12
            Layout.topMargin: 10
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            id: okButton
            width: 50
            height: 20
            text: qsTr("OK")
            Layout.topMargin: 10
        }
    }
}
