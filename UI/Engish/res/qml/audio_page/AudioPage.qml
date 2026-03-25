import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../common"
import "device_selector"
import "proximity"
import "push_to_talk"
import "profiles"

MyStackViewPage {
    headerText: "Audio Settings"

    content: ColumnLayout {
        spacing: 16

        SettingsCard {
            title: "Playback Device"
            AudioDeviceSelector {
                Layout.fillWidth: true
            }
        }

        SettingsCard {
            title: "Mirror Audio"
            MirrorVolumeSlider {
                Layout.fillWidth: true
            }
        }

        SettingsCard {
            title: "Microphone"
            MicVolumeSlider {
                Layout.fillWidth: true
            }
        }

        SettingsCard {
            title: "Advanced Features"
            ProximityToggle {
                Layout.fillWidth: true
            }
            PttButtons {
                Layout.fillWidth: true
            }
            ProfileButtons {
                Layout.fillWidth: true
            }
        }
    }
}
