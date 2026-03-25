import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../../common"

SettingsCard {
    id: redirectedGroupBox
    Layout.fillWidth: true

    title: "Vestibular Motion (for continuous redirected walking)"
    

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 10

        RowLayout{
            MyToggleButton {
                id: redirectedModeToggle
                text: "Toggle On/Off"
                Layout.preferredWidth: 225
                onCheckedChanged: {
                    RotationTabController.setVestibularMotionEnabled(this.checked, true);

                }
            }
            Item{

                Layout.fillWidth: true
            }

            MyText{
                text: "Radius: "
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
                text:"Imperceptable"
                onClicked: {
                    RotationTabController.setVestibularMotionRadius(22.0)
                }
           }
            MyPushButton {
                id: lightButton
                Layout.preferredWidth: 125
                text:"Light"
                onClicked: {
                    RotationTabController.setVestibularMotionRadius(11.0)
                }
           }
            MyPushButton {
                id: strongButton
                Layout.preferredWidth: 125
                text:"Strong"
                onClicked: {
                    RotationTabController.setVestibularMotionRadius(5.0)
                }
           }
            MyPushButton {
                id: extremeButton
                Layout.preferredWidth: 125
                text:"Extreme"
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
