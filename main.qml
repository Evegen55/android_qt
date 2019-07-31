import QtQuick 2.12
import QtQuick.Controls 2.5
import QtSensors 5.11
import QtSensors 5.11 as Sensors

ApplicationWindow {
    visible: true
    width: 720
    height: 1280
    title: qsTr("Sensors")

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
                text: modelData
                width: parent.width

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (modelData == "QCompass") {
                            parent.text = compass.reading.azimuth
                        }
                    }
                }
            }
        }
    }

    // sensors of intrest
    Compass {
        id: compass
        active: true
    }
}
