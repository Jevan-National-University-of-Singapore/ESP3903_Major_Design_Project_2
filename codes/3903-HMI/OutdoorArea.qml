import QtQuick 2.7
import QtQuick.Controls 2.15
import QtQuick.Window 2.2





Item{
    id: area
    property real adcValue
    property real minTemperature
    property real maxTemperature
    property real minADC: 600
    property real maxADC: 700
    property real rangeADC: maxADC - minADC
    property real temperaturePercentage: 10
    property bool selected: false
    Rectangle {
        id: heat_color_outdoor_1
        anchors.fill: parent
//        color: temperaturePercentage? Qt.rgba(parent.temperaturePercentage, 0.8 - 0.75*(parent.temperaturePercentage-0.2), 0.1, 1) : "Grey"
        color: Qt.rgba(parent.temperaturePercentage, 0.8 - 0.75*(parent.temperaturePercentage-0.2), 0.1, 1)
        radius: 5

        border {
            color: "white"
            width: selected? 6:0
        }
        Rectangle{
            id: temperature_text_box
            anchors{
                bottom: parent.bottom
                right: parent.right
            }
            height: parent.height/6
            width: parent.width/3
            color: "transparent"
            Text {
                id: temperatureText
                anchors.fill: parent
                text: qsTr("%1\xB0C").arg(
                    ((temperaturePercentage * (maxTemperature-minTemperature)) + minTemperature).toFixed(2)
                )
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                rightPadding: parent.width/10
                font.pointSize: 22
                clip: true

            }
        }
        Item{
            id: fan_feedback
            anchors{
                top: parent.top
                left: parent.left
            }
            height: parent.height/6
            width: parent.width
            Image {
                id: fan_icon
                source: "qrc:/Images/fan.png"
                anchors{
                    top: parent.top
                    left: parent.left
                    leftMargin: width/4
                }
                height: parent.height
                width: height
                autoTransform: true
                fillMode: Image.PreserveAspectFit
            }
            Rectangle{
                id: fan_speed_details
                anchors{
                    top: parent.top
                    left: fan_icon.right
                    right: parent.right
                    bottom: parent.bottom
                }
                color: "transparent"
                Text{
                    id: fan_speed
                    anchors.fill: fan_speed_details
                    text: qsTr("%1 rpm").arg(
                        Math.round(temperaturePercentage * 1000) + 1000
                    )
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
//                    rightPadding: parent.width/10
                    font.pointSize: 22
                    clip: true
                }
            }
        }


        MouseArea{
            anchors.fill: parent
            onClicked: selected ^= true
        }
    }
    onMinADCChanged: {
        rangeADC = maxADC-minADC
    }
    onMaxADCChanged: {
        rangeADC = maxADC-minADC
    }
    Rectangle{
        id: adc_value_textbox
        height: parent.height/8
        width: parent.width/2
        anchors{
            top: parent.top
            right: parent.right
        }
        color: "transparent"

        Text{
            id: adc_value_text
            anchors.fill: parent
            text: adcValue.toFixed(2)
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            font.pointSize: 22
            clip: true
        }
    }
    Rectangle{
        id: percentage_textbox
        height: parent.height/8
        width: parent.width/2
        anchors{
            bottom: parent.bottom
            left: parent.left
        }
        color: "transparent"

        Text{
            id: percentage_text
            anchors.fill: parent
            text: qsTr(" %1%").arg((temperaturePercentage*100).toFixed(2))
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pointSize: 22
            clip: true
        }
    }
    NumberAnimation {
        id: outdoor1_change
        target: area
        running: true
        properties: "temperaturePercentage"
        to: (adcValue-minADC)/rangeADC
        duration: 1000
    }
    onAdcValueChanged: outdoor1_change.start()

}

