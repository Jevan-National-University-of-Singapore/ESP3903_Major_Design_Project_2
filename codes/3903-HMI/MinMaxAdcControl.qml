import QtQuick 2.7
import QtQuick.Controls 2.15
import QtQuick.Window 2.2

Item{
    id: min_max
    property string minValue: min_value.text
    property string maxValue: max_value.text
    Rectangle{
        id: min
        color: "grey"
        radius: 5
        anchors{
            left: parent.left
            right:parent.right
            top: parent.top
        }
        height: parent.height/2.5
        TextInput{
            id: min_value
            anchors.fill: parent
            text: "600"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 30
            clip: true
        }
    }
    Rectangle{
        id: max
        color: min.color
        radius: min.radius
        anchors{
            left: parent.left
            right:parent.right
            bottom: parent.bottom
        }
        height: parent.height/2.5
        TextInput{
            id: max_value
            anchors.fill: parent
            text: "700"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 30
            clip: true
        }
    }
}





