import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../../common"

SettingsCard {
    id: steamVRMiscGroupBox
    Layout.fillWidth: true

    title: "杂项："
    

    ColumnLayout {
        Layout.fillWidth: true

        

        RowLayout {
            spacing: 16

            MyToggleButton {
                id: steamvrPerformanceGraphToggle
                text: "开启渲染时间图表"
                Layout.preferredWidth: 220
                onCheckedChanged: {
                    SteamVRTabController.setPerformanceGraph(this.checked, false)
                }
            }
            MyText {
                Layout.preferredWidth: 20
                text: " "
            }
            MyToggleButton {
                id: steamvrNoHMDToggle
                text: "需要头显连接"
                Layout.preferredWidth: 220
                onCheckedChanged: {
                    SteamVRTabController.setNoHMD(this.checked, false)
                }
            }
            MyText {
                Layout.preferredWidth: 20
                text: " "
            }
            MyToggleButton {
                id: steamvrNoFadeToGridToggle
                Layout.fillWidth: true
                text: "禁用淡出至网格"
                onCheckedChanged: {
                    SteamVRTabController.setNoFadeToGrid(this.checked, false)
                }
            }
        }
        RowLayout {
            spacing: 16

            MyToggleButton {
                id: steamvrMultipleDriverToggle
                Layout.preferredWidth: 220
                text: "允许使用多个驱动"
                onCheckedChanged: {
                    SteamVRTabController.setMultipleDriver(this.checked, false)
                }
            }
            MyText {
                Layout.preferredWidth: 20
                text: " "
            }
            MyToggleButton {
                id: steamvrSystemButtonToggle
                Layout.fillWidth: true
                text: "开启系统键绑定"
                onCheckedChanged: {
                    SteamVRTabController.setSystemButton(this.checked, false)
                }
            }

        }

        RowLayout {
            spacing: 16

            MyToggleButton {
                id: steamvrNotificationToggle
                text: "禁用通知"
                 Layout.preferredWidth: 220
                onCheckedChanged: {
                    SteamVRTabController.setDND(this.checked, false)
                }
            }
            MyText {
                Layout.preferredWidth: 20
                text: " "
            }
            MyToggleButton {
                id: steamvrControllerPowerToggle
                Layout.fillWidth: true
                text: "控制器电源可开启 SteamVR"
                onCheckedChanged: {
                    SteamVRTabController.setControllerPower(this.checked, false)
                }
            }

        }

    }

    Component.onCompleted: {
            steamvrPerformanceGraphToggle.checked = SteamVRTabController.performanceGraph
        steamvrSystemButtonToggle.checked = SteamVRTabController.systemButton
        steamvrMultipleDriverToggle.checked = SteamVRTabController.multipleDriver
        steamvrNoFadeToGridToggle.checked = SteamVRTabController.noFadeToGrid
        steamvrNotificationToggle.checked = SteamVRTabController.dnd
        steamvrControllerPowerToggle.checked = SteamVRTabController.controllerPower
        steamvrNoHMDToggle.checked = SteamVRTabController.noHMD
    }

    Connections {
        target: SteamVRTabController
        onPerformanceGraphChanged:{
            steamvrPerformanceGraphToggle.checked = SteamVRTabController.performanceGraph
        }
        onSystemButtonChanged:{
            steamvrSystemButtonToggle.checked = SteamVRTabController.systemButton
        }
        onMultipleDriverChanged:{
            steamvrMultipleDriverToggle.checked = SteamVRTabController.multipleDriver
        }
        onNoFadeToGridChanged:{
            steamvrNoFadeToGridToggle.checked = SteamVRTabController.noFadeToGrid
        }
        onDNDChanged:{
            steamvrNotificationToggle.checked = SteamVRTabController.dnd
        }
        onNoHMDChanged:{
            steamvrNoHMDToggle.checked = SteamVRTabController.noHMD
        }
        onControllerPowerChanged:{
            steamvrControllerPowerToggle.checked = SteamVRTabController.controllerPower
        }

    }
}
