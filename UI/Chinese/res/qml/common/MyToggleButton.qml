import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "." 
import ".."

CheckBox {
    id: control
    spacing: 8
    hoverEnabled: true
    
    indicator: Rectangle {
        implicitWidth: 24
        implicitHeight: 24
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: 6
        
        border.width: control.checked ? 0 : 1
        border.color: {
            if (!control.enabled) return "#222223"
            return "#343435"
        }
        
        color: {
            if (!control.enabled) {
                return control.checked ? "#222223" : "transparent"
            }
            if (control.checked) {
                return control.down ? "#0A34A1" : "#2160FF"
            }
            return control.down ? "#0A0A0B" : "transparent"
        }

        Image {
            id: checkmark
            width: 20
            height: 20
            anchors.centerIn: parent
            source: "../../img/common/check"
            fillMode: Image.PreserveAspectFit
            visible: control.checked
            opacity: control.enabled ? 1.0 : 0.5
            smooth: true
        }
    }

    contentItem: MyText {
        text: control.text
        font.family: Style.sansSemiBold
        font.pixelSize: 16
        
        // Color follows the global MyText usually, but for checkbox we can specify
        color: control.enabled ? "#FFFFFF" : "#5F5F60"
        
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }

	background: Rectangle {
        color: "transparent"
    }

    onHoveredChanged: {
        if (hovered && enabled) {
            forceActiveFocus()
        } else {
            focus = false
        }
    }

    onClicked: {
        MyResources.playActivationSound()
    }
}
