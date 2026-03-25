import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "." 
import ".."

TextField {
    id: control
    property int keyBoardUID: 0
    property string savedText: ""
    
    color: "#FFFFFF"
    font.family: Style.sansSemiBold
    font.pixelSize: 16
    
    leftPadding: 12
    rightPadding: 12
    topPadding: 10
    bottomPadding: 10
    
    verticalAlignment: TextInput.AlignVCenter
    
    background: Rectangle {
        implicitHeight: 42
        color: "#111112"
        radius: 8
        border.color: control.activeFocus ? "#2160FF" : "#343435"
        border.width: 1
        
        MouseArea {
            anchors.fill: parent
            onClicked: control.forceActiveFocus()
        }
    }

    onActiveFocusChanged: {
        if (activeFocus) {
            if (!OverlayController.desktopMode) {
                OverlayController.showKeyboard(text, keyBoardUID)
            } else {
                savedText = text
            }
        }
    }
    
    onEditingFinished: {
        if (OverlayController.desktopMode && savedText !== text) {
            control.onInputEvent(text)
        }
    }
    
    function onInputEvent(input) {
        text = input
    }
    
    Connections {
        target: OverlayController
        onKeyBoardInputSignal: {
            if (userValue == keyBoardUID) {
                if (control.text !== input) {
                    control.onInputEvent(input)
                }
            }
        }
    }
}
