import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../../common"

SettingsCard {
    id: snapTurnGroupBox
    Layout.fillWidth: true
    title: "分段转向"

    ColumnLayout {
        Layout.fillWidth: true

        RowLayout {
            Layout.fillWidth: true
            spacing: 10
            
            MyText {
                text: "分段转向角度："
                horizontalAlignment: Text.AlignRight
            }

            MyTextField {
                id: snapTurnAngleText
                text: "45°"
                keyBoardUID: 154
                Layout.preferredWidth: 100
                horizontalAlignment: Text.AlignHCenter
                function onInputEvent(input) {
                    var val = parseFloat(input)
                    if (!isNaN(val)) {
                        val = val % 180
                        MoveCenterTabController.snapTurnAngle = val.toFixed(2) * 100
                        text = ( Math.round( MoveCenterTabController.snapTurnAngle / 100 ) ) + "°"
                    } else {
                        text = ( Math.round( MoveCenterTabController.snapTurnAngle / 100 ) ) + "°"
                    }
                }
            }

            MyPushButton {
                id: snapTurnButton45
                Layout.preferredWidth: 90
                text:"45°"
                onClicked: {
                    MoveCenterTabController.snapTurnAngle = 4500
                }
           }
            MyPushButton {
                id: snapTurnButton90
                Layout.preferredWidth: 90
                text:"90°"
                onClicked: {
                    MoveCenterTabController.snapTurnAngle = 9000
                }
           }
            MyPushButton {
                id: snapTurnButton180
                Layout.preferredWidth: 90
                text:"180°"
                onClicked: {
                    MoveCenterTabController.snapTurnAngle = 18000
                }
           }

           Item {
               Layout.fillWidth: true
           }

           MyText {
               text: "平滑转向速率："
               horizontalAlignment: Text.AlignRight
           }

           MyTextField {
               id: smoothTurnRateText
               text: "100%"
               keyBoardUID: 155
               Layout.preferredWidth: 130
               horizontalAlignment: Text.AlignHCenter
               function onInputEvent(input) {
                   var val = parseInt(input)
                   if (!isNaN(val)) {
                       MoveCenterTabController.smoothTurnRate = val
                       text = MoveCenterTabController.smoothTurnRate + "%"
                   } else {
                       text = MoveCenterTabController.smoothTurnRate + "%"
                   }
               }
           }

        }
    }

    Component.onCompleted: {
        snapTurnAngleText.text = ( Math.round( MoveCenterTabController.snapTurnAngle / 100 ) ) + "°"
        smoothTurnRateText.text = MoveCenterTabController.smoothTurnRate + "%"
    }

    Connections {
        target: MoveCenterTabController

        onSnapTurnAngleChanged: {
            snapTurnAngleText.text = ( Math.round( MoveCenterTabController.snapTurnAngle / 100 ) ) + "°"
        }
        onSmoothTurnRateChanged: {
            smoothTurnRateText.text = MoveCenterTabController.smoothTurnRate + "%"
        }
    }
}
