import QtQuick 2.7
import QtQuick.Controls 2.15
import QtQuick.Window 2.2
import QtGraphicalEffects 1.5



ApplicationWindow {
    id: root
    visible: true
    width: Screen.width
    height: Screen.height
    color: "black"
    property bool selected: indoor_areas.selected || outdoor_areas.selected

    Arduino{
        id: arduino_1
        port: port_selection_group_1.portName
        onReadyToRead: {
            var check_valid = arduino_1.readFloat()
            if (check_valid >= 20 && check_valid < 10000){
                console.log("sensor1: ", check_valid)
                indoor_areas.adcValue1 = check_valid
            }

        }
    }
    Arduino{
        id: arduino_2
        port: port_selection_group_2.portName
        onReadyToRead: {
            var check_valid = arduino_2.readFloat()
            console.log(check_valid)
            if (check_valid >= 20 && check_valid < 10000){
                console.log("sensor2: ", check_valid)
                indoor_areas.adcValue2 = check_valid
            }

        }
    }

    Arduino{
        id: arduino_3
        port: port_selection_group_3.portName
        onReadyToRead: {
            var check_valid = arduino_3.readFloat()
            if (check_valid >= 20 && check_valid < 10000){
                console.log("sensor3: ", check_valid)
                outdoor_areas.adcValue1 = check_valid
            }

        }
    }

    Arduino{
        id: arduino_4
        port: port_selection_group_4.portName
        onReadyToRead: {
            var check_valid = arduino_4.readFloat()
            if (check_valid >= 20 && check_valid < 10000){
                console.log("sensor4: ", check_valid)
                outdoor_areas.adcValue2 = check_valid
            }

        }
    }


    PortSelector{
        id: port_selection_group_1
        z: root_mouse.z + 1
        height: parent.height/16
        width: parent.width/3
        anchors{
            top: parent.top
            left: parent.left
            topMargin: height/2
        }
    }
    PortSelector{
        id: port_selection_group_2
        z: root_mouse.z + 1
        height: parent.height/16
        width: parent.width/3
        anchors{
            bottom: parent.bottom
            left: parent.left
            bottomMargin: height
        }
    }
    IndoorControl {
        id: indoors_control_1
        z:indoor_1_blur.z + 1
        areaName: "Indoor Area 1"
        visible: indoor_areas.selected == 1
        opacity: darken.opacity
        anchors.fill: parent
        onUnselected: indoor_areas.selected = 0
    }
    IndoorControl {
        id: indoors_control_2
        z: indoors_control_1.z
        areaName: "Indoor Area 2"
        visible: indoor_areas.selected == 2
        opacity: darken.opacity
        anchors.fill: parent
        onUnselected: indoor_areas.selected = 0
    }
    OutdoorControl {
        id: outdoor_control_1
        z: indoor_1_blur.z + 1
        areaName: "Outdoor Area 1"
        visible: outdoor_areas.selected == 1
        opacity: darken.opacity
        anchors.fill: parent
        onUnselected: outdoor_areas.selected = 0
    }
    OutdoorControl {
        id: outdoor_control_2
        z: indoors_control_1.z
        areaName: "Outdoor Area 2"
        visible: outdoor_areas.selected == 2
        opacity: darken.opacity
        width: parent.width/3
        height: parent.height
        anchors.fill: parent
        onUnselected: outdoor_areas.selected = 0
    }

    Rectangle{
        id: darken
        z: indoor_areas.z+1
        anchors.fill: parent
        opacity: 0
        color: "black"
    }

    FastBlur {
        id: indoor_1_blur
        z: darken.z + 1
        anchors.fill: indoor_areas
        transparentBorder: true
        source: indoor_areas
        radius: 30
        opacity: darken.opacity/2
    }

    FastBlur {
        id: port_1_blur
        z: darken.z + 1
        anchors.fill: port_selection_group_1
        transparentBorder: true
        source: port_selection_group_1
        radius: indoor_1_blur.radius
        opacity: indoor_1_blur.opacity
    }
    FastBlur {
        id: port_2_blur
        z: darken.z + 1
        anchors.fill: port_selection_group_2
        transparentBorder: true
        source: port_selection_group_2
        radius: indoor_1_blur.radius
        opacity: indoor_1_blur.opacity
    }
    FastBlur {
        id: port_3_blur
        z: darken.z + 1
        anchors.fill: port_selection_group_3
        transparentBorder: true
        source: port_selection_group_3
        radius: indoor_1_blur.radius
        opacity: indoor_1_blur.opacity
    }
    FastBlur {
        id: port_4_blur
        z: darken.z + 1
        anchors.fill: port_selection_group_4
        transparentBorder: true
        source: port_selection_group_4
        radius: indoor_1_blur.radius
        opacity: indoor_1_blur.opacity
    }
    FastBlur {
        id: outdoor_blur
        z: darken.z + 1
        anchors.fill: outdoor_areas
        transparentBorder: true
        source: outdoor_areas
        radius: indoor_1_blur.radius
        opacity: indoor_1_blur.opacity
    }
    FastBlur {
        id: central_unit_blur
        z: darken.z + 1
        anchors.fill: central_unit
        transparentBorder: true
        source: central_unit
        radius: indoor_1_blur.radius
        opacity: indoor_1_blur.opacity
    }
    FastBlur {
        id: connection_lines_blur
        z: darken.z + 1
        anchors.fill: connection_lines
        transparentBorder: true
        source: connection_lines
        radius: indoor_1_blur.radius
        opacity: indoor_1_blur.opacity
    }



    NumberAnimation {
        id: blur
        target: darken
        properties: "opacity"
        to: 1
        duration: 100
    }
    NumberAnimation {
        id: recover_blur
        target: darken
        properties: "opacity"
        to: 0
        duration: 100
    }
    onSelectedChanged: {
        if (selected){
            blur.start()
        } else{
            recover_blur.start()
        }
    }


    IndoorRegion{
        id: indoor_areas
        width: parent.width/3
        height: parent.height/1.3
        anchors{
            top:port_selection_group_1.bottom
            topMargin: port_selection_group_1.height/10
        }

        minTemperature1: parseFloat(indoors_control_1.minTemperature)
        maxTemperature1: parseFloat(indoors_control_1.maxTemperature)
        minADC1: parseFloat(indoors_control_1.minADC)
        maxADC1: parseFloat(indoors_control_1.maxADC)

        minTemperature2: parseFloat(indoors_control_2.minTemperature)
        maxTemperature2: parseFloat(indoors_control_2.maxTemperature)
        minADC2: parseFloat(indoors_control_2.minADC)
        maxADC2: parseFloat(indoors_control_2.maxADC)

    }

    PortSelector{
        id: port_selection_group_3
        z: root_mouse.z + 1
        height: parent.height/16
        width: parent.width/3
        anchors{
            top: parent.top
            right: parent.right
            topMargin: height/2
        }
    }
    PortSelector{
        id: port_selection_group_4
        z: root_mouse.z + 1
        height: parent.height/16
        width: parent.width/3
        anchors{
            bottom: parent.bottom
            right: parent.right
            bottomMargin: height
        }
    }

    OutdoorRegion{
        id: outdoor_areas
        width: parent.width/3
        height: parent.height/1.3
        anchors{
            top:port_selection_group_3.bottom
            topMargin: port_selection_group_1.height/10
            right: parent.right
        }

        minTemperature1: parseFloat(outdoor_control_1.minTemperature)
        maxTemperature1: parseFloat(outdoor_control_1.maxTemperature)
        minADC1: parseFloat(outdoor_control_1.minADC)
        maxADC1: parseFloat(outdoor_control_1.maxADC)

        minTemperature2: parseFloat(outdoor_control_2.minTemperature)
        maxTemperature2: parseFloat(outdoor_control_2.maxTemperature)
        minADC2: parseFloat(outdoor_control_2.minADC)
        maxADC2: parseFloat(outdoor_control_2.maxADC)

    }

    Timer {
        id: timer
        running: true
        repeat: true
        interval: 20000
        onTriggered: {
            console.log("update")
            arduino_1.write("<"+String(indoor_areas.temperaturePercentage1)+">")
            arduino_2.write("<"+String(indoor_areas.temperaturePercentage2)+">")
            arduino_3.write("<"+String(outdoor_areas.temperaturePercentage1)+">")
            arduino_4.write("<"+String(outdoor_areas.temperaturePercentage2)+">")

//            arduino_1.write("<0.5,0.8,0.41,0.17>")
        }
    }

    Rectangle {
        id: central_unit
        height: parent.height/4
        width: parent.height * 1.5
        color: "transparent"
        anchors.centerIn: parent
        Image {
            id: central_unit_icon
            anchors.fill: parent
            source: "qrc:/Images/Laptop.png"
            fillMode: Image.PreserveAspectFit
            autoTransform: true
        }
    }
    Item{
        id: connection_lines
        anchors{
            top: indoor_areas.top
            bottom: indoor_areas.bottom
            left: indoor_areas.left
            right: outdoor_areas.right
        }
        Rectangle{
            id: top_left_horizontal
            height: parent.height/50
            width:parent.width/5
            radius: 20
            anchors{
                left: parent.left
                leftMargin: parent.width/4
                top: parent.top
                topMargin: parent.height/4
            }
        }
        Rectangle{
            id: top_left_vertical
            height: parent.height/8
            width: top_left_horizontal.height
            radius: 20
            anchors{
                right: top_left_horizontal.right
                top: top_left_horizontal.top
            }
        }
        Rectangle{
            id: top_right_horizontal
            height: top_left_horizontal.height
            width:top_left_horizontal.width
            radius: 20
            anchors{
                right: parent.right
                rightMargin: parent.width/4
                top: parent.top
                topMargin: parent.height/4
            }
        }
        Rectangle{
            id: top_right_vertical
            height: top_left_vertical.height
            width: top_left_vertical.width
            radius: 20
            anchors{
                left: top_right_horizontal.left
                top: top_right_horizontal.top
            }
        }
        Rectangle{
            id: bottom_left_horizontal
            height: top_left_horizontal.height
            width:top_left_horizontal.width
            radius: 20
            anchors{
                right: top_left_horizontal.right
//                rightMargin: parent.width/4
                bottom: parent.bottom
                bottomMargin: parent.height/4
            }
        }
        Rectangle{
            id: bottom_left_vertical
            height: top_left_vertical.height
            width: top_left_vertical.width
            radius: 20
            anchors{
                right: bottom_left_horizontal.right
                bottom: bottom_left_horizontal.bottom
            }
        }
        Rectangle{
            id: bottom_right_horizontal
            height: top_left_horizontal.height
            width:top_left_horizontal.width
            radius: 20
            anchors{
                right: top_right_horizontal.right
                bottom: parent.bottom
                bottomMargin: parent.height/4
            }
        }
        Rectangle{
            id: bottom_right_vertical
            height: top_left_vertical.height
            width: top_left_vertical.width
            radius: 20
            anchors{
                left: bottom_right_horizontal.left
                bottom: bottom_right_horizontal.bottom
            }
        }

    }



    MouseArea{
        id: root_mouse
        anchors.fill: parent

    }



}
