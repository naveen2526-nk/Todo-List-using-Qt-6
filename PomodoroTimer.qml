import QtQuick 2.15
import QtQuick.Controls 2.15

Item{
    visible: true
    width: Screen.width
    height: Screen.height
    id:pomodorotimer


    property int totalDurationHours: 2
    property int workDuration: 0 * 60
    property int breakDuration: 0 * 60
    property bool isWorking: true
    property int remainingTime: workDuration
    property bool isRunning: false
    property real animationOpacity: 0

    Timer {
        id: timer
        interval: 1000
        running: isRunning
        repeat: true
        onTriggered: {
            if (remainingTime > 0) {
                remainingTime--;
            } else {
                isWorking = !isWorking;
                if (isWorking) {
                    remainingTime = workDuration;
                } else {
                    remainingTime = breakDuration;
                }
            }
        }
    }

    Text {
        anchors.centerIn: parent
        text: formatTime(remainingTime)
        font.pixelSize: 30
        opacity: animationOpacity

        Behavior on opacity {
            NumberAnimation {
                duration: 500
                easing.type: Easing.InOutQuad
            }
        }

        onTextChanged: {
            animationOpacity = 0;
            animationOpacity = 1;
        }
    }

    Column {
        spacing: 20
        anchors.centerIn: parent

        Rectangle {
            width: 200
            height: 200
            color: "#F0F0F0"
            border.color: "#CCCCCC"
            border.width: 2
            radius: width / 2

            Item {
                width: 20
                height: 20
                property real angle: 0

                x: Math.cos(angle) * (width / 2) + parent.width / 2 - width / 2
                y: Math.sin(angle) * (height / 2) + parent.height / 2 - height / 2

                onAngleChanged: {
                    x = Math.cos(angle) * (width / 2) + parent.width / 2 - width / 2
                    y = Math.sin(angle) * (height / 2) + parent.height / 2 - height / 2
                }
            }

            Text {
                anchors.centerIn: parent
                text: formatTime(remainingTime)
                font.pixelSize: 30
            }
        }

        Column {
            spacing: 10

            Rectangle {
                width: 200
                height: 35
                color: "transparent"

                Label {
                    anchors.left: parent.left
                    text: "POMODORO"
                }

                TextField {
                    text: (workDuration / 60).toString()
                    onEditingFinished: {
                        workDuration = parseInt(text) * 60;
                    }
                    height: parent.height
                    width: parent.width * 0.25
                    anchors.right: parent.right
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Rectangle {
                width: 200
                height: 35
                color: "transparent"

                Label {
                    anchors.left: parent.left
                    text: "INTERVAL"
                }
                TextField {
                    text: (breakDuration / 60).toString()
                    onEditingFinished: {
                        breakDuration = parseInt(text) * 60;
                    }
                    height: parent.height
                    width: parent.width * 0.25
                    anchors.right: parent.right
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        Row {
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                text: isRunning ? "Stop" : "Start"
                onClicked: {
                    isRunning = !isRunning;
                    if (isRunning) {
                        timer.start();
                    } else {
                        timer.stop();
                    }
                }
                width: 80
                height: 40
            }

            Button {
                text: "Restart"
                onClicked: {
                    // Add code here to restart the timer or perform any other action you need
                    remainingTime = workDuration;
                    isWorking = true;
                    isRunning = false;
                }
                width: 80
                height: 40
            }

        }
    }

    function formatTime(timeInSeconds) {
        var minutes = Math.floor(timeInSeconds / 60);
        var seconds = timeInSeconds % 60;
        return minutes.toString() + ":" + (seconds < 10 ? "0" : "") + seconds.toString();
    }
}
