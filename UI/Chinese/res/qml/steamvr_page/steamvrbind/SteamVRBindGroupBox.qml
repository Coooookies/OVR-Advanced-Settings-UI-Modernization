import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../../common"

SettingsCard {
    id: steamVRBindGroupBox
    Layout.fillWidth: true
    title: "按键绑定"

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 10
        
        RowLayout {
            spacing: 10
            MyToggleButton {
                id: steamvrBindingToggle
                text: "开启分应用绑定"
                Layout.preferredWidth: 250
                onCheckedChanged: {
                    SteamVRTabController.setPerAppBindEnabled(this.checked, false)
                    if(!steamvrBindingToggle.checked){
                        appSelect.enabled = false;
                        setDefaultBtn.enabled = false;
                        setBinding.enabled = false;
                    }else{
                        appSelect.enabled = true;
                        setDefaultBtn.enabled = true;
                        setBinding.enabled = true;
                    }
                }
            }
            MyText {
                text: "应用："
                Layout.preferredWidth: 150
                horizontalAlignment: Text.AlignRight
                Layout.rightMargin: 2
            }
            MyTextField {
                id: appSelect
                Layout.fillWidth: true
                text: "steam.overlay.1009850"
                keyBoardUID: 201
                horizontalAlignment: Text.AlignHCenter
                function onInputEvent(input) {
                    this.text = input
                }
            }
            MyPushButton {
                id: bindingsButton
                activationSoundEnabled: false
                text: "打开按键绑定"
                Layout.preferredWidth: 180
                onClicked: {
                     SteamVRTabController.launchBindingUI()
                }
            }
        }
        RowLayout {
            spacing: 10
            MyText {
                text: "保存所选应用的当前绑定："
                horizontalAlignment: Text.AlignLeft
                Layout.fillWidth: true
                Layout.rightMargin: 2
            }
            MyPushButton {
                    id: setBinding
                    Layout.preferredWidth: 180
                    text:"针对当前游戏"
                    onClicked: {
                        SteamVRTabController.setBindingQMLWrapper(appSelect.text)
                    }
            }
            MyPushButton {
                    id: setDefaultBtn
                    Layout.preferredWidth: 180
                    text:"作为默认"
                    onClicked: {
                        SteamVRTabController.setBindingQMLWrapper(appSelect.text,true)
                    }
            }
        }

    }

    Component.onCompleted: {
            steamvrBindingToggle.checked = SteamVRTabController.perAppBindEnabled
        if(!steamvrBindingToggle.checked){
            appSelect.enabled = false;
            setDefaultBtn.enabled = false;
            setBinding.enabled = false;
        }else{
            appSelect.enabled = true;
            setDefaultBtn.enabled = true;
            setBinding.enabled = true;
        }
    }

    Connections {
        target: SteamVRTabController
        onPerformanceGraphChanged:{
            steamvrBindingToggle.checked = SteamVRTabController.perAppBindEnabled
        }

    }
}
