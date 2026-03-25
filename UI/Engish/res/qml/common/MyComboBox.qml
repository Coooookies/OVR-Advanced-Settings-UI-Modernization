import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "." 
import ".."

ComboBox {
    id: control
    hoverEnabled: true
    implicitHeight: 42
    leftPadding: 16
    rightPadding: 12
    
    background: Rectangle {
        implicitWidth: 200
        color: "#111112"
        // color: control.activeFocus ? "#2B2B2C" : "#202021"
        radius: 8
        border.color: control.activeFocus ? "#2160FF" : "#343435"
        border.width: 1
    }

    contentItem: Item {
        MyText {
            anchors.fill: parent
            anchors.rightMargin: control.indicator.width + 4
            text: control.displayText
            font.family: Style.sansSemiBold
            font.pixelSize: 16
            color: "#FFFFFF"
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
    }

    delegate: ItemDelegate {
        id: delegateItem
        width: control.width - 8
        height: 38
        
        anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined
        
        hoverEnabled: true
        
        contentItem: MyText {
            text: {
                if (typeof modelData === "string") return modelData
                if (control.textRole && modelData[control.textRole]) return modelData[control.textRole]
                return modelData.text || ""
            }
            font.family: delegateItem.highlighted ? Style.sansExtraBold : Style.sansSemiBold
            font.pixelSize: 16
            color: delegateItem.highlighted ? "#FFFFFF" : "#A1A1A1"
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            leftPadding: 10
            rightPadding: 12
        }
        
        background: Rectangle {
            anchors.fill: parent
            color: delegateItem.highlighted || delegateItem.hovered ? "#2B2B2C" : "transparent"
            radius: 6
        }
        
        highlighted: control.highlightedIndex === index
    }

    indicator: Canvas {
        x: control.width - width - control.rightPadding
        y: (control.height - height) / 2
        width: 12
        height: 7
        contextType: "2d"

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.lineWidth = 1.5;
            ctx.strokeStyle = control.enabled ? "#FFFFFF" : "#5F5F60";
            ctx.moveTo(1, 1);
            ctx.lineTo(width / 2, height - 1);
            ctx.lineTo(width - 1, 1);
            ctx.stroke();
        }
    }

    popup: Popup {
        y: control.height + 4
        width: control.width
        implicitHeight: Math.min(contentItem.implicitHeight + 8, 300)
        padding: 4 // This provides equal 4px margin on top, bottom, left, right

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex
            ScrollIndicator.vertical: ScrollIndicator { }
            
            // Remove extra top/bottom margins to keep the Popup.padding uniform
            spacing: 2
        }

        background: Rectangle {
            color: "#181819"
            radius: 10
            border.color: "#343435"
            border.width: 1
        }
    }

    onHoveredChanged: {
        if (hovered && enabled) {
            forceActiveFocus()
        }
    }

    onActivated: {
        MyResources.playActivationSound()
    }
}
