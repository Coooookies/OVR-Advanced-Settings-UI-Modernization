import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "common"


MyStackViewPage {
    headerText: "空间偏移"

    MyDialogOkPopup {
        id: offsetMessageDialog
        function showMessage(title, text) {
            dialogTitle = title
            dialogText = text
            open()
        }
    }

    MyDialogOkCancelPopup {
        id: offsetDeleteProfileDialog
        property int profileIndex: -1
        dialogTitle: "删除配置"
        dialogText: "你确定要删除此配置吗？"
        onClosed: {
            if (okClicked) {
                MoveCenterTabController.deleteOffsetProfile(profileIndex)
            }
        }
    }

    MyDialogOkCancelPopup {
        id: offsetNewProfileDialog
        dialogTitle: "创建新配置"
        dialogWidth: 600
        dialogHeight: 240
        dialogContentItem: ColumnLayout {
            RowLayout {
                MyText {
                    text: "名称："
                }
                MyTextField {
                    id: offsetNewProfileName
                    keyBoardUID: 105
                    color: "#cccccc"
                    text: ""
                    Layout.fillWidth: true
                    font.pointSize: 20
                    function onInputEvent(input) {
                        offsetNewProfileName.text = input
                    }
                }
            }
        }
        onClosed: {
            if (okClicked) {
                if (offsetNewProfileName.text == "") {
                    offsetMessageDialog.showMessage("创建新配置", "错误：配置文件名称不能为空。")
                } else {
                    MoveCenterTabController.addOffsetProfile(offsetNewProfileName.text)
                }

            }
        }
        function openPopup() {
            offsetNewProfileName.text = ""
            open()
        }
    }

    content: ColumnLayout {
        spacing: 16

        SettingsCard {
            title: "常规"
            
            RowLayout {
                spacing: 16
                MyText {
                    text: "追踪空间："
                    Layout.fillWidth: true
                }
                MyText {
                    id: spaceModeText
                    font.family: Style.sansExtraBold
                    text: "站姿"
                }
            }
        }

        SettingsCard {
            title: "配置文件"
            id: profileSection
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 10

                RowLayout {
                    spacing: 10
                    MyText {
                        text: "配置："
                    }
                    MyComboBox {
                        id: offsetProfileComboBox
                        Layout.fillWidth: true
                        model: [""]
                        onCurrentIndexChanged: {
                            if (currentIndex > 0) {
                                offsetApplyProfileButton.enabled = true
                                offsetDeleteProfileButton.enabled = true
                            } else {
                                offsetApplyProfileButton.enabled = false
                                offsetDeleteProfileButton.enabled = false
                            }
                        }
                    }
                    MyPushButton {
                        id: offsetApplyProfileButton
                        enabled: false
                        Layout.preferredWidth: 150
                        text: "应用"
                        onClicked: {
                            if (offsetProfileComboBox.currentIndex > 0) {
                                MoveCenterTabController.applyOffsetProfile(offsetProfileComboBox.currentIndex - 1)
                                offsetProfileComboBox.currentIndex = 0
                            }
                        }
                    }
                }
                RowLayout {
                    spacing: 10
                    Item { Layout.fillWidth: true }
                    MyPushButton {
                        id: offsetDeleteProfileButton
                        enabled: false
                        Layout.preferredWidth: 200
                        text: "删除配置"
                        onClicked: {
                            if (offsetProfileComboBox.currentIndex > 0) {
                                offsetDeleteProfileDialog.profileIndex = offsetProfileComboBox.currentIndex - 1
                                offsetDeleteProfileDialog.open()
                            }
                        }
                    }
                    MyPushButton {
                        Layout.preferredWidth: 200
                        text: "新建配置"
                        onClicked: {
                            offsetNewProfileDialog.openPopup()
                        }
                    }
                }
            }
        }

        SettingsCard {
            title: "空间移动"
            id: offsetsGroupBox
            
            GridLayout {
                columns: 5
                rowSpacing: 16
                columnSpacing: 10

                // X-Axis
                MyText {
                    text: "X轴（左/右）："
                    Layout.preferredWidth: 220
                }
                MyPushButton2 {
                    id: spaceMoveXMinusButton
                    Layout.preferredWidth: 40
                    text: "-"
                    onClicked: { MoveCenterTabController.modOffsetX(-0.1) }
                }
                MyTextField {
                    id: spaceMoveXText
                    text: "0.00"
                    keyBoardUID: 101
                    Layout.preferredWidth: 100
                    horizontalAlignment: Text.AlignHCenter
                    function onInputEvent(input) {
                        var val = parseFloat(input)
                        if (!isNaN(val)) {
                            MoveCenterTabController.offsetX = val.toFixed(2)
                        }
                        text = MoveCenterTabController.offsetX.toFixed(2)
                    }
                }
                MyPushButton2 {
                    id: spaceMoveXPlusButton
                    Layout.preferredWidth: 40
                    text: "+"
                    onClicked: { MoveCenterTabController.modOffsetX(0.1) }
                }
                MyToggleButton {
                    id: lockXToggle
                    text: "锁定 X"
                    onCheckedChanged: { MoveCenterTabController.lockXToggle = checked }
                }

                // Y-Axis
                MyText {
                    text: "Y轴（下/上）："
                    Layout.preferredWidth: 220
                }
                MyPushButton2 {
                    Layout.preferredWidth: 40
                    text: "-"
                    onClicked: { MoveCenterTabController.modOffsetY(-0.1) }
                }
                MyTextField {
                    id: spaceMoveYText
                    text: "0.00"
                    keyBoardUID: 102
                    Layout.preferredWidth: 100
                    horizontalAlignment: Text.AlignHCenter
                    function onInputEvent(input) {
                        var val = parseFloat(input)
                        if (!isNaN(val)) {
                            MoveCenterTabController.offsetY = val.toFixed(2)
                        }
                        text = MoveCenterTabController.offsetY.toFixed(2)
                    }
                }
                MyPushButton2 {
                    Layout.preferredWidth: 40
                    text: "+"
                    onClicked: { MoveCenterTabController.modOffsetY(0.1) }
                }
                RowLayout {
                    spacing: 8
                    MyPushButton2 {
                        Layout.preferredWidth: 40
                        text: "0"
                        onClicked: { MoveCenterTabController.offsetY = 0 }
                    }
                    MyToggleButton {
                        id: lockYToggle
                        text: "锁定 Y"
                        onCheckedChanged: { MoveCenterTabController.lockYToggle = checked }
                    }
                }

                // Z-Axis
                MyText {
                    text: "Z轴（前/后）："
                    Layout.preferredWidth: 220
                }
                MyPushButton2 {
                    Layout.preferredWidth: 40
                    text: "-"
                    onClicked: { MoveCenterTabController.modOffsetZ(-0.1) }
                }
                MyTextField {
                    id: spaceMoveZText
                    text: "0.00"
                    keyBoardUID: 103
                    Layout.preferredWidth: 100
                    horizontalAlignment: Text.AlignHCenter
                    function onInputEvent(input) {
                        var val = parseFloat(input)
                        if (!isNaN(val)) {
                            MoveCenterTabController.offsetZ = val.toFixed(2)
                        }
                        text = MoveCenterTabController.offsetZ.toFixed(2)
                    }
                }
                MyPushButton2 {
                    Layout.preferredWidth: 40
                    text: "+"
                    onClicked: { MoveCenterTabController.modOffsetZ(0.1) }
                }
                MyToggleButton {
                    id: lockZToggle
                    text: "锁定 Z"
                    onCheckedChanged: { MoveCenterTabController.lockZToggle = checked }
                }
            }
        }

        SettingsCard {
            title: "空间旋转"
            id: rotationGroupBox
            
            RowLayout {
                spacing: 12
                MyPushButton2 {
                    id: spaceRotationMinusButton
                    Layout.preferredWidth: 40
                    text: "-"
                    onClicked: {
                        var val = ( MoveCenterTabController.tempRotation / 100 ) - 45
                        if (val < -180) {
                            val = val + 360;
                        }
                        MoveCenterTabController.tempRotation = val * 100
                    }
                }

                MySlider {
                    id: spaceRotationSlider
                    from: -180
                    to: 180
                    stepSize: 0.01
                    value: 0
                    Layout.fillWidth: true
                    onPositionChanged: {
                        var val = this.from + ( this.position  * (this.to - this.from))
                        MoveCenterTabController.tempRotation = Math.round(val * 100)
                    }
                    onValueChanged: {
                        MoveCenterTabController.tempRotation = Math.round(spaceRotationSlider.value * 100)
                    }
                }

                MyPushButton2 {
                    id: spaceRotationPlusButton
                    Layout.preferredWidth: 40
                    text: "+"
                    onClicked: {
                        var val = ( MoveCenterTabController.tempRotation / 100 ) + 45
                        if (val > 180) {
                            val = val -360;
                        }
                        MoveCenterTabController.tempRotation = val * 100
                    }
                }

                MyTextField {
                    id: spaceRotationText
                    text: "0°"
                    keyBoardUID: 104
                    Layout.preferredWidth: 100
                    horizontalAlignment: Text.AlignHCenter
                    function onInputEvent(input) {
                        var val = parseFloat(input)
                        if (!isNaN(val)) {
                            val = val % 180
                            MoveCenterTabController.tempRotation = Math.round(val * 100)
                        } 
                        text = ( MoveCenterTabController.tempRotation / 100 ) + "°"
                    }
                }
                MyPushButton {
                    id: spaceRotationApplyButton
                    Layout.preferredWidth: 100
                    text:"应用"
                    onClicked: {
                        MoveCenterTabController.rotation = MoveCenterTabController.tempRotation
                    }
                }
            }
        }


        ColumnLayout {
            RowLayout {
                Layout.fillWidth: true
                id: resetButtonRow
                visible: true

                MyPushButton {
                    id: spaceResetButton
                    Layout.preferredWidth: 250
                    text: "重置"
                    onClicked: {
                        MoveCenterTabController.reset()
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                MyPushButton {
                    id: spaceLogMatrices
                    Layout.preferredWidth: 250
                    visible: MoveCenterTabController.showLogMatricesButton
                    text: "日志矩阵"
                    onClicked: {
                        MoveCenterTabController.outputLogPoses()
                    }
                }

                MyPushButton {
                    id: spaceSeatedRecenter
                    Layout.preferredWidth: 250
                    visible: true
                    text: "重置中心"
                    onClicked: {
                        MoveCenterTabController.sendSeatedRecenter()
                    }
                }

            }
        }

        Component.onCompleted: {
            spaceMoveXText.text = MoveCenterTabController.offsetX.toFixed(2)
            spaceMoveYText.text = MoveCenterTabController.offsetY.toFixed(2)
            spaceMoveZText.text = MoveCenterTabController.offsetZ.toFixed(2)
            spaceRotationSlider.value = MoveCenterTabController.rotation
			lockXToggle.checked = MoveCenterTabController.lockXToggle
			lockYToggle.checked = MoveCenterTabController.lockYToggle
			lockZToggle.checked = MoveCenterTabController.lockZToggle
            spaceLogMatrices.visible = MoveCenterTabController.showLogMatricesButton
			
            if (MoveCenterTabController.trackingUniverse === 0) {
                spaceModeText.text = "坐姿"
                spaceSeatedRecenter.visible = true
            } else if (MoveCenterTabController.trackingUniverse === 1) {
                spaceModeText.text = "站姿"
            } else {
                spaceModeText.text = "未知 (" + MoveCenterTabController.trackingUniverse + ")"
            }
            reloadOffsetProfiles()
        }

        Connections {
            target: MoveCenterTabController
            onOffsetXChanged: {
                spaceMoveXText.text = MoveCenterTabController.offsetX.toFixed(2)
            }
            onOffsetYChanged: {
                spaceMoveYText.text = MoveCenterTabController.offsetY.toFixed(2)
            }
            onOffsetZChanged: {
                spaceMoveZText.text = MoveCenterTabController.offsetZ.toFixed(2)
            }
            onRotationChanged: {
                spaceRotationSlider.value = ( MoveCenterTabController.rotation / 100 )
            }
            onTempRotationChanged: {
                var intTempRotation = MoveCenterTabController.tempRotation
                spaceRotationSlider.value = ( intTempRotation / 100 )
                spaceRotationText.text = ( intTempRotation / 100 ) + "°"
            }
			onLockXToggleChanged: {
				lockXToggle.checked = MoveCenterTabController.lockXToggle
			}
			onLockYToggleChanged: {
				lockYToggle.checked = MoveCenterTabController.lockYToggle
			}
			onLockZToggleChanged: {
				lockZToggle.checked = MoveCenterTabController.lockZToggle
			}
            onTrackingUniverseChanged: {
                if (MoveCenterTabController.trackingUniverse === 0) {
                    spaceModeText.text = "坐姿"
                    spaceSeatedRecenter.visible = true
                } else if (MoveCenterTabController.trackingUniverse === 1) {
                    spaceModeText.text = "站姿"
                } else {
                    spaceModeText.text = "未知 (" + MoveCenterTabController.trackingUniverse + ")"
                }
            }
            onOffsetProfilesUpdated: {
                reloadOffsetProfiles()
            }
        }

    }
    function reloadOffsetProfiles() {
        var profiles = [""]
        var profileCount = MoveCenterTabController.getOffsetProfileCount()
        for (var i = 0; i < profileCount; i++) {
            profiles.push(MoveCenterTabController.getOffsetProfileName(i))
        }
        offsetProfileComboBox.currentIndex = 0
        offsetProfileComboBox.model = profiles
    }
}
