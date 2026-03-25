import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../../common"

SettingsCard {
    id: gravityGroupBox
    Layout.fillWidth: true
    title: "重力设置"
    
    ColumnLayout {
        Layout.fillWidth: true
        spacing: 12
        

        RowLayout {
            Layout.fillWidth: true

            MyToggleButton {
                id: gravityToggleButton
                text: "开启"
                onCheckedChanged: {
                    MoveCenterTabController.gravityActive = this.checked
                }
            }

            Item {
                Layout.fillWidth: true
            }

            MyText {
                text: "重力强度（+ 为向下）："
                horizontalAlignment: Text.AlignRight
                Layout.rightMargin: 2
            }

            MyTextField {
                id: gravityStrengthText
                text: "9.80"
                keyBoardUID: 152
                Layout.preferredWidth: 120
                Layout.leftMargin: 10
                horizontalAlignment: Text.AlignHCenter
                function onInputEvent(input) {
                    var val = parseFloat(input)
                    if (!isNaN(val)) {
                        MoveCenterTabController.gravityStrength = val.toFixed(2)
                        text = MoveCenterTabController.gravityStrength.toFixed(2)
                    } else {
                        text = MoveCenterTabController.gravityStrengtht.toFixed(2)
                    }
                }
            }
        }
        RowLayout {
            spacing: 10
            Item {
                Layout.fillWidth: true
            }

            MyPushButton {
                id: gravityMoonButton
                Layout.preferredWidth: 110
                text:"月球"
                onClicked: {
                    MoveCenterTabController.gravityStrength = 1.62
                }
           }
            MyPushButton {
                id: gravityMarsButton
                Layout.preferredWidth: 110
                text:"火星"
                onClicked: {
                    MoveCenterTabController.gravityStrength = 3.71
                }
           }
            MyPushButton {
                id: gravityEarthButton
                Layout.preferredWidth: 110
                text:"地球"
                onClicked: {
                    MoveCenterTabController.gravityStrength = 9.80
                }
           }
            MyPushButton {
                id: gravityJupiterButton
                Layout.preferredWidth: 110
                text:"木星"
                onClicked: {
                    MoveCenterTabController.gravityStrength = 24.79
                }
           }
        }
        RowLayout {
            Layout.fillWidth: true

            MyToggleButton {
                id: momentumToggleButton
                text: "保留惯性"
                onCheckedChanged: {
                    MoveCenterTabController.momentumSave = this.checked
                }
            }

            Item {
                Layout.preferredWidth: 40
            }

            MyText {
                text: "摩擦力："
                horizontalAlignment: Text.AlignRight
                Layout.rightMargin: 2
            }

            MyTextField {
                id: frictionPercentText
                text: "0%"
                keyBoardUID: 156
                Layout.preferredWidth: 130
                Layout.leftMargin: 5
                horizontalAlignment: Text.AlignHCenter
                function onInputEvent(input) {
                    var val = parseInt(input)
                    if (!isNaN(val)) {
                        if ( val > 999 )
                        {
                            val = 999
                        }
                        if ( val < 0 )
                        {
                            val = 0
                        }

                        MoveCenterTabController.frictionPercent = val
                        text = MoveCenterTabController.frictionPercent + "%"
                    } else {
                        text = MoveCenterTabController.frictionPercent + "%"
                    }
                }
            }

            Item {
                Layout.fillWidth: true
            }

            MyText {
                text: "投掷强度："
                horizontalAlignment: Text.AlignRight
                Layout.rightMargin: 2
            }

            MyTextField {
                id: flingStrengthText
                text: "1.0"
                keyBoardUID: 153
                Layout.preferredWidth: 120
                Layout.leftMargin: 10
                horizontalAlignment: Text.AlignHCenter
                function onInputEvent(input) {
                    var val = parseFloat(input)
                    if (!isNaN(val)) {
                        MoveCenterTabController.flingStrength = val.toFixed(2)
                        text = MoveCenterTabController.flingStrength.toFixed(2)
                    } else {
                        text = MoveCenterTabController.flingStrength.toFixed(2)
                    }
                }
            }
        }
        RowLayout {
            spacing: 10

            Item {
                Layout.fillWidth: true
            }
            
            MyPushButton2 {
                Layout.preferredWidth: 50
                text: "1x"
                onClicked: {
                    MoveCenterTabController.flingStrength = 1.0
                }
            }

            MyPushButton2 {
                Layout.preferredWidth: 50
                text: "2x"
                onClicked: {
                    MoveCenterTabController.flingStrength = 2.0
                }
            }

            MyPushButton2 {
                Layout.preferredWidth: 50
                text: "3x"
                onClicked: {
                    MoveCenterTabController.flingStrength = 3.0
                }
            }
        }
    }

    Component.onCompleted: {
        gravityToggleButton.checked = MoveCenterTabController.gravityActive
        gravityStrengthText.text = MoveCenterTabController.gravityStrength.toFixed(2)
        momentumToggleButton.checked = MoveCenterTabController.momentumSave
        flingStrengthText.text = MoveCenterTabController.flingStrength.toFixed(2)
        frictionPercentText.text = MoveCenterTabController.frictionPercent + "%"
    }

    Connections {
        target: MoveCenterTabController

        onGravityActiveChanged: {
            gravityToggleButton.checked = MoveCenterTabController.gravityActive
        }
        onGravityStrengthChanged: {
            gravityStrengthText.text = MoveCenterTabController.gravityStrength.toFixed(2)
        }
        onMomentumSaveChanged: {
            momentumToggleButton.checked = MoveCenterTabController.momentumSave
        }
        onFlingStrengthChanged: {
            flingStrengthText.text = MoveCenterTabController.flingStrength.toFixed(2)
        }
        onFrictionPercentChanged: {
            frictionPercentText.text = MoveCenterTabController.frictionPercent + "%"
        }
    }
}
