import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../../common"
import "../dialog_boxes"

//Audio Profiles temporarily disabled.
ColumnLayout {
    AudioMessageDialog {
        id: audioMessageDialog
    }

    AudioDeleteProfileDialog {
        id: audioDeleteProfileDialog
    }

    AudioNewProfileDialog {
        id: audioNewProfileDialog
    }

    RowLayout {
        spacing: 10

        MyText {
            Layout.preferredWidth: 150
            text: "音频配置文件："
            visible: false
        }

        MyComboBox {
            id: audioProfileComboBox
            Layout.preferredWidth: 250
            model: [""]
            enabled: false
            visible: false
            onCurrentIndexChanged: {
                if (currentIndex > 0) {
                    audioApplyProfileButton.enabled = true
                    audioDeleteProfileButton.enabled = true
                } else {
                    audioApplyProfileButton.enabled = false
                    audioDeleteProfileButton.enabled = false
                }
            }
        }

        MyPushButton {
            id: audioApplyProfileButton
            enabled: false
            visible: false
            Layout.preferredWidth: 150
            text: "应用"
            onClicked: {
                if (audioProfileComboBox.currentIndex > 0) {
                    AudioTabController.applyAudioProfile(
                                audioProfileComboBox.currentIndex - 1)
                }
            }
        }
        MyText {
            text: "请在 SteamVR 按键绑定菜单中修改按键通话设置。"
        }
    }
    RowLayout {
        spacing: 10

        MyPushButton {
            id: audioDeleteProfileButton
            enabled: false
            visible: false
            Layout.preferredWidth: 200
            text: "删除配置"
            onClicked: {
                if (audioProfileComboBox.currentIndex > 0) {
                    audioDeleteProfileDialog.profileIndex = audioProfileComboBox.currentIndex - 1
                    audioDeleteProfileDialog.open()
                }
            }
        }
        MyPushButton {
            enabled: false
            visible: false
            Layout.preferredWidth: 200
            text: "新建配置"
            onClicked: {
                audioNewProfileDialog.openPopup()
            }
        }
    }
    Component.onCompleted: {
        //reloadAudioProfiles()
    }
    Connections {
        target: AudioTabController
        onAudioProfilesUpdated: {
            reloadAudioProfiles()
        }
        onAudioProfileAdded: {
            audioProfileComboBox.currentIndex = AudioTabController.getAudioProfileCount()
        }
        onDefaultProfileDisplay: {
            audioProfileComboBox.currentIndex = AudioTabController.getDefaultAudioProfileIndex(
                        ) + 1
        }
    }
    function reloadAudioProfiles() {
        var profiles = [""]
        var profileCount = AudioTabController.getAudioProfileCount()
        for (var i = 0; i < profileCount; i++) {
            profiles.push(AudioTabController.getAudioProfileName(i))
        }
        audioProfileComboBox.currentIndex = 0
        audioProfileComboBox.model = profiles
    }
}
