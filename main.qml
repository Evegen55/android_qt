import QtQuick 2.12
import QtQuick.Controls 2.12
import QtSensors 5.11
import QtSensors 5.11 as Sensors

ApplicationWindow {
    visible: true
    width: 720
    height: 1280
    title: qsTr("Sensors")

    //    menu containing two menu items
    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: console.log("Open action triggered");
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    //    models
    ListModel {
        id: sensorListDataModel
        property var sensorList: null

        Component.onCompleted: {
            sensorList = QmlSensors.sensorTypes();
            //                 console.log(types.join(", "));
        }
    }

    //  views
    ScrollView {
        anchors.fill: parent

        ListView {
            width: parent.width
            model: sensorListDataModel.sensorList

            delegate: ItemDelegate {
                id: sensorListItemDelegate
                width: parent.width

                Text {
                    id: sensorListItemDelegateText
                    text: modelData
                    color: "white"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (modelData == "QCompass") {
                            compass.active = true
                        }
                    }
                }

                // sensors of interest
                Compass {
                    id: compass
                    active: false

                    onReadingChanged: {
                        if (modelData == "QCompass") {
                            sensorListItemDelegateText.text = reading.azimuth
                        }
                    }
                }
            }
        }
    }

}
