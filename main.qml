import QtQuick 2.12
import QtQuick.Controls 2.5
import QtSensors 5.12
import QtSensors 5.12 as Sensors

ApplicationWindow {
    visible: true
    width: 720
    height: 1280
    title: qsTr("Scroll")

    ScrollView {
        anchors.fill: parent

        ListView {
            width: parent.width
            model: QmlSensors.sensorTypes()
            delegate: ItemDelegate {
                text: modelData
                width: parent.width
            }
        }
    }
}
