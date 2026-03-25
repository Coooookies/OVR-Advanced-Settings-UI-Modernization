import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../../common"

ColumnLayout {
    RowLayout {
        MyToggleButton {
            id: audioPttEnabledToggle
            Layout.fillWidth: true
            text: "按键通话 (PTT)"
            onClicked: {
                AudioTabController.setPttEnabled(checked, true)
            }
        }
        MyToggleButton {
            id: audioPttShowNotificationToggle
            Layout.fillWidth: true
            text: "在头显中显示通知"
            onCheckedChanged: {
                AudioTabController.setPttShowNotification(checked, false)
            }
        }
        MyToggleButton {
            id: audioPttReverseToggle
            Layout.fillWidth: true
            text: "按键静音"
            onClicked: {
                AudioTabController.setMicReversePtt(checked, false)
            }
        }
    }

    Component.onCompleted: {
        audioPttEnabledToggle.checked = AudioTabController.pttEnabled
        audioPttShowNotificationToggle.checked = AudioTabController.pttShowNotification
        audioPttReverseToggle.checked = AudioTabController.micReversePtt
    }
    Connections {
        target: AudioTabController
        onPttEnabledChanged: {
            audioPttEnabledToggle.checked = AudioTabController.pttEnabled
        }
        onMicReversePttChanged: {
            audioPttReverseToggle.checked = AudioTabController.micReversePtt
        }
        onPttShowNotificationChanged: {
            audioPttShowNotificationToggle.checked = AudioTabController.pttShowNotification
        }
    }
}
