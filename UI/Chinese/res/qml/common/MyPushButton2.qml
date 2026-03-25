import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "." 
import ".."

Button {
    id: control
    
    // type: "default" or "primary"
    property string type: "default"
    
    // For manual sizing
    implicitHeight: 42
    leftPadding: 8
    rightPadding: 8
    
    hoverEnabled: true

    background: Rectangle {
        radius: 8
        color: {
            if (control.type === "primary") {
                if (!control.enabled) return "#1B1B1C"
                if (control.down) return "#0A34A1"
                if (control.activeFocus || control.hovered) return "#3C73FF"
                return "#2160FF"
            } else {
                // default
                if (!control.enabled) return "#1B1B1C"
                if (control.down) return "#1B1B1C"
                if (control.activeFocus || control.hovered) return "#2B2B2C"
                return "#202021"
            }
        }
    }

    contentItem: Item {
        RowLayout {
            anchors.centerIn: parent
            spacing: 8
            
            MyText {
                text: control.text
                font.family: Style.sansSemiBold
                font.pixelSize: 16
                color: control.enabled ? "#FFFFFF" : "#5F5F60"
                verticalAlignment: Text.AlignVCenter
            }
        }
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
