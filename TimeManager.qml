import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
    id: setDeadlineTime
    visible: true
    width: swipeViewId.width * 0.5
    height: swipeViewId.height * 0.5
    property alias button: timeBtn


    Rectangle{
        width : parent.width
        height: parent.height

        ColumnLayout{
            anchors.centerIn: parent
            spacing: 10

            ColumnLayout {
                spacing: 10

                Text {
                    id: hourtext
                    text: qsTr("Hrs")
                    width: parent.width
                    height: parent.height
                }

                SpinBox{
                    id:hourSpinBox
                    width: parent.width / 2
                    from: 0
                    to: 24
                    stepSize: 1
                    x:10
                    y:10
                }
                Text {
                    id: minutetext
                    text: qsTr("Mins")
                    width: parent.width
                    height: parent.height
                }
                SpinBox{
                    id:minuteSpinBox
                    width: parent.width / 2
                    from: 0
                    to: 59
                    stepSize: 1
                    x:10
                    y:10
                }
                Button {
                    id: timeBtn
                    text: "Set Deadline"
                    width: parent.width - 20
                    onClicked: {
                        var selectedHour = hourSpinBox.value;
                        var selectedMinute = minuteSpinBox.value;

                        // Call the C++ function to set the deadline
                        timeManager.setdeadline(selectedHour, selectedMinute);
                         console.log("hour",selectedHour,"min",selectedMinute)
                        popup.close()
                    }}
            }
        }
    }
}


