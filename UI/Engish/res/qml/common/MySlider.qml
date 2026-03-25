import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "." 

Slider {
    id: control
    padding: 8
    snapMode: Slider.SnapAlways
    wheelEnabled: true
    hoverEnabled: true

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 40 // Providing a base height for the container
        color: control.activeFocus ? "#181819" : "transparent"
        radius: 8
        
        Rectangle {
            id: groove
            width: parent.width - (control.leftPadding + control.rightPadding)
            height: 4 
            x: control.leftPadding
            y: parent.height / 2 - height / 2
            color: "#2A2A2B"
            radius: 2
            
            // Progress part (Left of handle)
            Rectangle {
                width: control.visualPosition * parent.width
                height: parent.height
                color: "#254595"
                radius: parent.radius
            }
        }
    }

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 8
        implicitHeight: 28
        radius: 4
        color: control.pressed ? "#0A34A1" : "#2160FF"
        
        // Ensure smoothness
        smooth: true
    }

    onHoveredChanged: {
        if (hovered && enabled) {
            forceActiveFocus()
        } else {
            focus = false
        }
    }

    // Sound logic if needed
    onValueChanged: {
        // Keeping as is
    }
}
