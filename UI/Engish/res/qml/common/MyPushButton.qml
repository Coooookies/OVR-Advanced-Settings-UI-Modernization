import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "." 
import ".."

Button {
    id: control
    
    property string type: "default"
    property string iconPath: ""
    property bool activationSoundEnabled: true
    
    implicitHeight: 42
    leftPadding: 16
    rightPadding: 16
    
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
            spacing: 10
            
            Image {
                source: control.iconPath
                visible: control.iconPath !== ""
                Layout.preferredWidth: 20
                Layout.preferredHeight: 20
                fillMode: Image.PreserveAspectFit
                smooth: true
            }

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
        if (activationSoundEnabled) {
            MyResources.playActivationSound()
        }
    }
}
