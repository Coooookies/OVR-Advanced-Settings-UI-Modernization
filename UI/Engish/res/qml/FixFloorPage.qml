import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "common"


MyStackViewPage {
    headerText: "Space Fix"

    content: ColumnLayout {
        spacing: 16

        SettingsCard {
            title: "Instructions"
            
            MyText {
                text: "Place one controller on the ground and ensure good visibility to the base stations."
                wrapMode: Text.WordWrap
                font.pointSize: 18
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                Layout.margins: 16
            }

            MyText {
                id: seatedWarningText
                text: "(Disabled in 'Seated' Universe Type)"
                visible: false
                wrapMode: Text.WordWrap
                font.pointSize: 16
                color: "#ff6b6b"
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
            }

            MyText {
                id: statusMessageText
                enabled: false
                text: ""
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                color: "#A0A0A5"
            }
        }

        SettingsCard {
            title: "Space Actions"
            
            MyPushButton {
                id: fixButton
                Layout.fillWidth: true
                text: "Fix Floor"
                Layout.preferredHeight: 60
                onClicked: { FixFloorTabController.fixFloorClicked() }
            }

            MyPushButton {
                id: recenterButton
                Layout.fillWidth: true
                text: "Recenter Space"
                Layout.preferredHeight: 60
                onClicked: { FixFloorTabController.recenterClicked() }
            }

            MyPushButton {
                id: undoFixButton
                enabled: false
                visible: false
                Layout.fillWidth: true
                text: "Undo Fix"
                onClicked: { FixFloorTabController.undoFixFloorClicked() }
            }

            MyPushButton {
                id: zeroSpaceButton
                Layout.fillWidth: true
                text: "Apply Space Settings Offsets as Center"
                Layout.preferredHeight: 60
                onClicked: { MoveCenterTabController.addCurOffsetAsCenter() }
            }

            Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 1; color: "#1D1D1E" }

            MyPushButton {
                id: revertButton
                Layout.fillWidth: true
                text: "Revert All Changes from This Session"
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
