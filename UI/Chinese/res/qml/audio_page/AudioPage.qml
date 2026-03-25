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
    headerText: "音频设置"

    content: ColumnLayout {
        spacing: 16

        SettingsCard {
            title: "播放设备"
            AudioDeviceSelector {
                Layout.fillWidth: true
            }
        }

        SettingsCard {
            title: "音频镜像"
            MirrorVolumeSlider {
                Layout.fillWidth: true
            }
        }

        SettingsCard {
            title: "麦克风"
            MicVolumeSlider {
                Layout.fillWidth: true
            }
        }

        SettingsCard {
            title: "高级功能"
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
