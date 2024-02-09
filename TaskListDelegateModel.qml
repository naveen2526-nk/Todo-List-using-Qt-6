import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml.Models

Item {
    property alias visualModel: visualModelId
    property ListView listView



    DelegateModel {
            id: visualModelId
            delegate: dragDelegate

        }

    Component {
            id: dragDelegate


            MouseArea {
                id: dragArea

                property bool held: false
                property string itemcolor: object.color
                property real backgroundOpacity: 0.8

                anchors { left: parent.left; right: parent.right }
                height: content.height

                drag.target: held ? content : undefined
                drag.axis: Drag.YAxis
                drag.minimumY: 0
                drag.maximumY: listView.contentHeight - dragArea.height

                onPressAndHold: held = true
                onReleased: held = false
                onClicked: {
                    textAreaId.inEditMode = false
                    Qt.inputMethod.hide()
                }

                Rectangle {
                    id: content

                    height: textAreaId.height
                    width: parent.width
                    color: itemcolor
                    opacity: dragArea.backgroundOpacity

                    anchors {
                        verticalCenter: parent.verticalCenter
                    }

                    Drag.active: dragArea.held
                    Drag.source: dragArea
                    Drag.hotSpot.x: width / 2
                    Drag.hotSpot.y: height / 2

                    states: State {
                        when: dragArea.held

                        ParentChange { target: content; parent: listView }
                        AnchorChanges {
                            target: content
                            anchors { horizontalCenter: undefined; verticalCenter: undefined }
                        }
                    }

                    RowLayout {
                        id: rowId

                        anchors.verticalCenter: parent.verticalCenter

                        CheckBox {
                            id: checkboxId
                            checked: object.done

                            onCheckStateChanged: {
                                object.done = checked
                            }
                        }

                        TextArea {
                            id: textAreaId
                            property bool inEditMode: false

                            font.bold: true
                            font.strikeout: checkboxId.checked
                            text: object.title
                            readOnly: !inEditMode
                            wrapMode: TextEdit.WordWrap
                            Layout.preferredWidth: dragArea.width - checkboxId.width - deleteTaskButtonId.width - dragIndicatorTextId.width
                            Layout.preferredHeight: dragArea.height - checkboxId.height -deleteTaskButtonId.height-dragIndicatorTextId.height
                            background: Rectangle {
                                Layout.preferredHeight: textAreaId.height
                                Layout.preferredWidth: textAreaId.width
                                border.color: textAreaId.readOnly ?  "transparent" : "transparent"
                                color: "transparent"

                            }
                            MouseArea {
                                anchors.fill: parent
                                enabled: textAreaId.inEditMode !== true
                                visible: textAreaId.inEditMode !== true

                                onPressAndHold: {
                                    dragArea.held = true
                                }

                                onReleased: dragArea.held = false

                                drag.target: dragArea.held ? content : undefined
                                drag.axis: Drag.YAxis
                                drag.minimumY: 0
                                drag.maximumY: listView.contentHeight - dragArea.height
                            }

                            onEditingFinished: {
                                inEditMode = false
                                object.title = text
                                Qt.inputMethod.hide()
                            }
                        }
                    }

                    ToolButton {
                        id: editTaskButtonId
                        icon.source: textAreaId.inEditMode ? "qrc:/edit/enter.png" : "qrc:/edit/write.png"
                        visible: !object.done
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: dragIndicatorTextId.right
                        anchors.rightMargin: 40
                        background: Rectangle {
                                   width: 40
                                    height: 40

                                  color: editTaskButtonId.down ? "transparent" : "transparent"
                        }
                        onReleased: {
                            if (textAreaId.inEditMode) {
                                textAreaId.inEditMode = false
                                object.title = textAreaId.text
                                Qt.inputMethod.hide()
                            } else {
                                textAreaId.inEditMode = true
                                textAreaId.selectAll()
                                listView.positionViewAtIndex(index, ListView.Beginning)
                            }
                        }
                    }

                    ToolButton {
                        id: deleteTaskButtonId
                        icon.source: "qrc:/edit/close.png"
                        visible: object.done
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: dragIndicatorTextId.right
                        anchors.rightMargin: 40
                        background: Rectangle {
                                  width:40
                                  height: 40
                                  color: deleteTaskButtonId.down ? "transparent" : "transparent"
                              }
                        onReleased: {
                            backend.deleteCompletedTask(object)
                        }
                    }


                    Text {
                        id: dragIndicatorTextId

                        font.family: "Segoe MDL2 Assets"
                        anchors.right: parent.right
                        width: 40
                        height: 40
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter

                        anchors.verticalCenter: parent.verticalCenter
                        color: dragArea.held ? "white" : "black"
                        Behavior on color { ColorAnimation { duration: 100 } }
                    }
                }
                DropArea {
                    anchors { fill: parent }

                    onEntered: {
                        object.order = drag.source.DelegateModel.itemsIndex
                        visualModel.items.move(
                                drag.source.DelegateModel.itemsIndex,
                                dragArea.DelegateModel.itemsIndex)
                    }
                }
            }
        }

}