import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../../common"

SettingsCard {
    id: brightnessGroupBox
    Layout.fillWidth: true

    title: "杂项："
    

    ColumnLayout {
        Layout.fillWidth: true

        

        RowLayout {
            spacing: 16

            MyToggleButton {
                id: videoMotionSmoothingToggle
                text: "运动平滑"
                onCheckedChanged: {
                       VideoTabController.setMotionSmoothing(this.checked, false)
                }
            }
            Item {
                Layout.preferredWidth: 20
            }

            MyToggleButton {
                id: videoAllowSupersampleFilteringToggle
                text: "高级超采样过滤"
                onCheckedChanged: {
                    VideoTabController.setAllowSupersampleFiltering(this.checked, false)
                }
            }
            Item {
                Layout.preferredWidth: 20
            }

            MyToggleButton {
                id: videoUseOverlayToggle
                text: "使用叠加层调整色彩"
                onCheckedChanged: {
                    VideoTabController.setIsOverlayMethodActive(this.checked, true)
                }
            }
        }

    }

    Component.onCompleted: {
        videoAllowSupersampleFilteringToggle.checked = VideoTabController.allowSupersampleFiltering
        videoMotionSmoothingToggle.checked = VideoTabController.motionSmoothing
        videoUseOverlayToggle.checked = VideoTabController.isOverlayMethodActive
    }

    Connections {
        target: VideoTabController
        onAllowSupersampleFilteringChanged: {
            videoAllowSupersampleFilteringToggle.checked = VideoTabController.allowSupersampleFiltering
        }

        onMotionSmoothingChanged: {
            videoMotionSmoothingToggle.checked = VideoTabController.motionSmoothing
        }
        onIsOverlayMethodActiveChanged:{
            videoUseOverlayToggle.checked = VideoTabController.isOverlayMethodActive
        }

    }
}
