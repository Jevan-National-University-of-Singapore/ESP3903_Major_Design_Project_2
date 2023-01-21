import QtQuick 2.7
import QtQuick.Controls 2.15
import QtQuick.Window 2.2

Item{
    id: outdoor_controls
    z: 2
    property string areaName: ""
    property string minTemperature: value_control.minTemperature
    property string maxTemperature: value_control.maxTemperature
    property string minADC: value_control.minADC
    property string maxADC: value_control.maxADC
    signal unselected()
    MouseArea{
        anchors.fill: parent
        onClicked: unselected()
        enabled: outdoor_controls.opacity !== 0
    }
    Item{
        id: controls
        width: parent.width/3
        height: parent.height
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
        }
        Rectangle{
            id: control_surface
            height: parent.height/1.2
            width: parent.width/1.2
            anchors.centerIn: parent
            color: "#444444"
            radius: 5
            opacity: 0.8
        }
            Rectangle{
                id: area_name
                anchors {
                    top: control_surface.top
                    horizontalCenter: control_surface.horizontalCenter
                }
                height: control_surface.height/10
                color: "transparent"
                Text {
                    id: area_name_text
                    anchors.fill:parent
                    text: outdoor_controls.areaName
                    color: "white"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 24
                }
            }
            ValueControl{
                id: value_control
                height: control_surface.height/6
                width: control_surface.width
                anchors {
                    left: control_surface.left
                    top: area_name.bottom
                    topMargin: height/3
                }
            }


    }
}
