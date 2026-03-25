import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "common"


MyStackViewPage {
    headerText: "空间修复"

    content: ColumnLayout {
        spacing: 16

        SettingsCard {
            title: "说明"
            
            MyText {
                text: "请将一个控制器放置在地面上，并确保基站视野清晰。"
                wrapMode: Text.WordWrap
                font.pointSize: 18
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
            }

            MyText {
                id: seatedWarningText
                text: "（在“坐姿”追踪模式下禁用）"
                wrapMode: Text.WordWrap
                font.pointSize: 16
                color: "#ff6b6b"
                Layout.topMargin: 8
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
            }
        }

        SettingsCard {
            title: "空间操作"
            
            MyPushButton {
                id: fixButton
                Layout.fillWidth: true
                text: "修复地面"
                Layout.preferredHeight: 60
                onClicked: { FixFloorTabController.fixFloorClicked() }
            }

            MyPushButton {
                id: recenterButton
                Layout.fillWidth: true
                text: "重置空间中心"
                Layout.preferredHeight: 60
                onClicked: { FixFloorTabController.recenterClicked() }
            }

            MyPushButton {
                id: undoFixButton
                enabled: false
                visible: false
                Layout.fillWidth: true
                text: "撤销修复"
                onClicked: { FixFloorTabController.undoFixFloorClicked() }
            }

            MyPushButton {
                id: zeroSpaceButton
                Layout.fillWidth: true
                text: "将当前偏移应用为中心"
                Layout.preferredHeight: 60
                onClicked: { MoveCenterTabController.addCurOffsetAsCenter() }
            }

            Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 1; color: "#1D1D1E" }

            MyPushButton {
                id: revertButton
                Layout.fillWidth: true
                text: "恢复此会话的所有更改"
                Layout.preferredHeight: 60
                onClicked: { ChaperoneTabController.applyAutosavedProfile() }
            }
        }

        Component.onCompleted: {
            statusMessageText.text = ""
            //undoFixButton.enabled = FixFloorTabController.canUndo
            fixButton.enabled = true

            if (MoveCenterTabController.trackingUniverse === 0) {
                fixButton.enabled = false
                recenterButton.enabled = false
                zeroSpaceButton.enabled = false
                revertButton.enabled = false
                undoFixButton.enabled = false
                seatedWarningText.visible = true
            }
        }

        Timer {
            id: statusMessageTimer
            repeat: false
            onTriggered: {
                statusMessageText.text = ""
            }
        }

        Connections {
            target: FixFloorTabController
            onStatusMessageSignal: {
                if (statusMessageTimer.running) {
                    statusMessageTimer.stop()
                }
                statusMessageText.text = FixFloorTabController.currentStatusMessage()
                statusMessageTimer.interval = FixFloorTabController.currentStatusMessageTimeout() * 1000
                statusMessageTimer.start()
            }
            onMeasureStartSignal: {
                fixButton.enabled = false
                undoFixButton.enabled = false
            }
            onMeasureEndSignal: {
                fixButton.enabled = true
                // undoFixButton.enabled = FixFloorTabController.canUndo
            }
            onCanUndoChanged: {
                //undoFixButton.enabled = FixFloorTabController.canUndo
                // revert below to this -^
                undoFixButton.enabled = false
            }
        }

        Connections {
            target: MoveCenterTabController
            onTrackingUniverseChanged: {
                if (MoveCenterTabController.trackingUniverse === 0) {
                    fixButton.enabled = false
                    recenterButton.enabled = false
                    zeroSpaceButton.enabled = false
                    revertButton.enabled = false
                    undoFixButton.enabled = false
                    seatedWarningText.visible = true
                } else if (MoveCenterTabController.trackingUniverse === 1) {
                    fixButton.enabled = true
                    recenterButton.enabled = true
                    zeroSpaceButton.enabled = true
                    revertButton.enabled = true
                    // undoFixButton.enabled = true
                    // TODO Fix Undo Feature -^
                    seatedWarningText.visible = false
                } else {
                    fixButton.enabled = false
                    recenterButton.enabled = false
                    zeroSpaceButton.enabled = false
                    revertButton.enabled = false
                    undoFixButton.enabled = false
                    seatedWarningText.visible = false
                }
            }
        }

    }

}
