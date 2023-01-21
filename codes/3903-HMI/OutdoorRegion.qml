import QtQuick 2.7
import QtQuick.Controls 2.15
import QtQuick.Window 2.2




Item{
    id: outdoor_areas
    z: 2

    property real minTemperature1: 25
    property real maxTemperature1: 30
    property real minADC1: 600
    property real maxADC1: 700
    property real adcValue1: 600
    property real temperaturePercentage1: outdoor_location_1.temperaturePercentage

    property real minTemperature2: 25
    property real maxTemperature2: 30
    property real minADC2: 600
    property real maxADC2: 700
    property real adcValue2: 600
    property real temperaturePercentage2: outdoor_location_2.temperaturePercentage

    property int selected: 0
    OutdoorArea {
            id: outdoor_location_1
            minTemperature: minTemperature1
            maxTemperature: maxTemperature1
            minADC: minADC1
            maxADC: maxADC1
            adcValue: adcValue1
            width: outdoor_areas.width/1.1
            height: outdoor_areas.height/2.3
            anchors {
                horizontalCenter: outdoor_areas.horizontalCenter
                top: outdoor_areas.top
                topMargin: height/10
            }
            onSelectedChanged: {
                if (selected){
                    outdoor_location_2.selected = false
                    outdoor_areas.selected = 1
                } else if (!outdoor_location_2.selected){
                    outdoor_areas.selected = 0
                }
            }
        }
    OutdoorArea {
        id: outdoor_location_2
        width: outdoor_location_1.width
        height: outdoor_location_1.height
        minTemperature: minTemperature2
        maxTemperature: maxTemperature2
        minADC: minADC2
        maxADC: maxADC2
        adcValue: adcValue2
        anchors {
            horizontalCenter: outdoor_areas.horizontalCenter
            bottom: parent.bottom
            bottomMargin: height/10
        }
        onSelectedChanged: {
            if (selected){
                outdoor_location_1.selected = false
                outdoor_areas.selected = 2
            } else if (!outdoor_location_1.selected){
                outdoor_areas.selected = 0
            }
        }

    }

    onSelectedChanged: {
        if (selected === 0){
            outdoor_location_1.selected = false
            outdoor_location_2.selected = false
        }
    }
}

