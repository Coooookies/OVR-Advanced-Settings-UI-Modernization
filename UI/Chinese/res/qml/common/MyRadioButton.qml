import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "." 
import ".."

RadioButton {
    id: control
    hoverEnabled: true
    spacing: 8
    
    indicator: Rectangle {
        implicitWidth: 24
        implicitHeight: 24
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: 12
        border.width: control.checked ? 0 : 1
        border.color: control.enabled ? "#343435" : "#222223"
        color: control.checked ? "#2160FF" : "transparent"
        
        Rectangle {
            width: 10
            height: 10
            anchors.centerIn: parent
            radius: 5
            color: "#FFFFFF"
            visible: control.checked
        }
    }

    contentItem: MyText {
        text: control.text
        font.family: Style.sansSemiBold
        font.pixelSize: 16
        color: control.enabled ? "#FFFFFF" : "#5F5F60"
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }

    onHoveredChanged: {
        if (hovered && enabled) {
            forceActiveFocus()
        }
    }

    onClicked: {
        MyResources.playActivationSound()
    }
}
