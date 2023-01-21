import QtQuick 2.7
import QtQuick.Controls 2.15
import QtQuick.Window 2.2


Item{
    id: value_control
    property string minTemperature: temperature_control.minValue
    property string maxTemperature: temperature_control.maxValue
    property string minADC: adc_control.minValue
    property string maxADC: adc_control.maxValue
    Item{
        id: min_label
        anchors{
            left: parent.left
            top: parent.top
        }
        width: parent.width/5
        height: parent.height/2.5
        TextInput{
            id: min_text
            anchors.fill: parent
            text: "Min:"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            font.pointSize: 30
            clip: true
        }
    }
    Item{
        id: max_label
        anchors{
            left: parent.left
            bottom: parent.bottom
        }
        width: min_label.width
        height: min_label.height
        TextInput{
            id: max_text
            anchors.fill: parent
            text: "Max:"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            font.pointSize: 30
            clip: true
        }
    }
    MinMaxTemperatureControl{
        id: temperature_control
        anchors {
            left: max_label.right
            top: min_label.top
            bottom: max_label.bottom
            leftMargin: width/10
        }
        width: parent.width/4

    }
    Item{
        id: temperature_unit_min_label
        anchors{
            leftMargin: width/10
            left: temperature_control.right
            top: min_label.top
            bottom: min_label.bottom
        }
        width: parent.width/8

        TextInput{
            id: temperature_unit_min
            anchors.fill: parent
            text: "\xB0C"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pointSize: 30
            clip: true
        }
    }
    Item{
        id: temperature_unit_max_label
        anchors{
            left: temperature_unit_min_label.left
            top: max_label.top
            bottom: max_label.bottom
        }
        width: temperature_unit_min_label.width
        height: temperature_unit_min_label.height
        TextInput{
            id: temperature_unit_max
            anchors.fill: parent
            text: "\xB0C"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pointSize: 30
            clip: true
        }
    }
    Rectangle{
        id: adc_control_box
        height:temperature_control.height*1.2
        color: "#0b0b0b"
        radius: 5
        anchors{
            left: temperature_unit_min_label.right
            verticalCenter: temperature_control.verticalCenter
            leftMargin: width/12
        }
        width: parent.width/3
    }

    MinMaxAdcControl{
        id: adc_control
        anchors {
            horizontalCenter: adc_control_box.horizontalCenter
            top: min_label.top
            bottom: max_label.bottom
        }
        width: parent.width/4

    }

}





