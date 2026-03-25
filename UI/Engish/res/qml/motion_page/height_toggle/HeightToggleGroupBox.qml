import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../../common"

SettingsCard {
    id: heightToggleGroupBox
    Layout.fillWidth: true

    title: "Height Toggle / Gravity Floor Offset"
    

    ColumnLayout {
        Layout.fillWidth: true

        

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            MyToggleButton {
                id: heightToggleButton
                text: "On"
                onCheckedChanged: {
                    MoveCenterTabController.heightToggle = this.checked
                }
            }

            Item {
                Layout.fillWidth: true
            }

            MyText {
                text: "Height Offset (+ is down):"
                horizontalAlignment: Text.AlignRight
            }

            MyTextField {
                id: heightToggleOffsetText
                text: "-1.00"
                keyBoardUID: 151
                Layout.preferredWidth: 140
                horizontalAlignment: Text.AlignHCenter
                function onInputEvent(input) {
                    var val = parseFloat(input)
                    if (!isNaN(val)) {
                        MoveCenterTabController.heightToggleOffset = val.toFixed(2)
                        text = MoveCenterTabController.heightToggleOffset.toFixed(2)
                    } else {
                        text = MoveCenterTabController.heightToggleOffset.toFixed(2)
                    }
                }
            }

            MyPushButton {
                id: heightOffsetFromYOffsetButton
                Layout.preferredWidth: 230
                text:"Set From Y-Offset"
                onClicked: {
                    MoveCenterTabController.heightToggleOffset = MoveCenterTabController.offsetY
                }
           }
        }
    }

    Component.onCompleted: {
        heightToggleButton.checked = MoveCenterTabController.heightToggle
        heightToggleOffsetText.text = MoveCenterTabController.heightToggleOffset.toFixed(2)
    }

    Connections {
        target: MoveCenterTabController

        onHeightToggleChanged: {
            heightToggleButton.checked = MoveCenterTabController.heightToggle
        }
        onHeightToggleOffsetChanged: {
            heightToggleOffsetText.text = MoveCenterTabController.heightToggleOffset.toFixed(2)
        }
    }
}
