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
        }
    }

    //  views
    ScrollView {
        anchors.fill: parent

        Component.onCompleted: {
            console.log(height);
        }


        ListView {
            width: parent.width
            model: sensorListDataModel.sensorList

            delegate: ItemDelegate {
                id: sensorListItemDelegate
                width: parent.width
                height: 104
                highlighted: false

                property int borderWidth: 2

                Rectangle {
                    id: listItemBorder
                    width: parent.width
                    height: parent.height
                    color: "#00000000"
                    radius: 2
                    border.width: parent.borderWidth
                    border.color: "#e0e0a8"
                }

                Text {
                    id: sensorListItemDescription
                    text: modelData
                    x: parent.borderWidth
                    y: 2
                    width: parent.width - parent.borderWidth
                    height: parent.height / 4
                    font.pointSize: 12
                    color: "#e0e0a8"
                }

                Text {
                    id: sensorListItemDelegateText_2
                    x: parent.borderWidth
                    y: parent.height / 4 + parent.borderWidth
                    text: modelData
                    width: parent.width - parent.borderWidth
                    height: 3 * parent.height / 4
                    font.pointSize: 12
                    color: "#e0e0a8"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (modelData == "QCompass") {
                            sensorListItemDescription.text = compass.description
                            compass.active = true
                        }
                        else if (modelData == "QPressureSensor") {
                            sensorListItemDescription.text = pressureSensor.description
                            pressureSensor.active = true
                        }
                        else if (modelData == "QMagnetometer") {
                            sensorListItemDescription.text = magnetometer.description
                            magnetometer.active = true
                        }
                    }
                }

                // sensors of interest
                Compass {
                    id: compass
                    active: false

                    onReadingChanged: {
                        if (modelData == "QCompass") {
                            sensorListItemDelegateText_2.text = reading.azimuth
                        }
                    }
                }

                PressureSensor {
                    id: pressureSensor
                    active: false

                    onReadingChanged: {
                        if (modelData == "QPressureSensor") {
                            sensorListItemDelegateText_2.text = reading.pressure +
                                    "\t" + reading.temperature
                        }
                    }
                }

                Magnetometer {
                    id: magnetometer
                    active: false

                    onReadingChanged: {
                        if (modelData == "QMagnetometer") {
                            sensorListItemDelegateText_2.text = reading.x +
                                    "\n" + reading.y + "\n" + reading.z +
                                    "\n" + reading.calibrationLevel
                        }
                    }
                }
            }
        }
    }

}
