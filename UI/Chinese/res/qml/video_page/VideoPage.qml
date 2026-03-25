import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../common"
import "brightness"
import "color"
import "supersampling"
import "miscvid"
import "profiles"
import "overlaycolorbright"

MyStackViewPage {
    headerText: "视频设置"
    content: ColumnLayout {
        spacing: 16


            OverlayMethodGroupBox{
                id: overlayMethodGroupBox
                Layout.fillWidth: true
            }
            BrightnessGroupBox {
                id: brightnessGroupBox
                Layout.fillWidth: true
            }
            ColorGroupBox {
                id:  colorGroupBox
                Layout.fillWidth: true
            }
            SuperSamplingGroupBox{
                id: ssGroupBox
                Layout.fillWidth: true
            }
            VideoProfileGroupBox{
                id: videoProfileGroupBox
                Layout.fillWidth: true
            }
            VideoMiscGroupBox{
                id:miscVideoGroupBox
                Layout.fillWidth: true
            }
        }
    Component.onCompleted: {
        overlayMethodGroupBox.visible = VideoTabController.isOverlayMethodActive
        brightnessGroupBox.visible = !(VideoTabController.isOverlayMethodActive);
        colorGroupBox.visible = !(VideoTabController.isOverlayMethodActive);
    }

    Connections {
        target: VideoTabController
            onIsOverlayMethodActiveChanged:{
                overlayMethodGroupBox.visible = VideoTabController.isOverlayMethodActive
                brightnessGroupBox.visible = !(VideoTabController.isOverlayMethodActive);
                colorGroupBox.visible = !(VideoTabController.isOverlayMethodActive);
            }

    }

}
