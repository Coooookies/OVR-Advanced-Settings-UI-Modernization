import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../../common"

SettingsCard {
    id: redirectedGroupBox
    Layout.fillWidth: true

    title: "前庭运动（用于连续重定向行走转向）"
    

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 10

        RowLayout{
            MyToggleButton {
                id: redirectedModeToggle
                text: "开启/关闭"
                Layout.preferredWidth: 225
                onCheckedChanged: {
                    RotationTabController.setVestibularMotionEnabled(this.checked, true);

                }
            }
            Item{

                Layout.fillWidth: true
            }

            MyText{
                text: "半径： "
                horizontalAlignment: Text.AlignRight
                Layout.rightMargin: 4
            }


            MyTextField {
                id: redirectedWalkingRadiusText
                text: "11.0"
                keyBoardUID: 1004
                Layout.preferredWidth: 100
                Layout.leftMargin: 10
                horizontalAlignment: Text.AlignHCenter
                function onInputEvent(input) {
                    var val = parseFloat(input)
                    if (!isNaN(val)) {
                        if (val < 0.5) {
                            val = 0.5
                        } else if (val > 50) {
                            val = 50
                        }
                            RotationTabController.setVestibularMotionRadius(val, true);
                    }
                }
            }
        }
        RowLayout{
            spacing: 10
            MyPushButton {
                id: imperceptableButton
                Layout.preferredWidth: 180
                text:"无感"
                onClicked: {
                    RotationTabController.setVestibularMotionRadius(22.0)
                }
           }
            MyPushButton {
                id: lightButton
                Layout.preferredWidth: 125
                text:"轻微"
                onClicked: {
                    RotationTabController.setVestibularMotionRadius(11.0)
                }
           }
            MyPushButton {
                id: strongButton
                Layout.preferredWidth: 125
                text:"强烈"
                onClicked: {
                    RotationTabController.setVestibularMotionRadius(5.0)
                }
           }
            MyPushButton {
                id: extremeButton
                Layout.preferredWidth: 125
                text:"极强"
                onClicked: {
                    RotationTabController.setVestibularMotionRadius(1.0)
                }
           }
        }
    }


    Component.onCompleted: {
        redirectedWalkingRadiusText.text = ((RotationTabController.vestibularMotionRadius).toFixed(2))
        redirectedModeToggle.checked = RotationTabController.vestibularMotionEnabled
    }

    Connections {
        target: RotationTabController

        onVestibularMotionEnabledChanged:{
         redirectedModeToggle.checked = RotationTabController.vestibularMotionEnabled
        }
        onVestibularMotionRadiusChanged:{
            redirectedWalkingRadiusText.text =  ((RotationTabController.vestibularMotionRadius).toFixed(2))
        }
    }

}
