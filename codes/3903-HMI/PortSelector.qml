import QtQuick 2.7
import QtQuick.Controls 2.15
import QtQuick.Window 2.2

Item{
    id: port_selection_group
    property string portName: "COM0"
    Item {
        height: parent.height
        width: parent.width/2
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle{
            id: com_text_rectangle
            anchors{
                top: parent.top
                left: parent.left
            }
            width: parent.width/2.5
            height: parent.height
            color: "transparent"
            Text {
                id: com_text
                anchors.fill:parent
                text: "COM:"
                color: "white"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pointSize: 32
            }
        }
        Rectangle{
            id: port_input_box
            color:"grey"
            radius:5
            anchors{
                top: parent.top
                left: com_text_rectangle.right
                bottom: parent.bottom
            }
            width: com_text_rectangle.width/1.5

            TextInput{
                id: port_number
                anchors.fill: parent
                text: "0"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pointSize: 36
                leftPadding: width/10
                clip: true
            }
        }
        Rectangle{
            id: port_button
            color: "#333333"
            radius:5
            anchors{
                top: parent.top
                left: port_input_box.right
                right: parent.right
                bottom: parent.bottom
                leftMargin: parent.width/10
            }
            TextInput{
                anchors.fill: parent
                text: "OK"
                color:"white"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pointSize: 30
                leftPadding: width/10
                clip: true
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (parseInt(port_number.text)){
                        port_selection_group.portName = "COM"+port_number.text
                        console.log("COM port changing to: ",port_selection_group.portName)
                    } else {
                        console.log("invalid port number")
                    }

                }
                onPressed: parent.color = "#222222"
                onReleased: parent.color = "#333333"
            }
        }


    }
}
