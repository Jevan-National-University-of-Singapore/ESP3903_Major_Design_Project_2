import QtQuick 2.7
import QtQuick.Controls 2.15
import QtQuick.Window 2.2
import Serial 1.0



Serial{
    id: arduino
    port: "COM1"
//    property int minimumADC
//    property int maximumADC
//    property real rangeADC: maximumADC - minimumADC
    onPortChanged: {
        arduino.stop()
        console.log("port changed to: ",port)
        arduino.start()
    }

    Component.onCompleted: {
        arduino.start()
    }
}
