import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml.Models



MainPageForm {
    property int selectedHour: selectedHour
    property int selectedMinute: selectedMinute
    toolButton.onClicked: {
        newTaskInputRowId.visible = true;
        toDoTextField.enabled = true;
        toolButton.visible = false;
        toDoTextField.forceActiveFocus();

    }

    TaskListDelegateModel {
        id: messageModel

        listView: parent.listView
    }


    listView.spacing: 4
    listView.model: messageModel
    Connections{
        target: tcpServer
        var textValue =toDoTextField.text;
        onMessageReceived:{
            messageModel.append({"message": message})
        }


    createTaskButtonId.onClicked: {
        var textValue = toDoTextField.text;

        //tcpClient.sendMessage(textValue);
        if (textValue === "")
            return;

        toDoTextField.enabled = false;
        toDoTextField.text = "";
        newTaskInputRowId.visible = false;
        toolButton.visible = true;
        //setDeadlineTime.visible =fasle;

        Qt.inputMethod.hide()
        backend.newTask(textValue, colorPickerId.selectedColor);
        listView.positionViewAtBeginning()
    }
    }
}
