import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Popup {
    id: myDialogPopup

    parent: Overlay.overlay
    x: 0
    y: 0
    width: parent ? parent.width : 0
    height: parent ? parent.height : 0

    property string dialogTitle: ""
    property string dialogText: ""
    property int dialogWidth: 600
    property int dialogHeight: 300

    property Item dialogContentItem: MyText {
        text: dialogText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        Layout.fillWidth: true
    }

    property bool okClicked: false

    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

    background: Rectangle {
        color: "black"
        opacity: 0.8
     }

    contentItem: Item {
        Rectangle {
            implicitWidth: dialogWidth
            implicitHeight: dialogHeight
            anchors.centerIn: parent
            radius: 12
            color: "#141415"
            border.color: "#1D1D1E"
            border.width: 1
            
            ColumnLayout {
                anchors.fill: parent
                spacing: 0
                
                MyText {
                    Layout.topMargin: 24
                    Layout.leftMargin: 24
                    Layout.rightMargin: 24
                    text: dialogTitle
                    font.pixelSize: 22
                    font.family: Style.sansExtraBold
                    color: "#EEEEEE"
                }
                
                Rectangle {
                    color: "#1D1D1E"
                    height: 1
                    Layout.fillWidth: true
                    Layout.topMargin: 16
                }
                
                Item { Layout.fillHeight: true; Layout.fillWidth: true }
                
                ColumnLayout {
                    id: dialogContent
                    Layout.leftMargin: 24
                    Layout.rightMargin: 24
                    Layout.fillWidth: true
                }
                
                Item { Layout.fillHeight: true; Layout.fillWidth: true }
                
                RowLayout {
                    Layout.fillWidth: true
                    Layout.leftMargin: 24
                    Layout.rightMargin: 24
                    Layout.bottomMargin: 24
                    spacing: 16
                    
                    Item { Layout.fillWidth: true }
                    
                    MyPushButton {
                        Layout.preferredWidth: 200
                        type: "primary"
                        text: "Ok"
                        onClicked: {
                            okClicked = true
                            myDialogPopup.close()
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        dialogContentItem.parent = dialogContent
    }
}
