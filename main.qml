import QtQuick 2.12
import QtQuick.Controls 2.5
import QtSensors 5.11
import QtSensors 5.11 as Sensors

ApplicationWindow {
    visible: true
    width: 720
    height: 1280
    title: qsTr("Scroll")

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
                text: modelData //QmlSensors.defaultSensorForType(modelData)
                width: parent.width
            }
        }
    }
}
