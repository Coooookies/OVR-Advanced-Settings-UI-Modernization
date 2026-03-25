import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import ovras.advsettings 1.0
import "." // QTBUG-34418, singletons require explicit import to load qmldir file
import "../common"
import "change_orientation"

MyStackViewPage {
    headerText: "安全区域设置"

    MyDialogOkPopup {
        id: chaperoneMessageDialog
        function showMessage(title, text) {
            dialogTitle = title
            dialogText = text
            open()
        }
    }

    MyDialogOkCancelPopup {
        id: chaperoneDeleteProfileDialog
        property int profileIndex: -1
        dialogTitle: "删除配置"
        dialogText: "你确定要删除此配置吗？"
        onClosed: {
            if (okClicked) {
                ChaperoneTabController.deleteChaperoneProfile(profileIndex)
            }
        }
    }

    MyDialogOkCancelPopup {
        id: chaperoneNewProfileDialog
        dialogTitle: "创建新配置"
        dialogWidth: 800
        dialogHeight: 700
        dialogContentItem: ColumnLayout {
            RowLayout {
                MyText {
                    text: "名称："
                }
                MyTextField {
                    id: chaperoneNewProfileName
                    keyBoardUID: 390
                    color: "#d9dbe0"
                    text: ""
                    Layout.fillWidth: true
                    font.pointSize: 20
                    function onInputEvent(input) {
                        chaperoneNewProfileName.text = input
                    }
                }
            }
            MyText {
                Layout.topMargin: 20
                text: "包含内容："
            }
            MyToggleButton {
                id: chaperoneNewProfileIncludeGeometry
                Layout.leftMargin: 8
                text: "安全区域几何形状"
            }
            MyToggleButton {
                id: chaperoneNewProfileIncludeStyle
                Layout.leftMargin: 8
                text: "安全区域样式"
            }
            MyToggleButton {
                id: chaperoneNewProfileIncludeBoundsColor
                Layout.leftMargin: 8
                text: "安全区域颜色"
            }
            MyToggleButton {
                id: chaperoneNewProfileIncludeVisibility
                Layout.leftMargin: 8
                text: "可见性设置"
            }
            MyToggleButton {
                id: chaperoneNewProfileIncludeFadeDistance
                Layout.leftMargin: 8
                text: "淡出距离设置"
            }
            MyToggleButton {
                id: chaperoneNewProfileIncludeCenterMarker
                Layout.leftMargin: 8
                text: "中心标记设置"
            }
            MyToggleButton {
                id: chaperoneNewProfileIncludePlaySpaceMarker
                Layout.leftMargin: 8
                text: "游玩空间标记设置"
            }
            MyToggleButton {
                id: chaperoneNewProfileIncludeFloorBoundsMarker
                Layout.leftMargin: 8
                text: "地面边界常驻设置"
            }
            MyToggleButton {
                id: chaperoneNewProfileIncludeForceBounds
                Layout.leftMargin: 8
                text: "强制显示边界设置"
            }
            MyToggleButton {
                id: chaperoneNewProfileIncludeProximityWarnings
                Layout.leftMargin: 8
                text: "近距离警告设置"
            }
        }
        onClosed: {
            if (okClicked) {
                if (chaperoneNewProfileName.text == "") {
                    chaperoneMessageDialog.showMessage("创建新配置", "错误：配置文件名称不能为空。")
                } else if (!chaperoneNewProfileIncludeGeometry.checked
                            && !chaperoneNewProfileIncludeVisibility.checked
                            && !chaperoneNewProfileIncludeFadeDistance.checked
                            && !chaperoneNewProfileIncludeCenterMarker.checked
                            && !chaperoneNewProfileIncludePlaySpaceMarker.checked
                            && !chaperoneNewProfileIncludeFloorBoundsMarker.checked
                            && !chaperoneNewProfileIncludeBoundsColor.checked
                            && !chaperoneNewProfileIncludeStyle.checked
                            && !chaperoneNewProfileIncludeForceBounds.checked
                            && !chaperoneNewProfileIncludeProximityWarnings.checked) {
                    chaperoneMessageDialog.showMessage("创建新配置", "错误：未选择任何内容。")
                } else if ( Math.abs(MoveCenterTabController.offsetX) > 0.00000000001
                           || Math.abs(MoveCenterTabController.offsetY) > 0.00000000001
                           || Math.abs(MoveCenterTabController.offsetZ) > 0.00000000001
                           || MoveCenterTabController.rotation !== 0) {
                    chaperoneMessageDialog.showMessage("创建新配置", "错误：偏移未重置。")
                } else {
                    ChaperoneTabController.addChaperoneProfile(chaperoneNewProfileName.text,
                                                               chaperoneNewProfileIncludeGeometry.checked,
                                                               chaperoneNewProfileIncludeVisibility.checked,
                                                               chaperoneNewProfileIncludeFadeDistance.checked,
                                                               chaperoneNewProfileIncludeCenterMarker.checked,
                                                               chaperoneNewProfileIncludePlaySpaceMarker.checked,
                                                               chaperoneNewProfileIncludeFloorBoundsMarker.checked,
                                                               chaperoneNewProfileIncludeBoundsColor.checked,
                                                               chaperoneNewProfileIncludeStyle.checked,
                                                               chaperoneNewProfileIncludeForceBounds.checked,
                                                               chaperoneNewProfileIncludeProximityWarnings.checked)
                }

            }
        }
        function openPopup() {
            chaperoneNewProfileName.text = ""
            chaperoneNewProfileIncludeGeometry.checked = false
            chaperoneNewProfileIncludeVisibility.checked = false
            chaperoneNewProfileIncludeFadeDistance.checked = false
            chaperoneNewProfileIncludeCenterMarker.checked = false
            chaperoneNewProfileIncludePlaySpaceMarker.checked = false
            chaperoneNewProfileIncludeFloorBoundsMarker.checked = false
            chaperoneNewProfileIncludeBoundsColor.checked = false
            chaperoneNewProfileIncludeStyle.checked = false
            chaperoneNewProfileIncludeForceBounds.checked = false
            chaperoneNewProfileIncludeProximityWarnings.checked = false
            open()
        }
    }


    content: ColumnLayout {
        spacing: 16

        SettingsCard {
            title: "配置文件"

            RowLayout {
                spacing: 10

                MyText {
                    text: "配置："
                }

                MyComboBox {
                    id: chaperoneProfileComboBox
                    Layout.fillWidth: true
                    model: [""]
                    onCurrentIndexChanged: {
                        if (currentIndex > 0) {
                            chaperoneApplyProfileButton.enabled = true
                            chaperoneDeleteProfileButton.enabled = true
                        } else {
                            chaperoneApplyProfileButton.enabled = false
                            chaperoneDeleteProfileButton.enabled = false
                        }
                    }
                }

                MyPushButton {
                    id: chaperoneApplyProfileButton
                    enabled: false
                    Layout.preferredWidth: 150
                    text: "应用"
                    onClicked: {
                        if (chaperoneProfileComboBox.currentIndex > 0) {
                            ChaperoneTabController.applyChaperoneProfile(chaperoneProfileComboBox.currentIndex - 1)
                            chaperoneProfileComboBox.currentIndex = 0
                        }
                    }
                }
            }
            RowLayout {
                spacing: 10
                Item { Layout.fillWidth: true }
                MyPushButton {
                    id: chaperoneDeleteProfileButton
                    enabled: false
                    Layout.preferredWidth: 200
                    text: "删除配置"
                    onClicked: {
                        if (chaperoneProfileComboBox.currentIndex > 0) {
                            chaperoneDeleteProfileDialog.profileIndex = chaperoneProfileComboBox.currentIndex - 1
                            chaperoneDeleteProfileDialog.open()
                        }
                    }
                }
                MyPushButton {
                    Layout.preferredWidth: 200
                    text: "新建配置"
                    onClicked: {
                        chaperoneNewProfileDialog.openPopup()
                    }
                }
            }
        }

        SettingsCard {
            title: "外观与开关"

            GridLayout {
                columns: 5
                rowSpacing: 10
                columnSpacing: 10

                MyText {
                    text: "可见性："
                    Layout.rightMargin: 12
                }

                MyPushButton2 {
                    id: chaperoneVisibilityMinus
                    text: "-"
                    Layout.preferredWidth: 40
                    onClicked: { chaperoneVisibilitySlider.value -= 0.05 }
                }

                MySlider {
                    id: chaperoneVisibilitySlider
                    from: 0.3
                    to: 1.0
                    stepSize: 0.01
                    value: 0.6
                    Layout.fillWidth: true
                    onPositionChanged: {
                        var val = (this.value * 100)
                        chaperoneVisibilityText.text = Math.round(val) + "%"
                    }
                    onValueChanged: { ChaperoneTabController.setBoundsVisibility(value.toFixed(2), false) }
                }

                MyPushButton2 {
                    id: chaperoneVisibilityPlus
                    text: "+"
                    Layout.preferredWidth: 40
                    onClicked: { chaperoneVisibilitySlider.value += 0.05 }
                }

                MyTextField {
                    id: chaperoneVisibilityText
                    text: "60.00"
                    keyBoardUID: 301
                    Layout.preferredWidth: 100
                    horizontalAlignment: Text.AlignHCenter
                    function onInputEvent(input) {
                        var val = parseFloat(input)
                        if (!isNaN(val)) {
                            if (val < 30.0) val = 30.0
                            if(val > 100) val = 100.0
                            var v = (val/100).toFixed(2)
                            if (v <= chaperoneVisibilitySlider.to) {
                                chaperoneVisibilitySlider.value = v
                            } else {
                                ChaperoneTabController.setBoundsVisibility(v, false)
                            }
                        }
                        text = Math.round(ChaperoneTabController.boundsVisibility * 100) + "%"
                    }
                }

                MyText {
                    text: "淡出距离："
                    Layout.rightMargin: 12
                }

                MyPushButton2 {
                    id: chaperoneFadeDistanceMinus
                    text: "-"
                    Layout.preferredWidth: 40
                    onClicked: { chaperoneFadeDistanceSlider.decrease() }
                }

                MySlider {
                    id: chaperoneFadeDistanceSlider
                    from: 0.0
                    to: 2.0
                    stepSize: 0.1
                    value: 0.7
                    Layout.fillWidth: true
                    onPositionChanged: {
                        var val = this.from + ( this.position  * (this.to - this.from))
                        chaperoneFadeDistanceText.text = val.toFixed(1)
                    }
                    onValueChanged: { ChaperoneTabController.setFadeDistance(this.value.toFixed(1), false) }
                }

                MyPushButton2 {
                    id: chaperoneFadeDistancePlus
                    text: "+"
                    Layout.preferredWidth: 40
                    onClicked: { chaperoneFadeDistanceSlider.increase() }
                }

                MyTextField {
                    id: chaperoneFadeDistanceText
                    text: "0.00"
                    keyBoardUID: 302
                    Layout.preferredWidth: 100
                    horizontalAlignment: Text.AlignHCenter
                    function onInputEvent(input) {
                        var val = parseFloat(input)
                        if (!isNaN(val)) {
                            if (val < 0.0) val = 0.0
                            var v = val.toFixed(1)
                            if (v <= chaperoneFadeDistanceSlider.to) {
                                chaperoneFadeDistanceSlider.value = v
                            } else {
                                ChaperoneTabController.setFadeDistance(v, false)
                            }
                        }
                        text = ChaperoneTabController.fadeDistance.toFixed(1)
                    }
                }

                MyText {
                    text: "高度："
                    Layout.rightMargin: 12
                }

                MyPushButton2 {
                    text: "-"
                    Layout.preferredWidth: 40
                    onClicked: { chaperoneHeightSlider.decrease() }
                }

                MySlider {
                    id: chaperoneHeightSlider
                    from: 0.01
                    to: 5.0
                    stepSize: 0.01
                    value: 2.0
                    Layout.fillWidth: true
                    onPositionChanged: {
                        var val = (this.from + ( this.position  * (this.to - this.from))).toFixed(2)
                        if (activeFocus) { ChaperoneTabController.setHeight(val, false); }
                        chaperoneHeightText.text = val
                    }
                    onValueChanged: { ChaperoneTabController.setHeight(value.toFixed(2), false) }
                }

                MyPushButton2 {
                    text: "+"
                    Layout.preferredWidth: 40
                    onClicked: { chaperoneHeightSlider.increase() }
                }

                MyTextField {
                    id: chaperoneHeightText
                    text: "0.00"
                    keyBoardUID: 303
                    Layout.preferredWidth: 100
                    horizontalAlignment: Text.AlignHCenter
                    function onInputEvent(input) {
                        var val = parseFloat(input)
                        if (!isNaN(val)) {
                            if (val < 0.01) val = 0.01
                            var v = val.toFixed(2)
                            if (v <= chaperoneHeightSlider.to) {
                                chaperoneHeightSlider.value = v
                            } else {
                                ChaperoneTabController.setHeight(v, false)
                            }
                        }
                        text = ChaperoneTabController.height.toFixed(2)
                    }
                }
            }

            Rectangle {
                color: "#202025"
                height: 1
                Layout.fillWidth: true
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 32

                MyToggleButton {
                    id: chaperoneCenterMarkerToggle
                    text: "中心标记"
                    Layout.fillWidth: false
                    onCheckedChanged: { ChaperoneTabController.setCenterMarkerNew(checked, false) }
                }

                MyToggleButton {
                    id: chaperonePlaySpaceToggle
                    text: "游玩空间"
                    onCheckedChanged: { ChaperoneTabController.setPlaySpaceMarker(checked, false) }
                }

                MyToggleButton {
                    id: chaperoneForceBoundsToggle
                    text: "强制显示边界"
                    onCheckedChanged: { ChaperoneTabController.setForceBounds(checked, false) }
                }

                MyToggleButton {
                    id: chaperoneDisableChaperone
                    text: "禁用安全区域"
                    onCheckedChanged: {
                        ChaperoneTabController.setDisableChaperone(checked, false)
                        chaperoneFadeDistanceMinus.enabled = !checked
                        chaperoneFadeDistancePlus.enabled = !checked
                        chaperoneFadeDistanceSlider.enabled = !checked
                        chaperoneFadeDistanceText.enabled = !checked
                    }
                }

                Item { Layout.fillWidth: true }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 16

            MyPushButton {
                id: chaperoneWarningsConfigButton
                text: "近距离警告设置"
                Layout.fillWidth: true
                onClicked: {
                    MyResources.playFocusChangedSound()
                    mainView.push(chaperoneWarningsPage)
                }
            }

            MyPushButton {
                id: chaperoneAdditionalButton
                text: "额外安全区域设置"
                Layout.fillWidth: true
                onClicked: {
                    MyResources.playFocusChangedSound()
                    mainView.push(chaperoneAdditionalPage)
                }
            }
        }

        ChangeOrientationGroupBox { }

        RowLayout {
            Layout.fillWidth: true

            MyPushButton {
                id: chaperoneResetButton
                text: "重置"
                Layout.preferredWidth: 250
                onClicked: {
                    ChaperoneTabController.reset()
                }
            }

            Item { Layout.fillWidth: true}

            MyPushButton {
                id: chaperoneReloadFromDiskButton
                text: "从磁盘重载"
                Layout.preferredWidth: 250
                onClicked: {
                    ChaperoneTabController.reloadFromDisk()
                }
            }
        }

        Component.onCompleted: {
            chaperoneVisibilitySlider.value = ChaperoneTabController.boundsVisibility
            if(chaperoneVisibilitySlider.value < 0.3){
                chaperoneVisibilitySlider.value = 0.3
            }

            var d = ChaperoneTabController.fadeDistance.toFixed(1)
            if (d <= chaperoneFadeDistanceSlider.to) {
                chaperoneFadeDistanceSlider.value = d
            }
            chaperoneFadeDistanceText.text = d
            var h = ChaperoneTabController.height.toFixed(2)
            if (h <= chaperoneHeightSlider.to) {
                chaperoneHeightSlider.value = h
            }
            chaperoneHeightText.text = h
            chaperoneCenterMarkerToggle.checked = ChaperoneTabController.centerMarkerNew
            //We Need a Set call on init in order to display the overlay!
            ChaperoneTabController.setCenterMarkerNew(chaperoneCenterMarkerToggle.checked);
            chaperonePlaySpaceToggle.checked = ChaperoneTabController.playSpaceMarker
            chaperoneForceBoundsToggle.checked = ChaperoneTabController.forceBounds
            chaperoneDisableChaperone.checked = ChaperoneTabController.disableChaperone
            var dim = ChaperoneTabController.chaperoneDimHeight
            if(dim > 0.0){
                chaperoneDisableChaperone.enabled = false;
            }else{
                chaperoneDisableChaperone.enabled = true;
            }
            if(dim > 0.0 || chaperoneDisableChaperone.checked){
                chaperoneFadeDistanceMinus.enabled = false;
                chaperoneFadeDistancePlus.enabled = false;
                chaperoneFadeDistanceSlider.enabled = false;
                chaperoneFadeDistanceText.enabled = false;

            }else{
                chaperoneFadeDistanceMinus.enabled = true;
                chaperoneFadeDistancePlus.enabled = true;
                chaperoneFadeDistanceSlider.enabled = true;
                chaperoneFadeDistanceText.enabled = true;
            }
            reloadChaperoneProfiles()
        }

        Connections {
            target: ChaperoneTabController
            onBoundsVisibilityChanged: {
                if (Math.abs(chaperoneVisibilitySlider.value - ChaperoneTabController.boundsVisibility) > 0.008) {
                    chaperoneVisibilitySlider.value = ChaperoneTabController.boundsVisibility
                }
            }
            onFadeDistanceChanged: {
                var d = ChaperoneTabController.fadeDistance.toFixed(1)
                if (d <= chaperoneFadeDistanceSlider.to && Math.abs(chaperoneFadeDistanceSlider.value - d) > 0.008) {
                    chaperoneFadeDistanceSlider.value = d
                }
                chaperoneFadeDistanceText.text = d
            }
            onHeightChanged: {
                var h = ChaperoneTabController.height.toFixed(2)
                if (h <= chaperoneHeightSlider.to && Math.abs(chaperoneHeightSlider.value - h) > 0.008) {
                    chaperoneHeightSlider.value = h
                }
                chaperoneHeightText.text = h
            }
            onChaperoneDimHeightChanged: {
                var dim = ChaperoneTabController.chaperoneDimHeight
                if(dim > 0.0){
                    chaperoneDisableChaperone.enabled = false;
                }else{
                    chaperoneDisableChaperone.enabled = true;
                }
                if(dim > 0.0 || chaperoneDisableChaperone.checked){
                    chaperoneFadeDistanceMinus.enabled = false;
                    chaperoneFadeDistancePlus.enabled = false;
                    chaperoneFadeDistanceSlider.enabled = false;
                    chaperoneFadeDistanceText.enabled = false;

                }else{
                    chaperoneFadeDistanceMinus.enabled = true;
                    chaperoneFadeDistancePlus.enabled = true;
                    chaperoneFadeDistanceSlider.enabled = true;
                    chaperoneFadeDistanceText.enabled = true;
                }
            }
            onCenterMarkerNewChanged: {
                chaperoneCenterMarkerToggle.checked = ChaperoneTabController.centerMarkerNew
            }
            onPlaySpaceMarkerChanged: {
                chaperonePlaySpaceToggle.checked = ChaperoneTabController.playSpaceMarker
            }
            onForceBoundsChanged: {
                chaperoneForceBoundsToggle.checked = ChaperoneTabController.forceBounds
            }
            onChaperoneProfilesUpdated: {
                reloadChaperoneProfiles()
            }
        }
    }

    function reloadChaperoneProfiles() {
        var profiles = [""]
        var profileCount = ChaperoneTabController.getChaperoneProfileCount()
        for (var i = 0; i < profileCount; i++) {
            profiles.push(ChaperoneTabController.getChaperoneProfileName(i))
        }
        chaperoneProfileComboBox.currentIndex = 0
        chaperoneProfileComboBox.model = profiles
    }
}
