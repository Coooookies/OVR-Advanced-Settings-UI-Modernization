import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "." 
import ".."

Button {
    id: control
    
    property string iconPath: ""
    property bool isSelected: false
    
    enabled: !isSelected
    hoverEnabled: true
    
    implicitWidth: 248
    implicitHeight: 44
    
    // Background for states
    background: Rectangle {
        color: {
            if (control.isSelected) return "#202021"
            if (control.down) return "#1B1B1C"
            if (control.activeFocus || control.hovered) return "#202021"
            return "transparent"
        }
        radius: 8
    }
    
    contentItem: RowLayout {
        spacing: 10
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        
        Image {
            id: icon
            source: control.iconPath
            Layout.preferredWidth: 24
            Layout.preferredHeight: 24
            fillMode: Image.PreserveAspectFit
            smooth: true
            opacity: control.isSelected ? 1.0 : 0.5
        }
        
        MyText {
            text: control.text
            font.pixelSize: 16
            font.family: control.isSelected ? Style.sansExtraBold : Style.sansMedium
            color: {
                if (control.isSelected) return "#FFFFFF"
                return "#89898A"
            }
            Layout.fillWidth: true
            verticalAlignment: Text.AlignVCenter
        }
    }

    onHoveredChanged: {
        if (hovered && !isSelected) {
            forceActiveFocus()
        } else {
            focus = false
        }
    }

    onClicked: {
        MyResources.playActivationSound()
    }
}
