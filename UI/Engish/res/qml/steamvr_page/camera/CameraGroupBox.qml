import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../../common"

SettingsCard {
    id: cameraGroupBox
    Layout.fillWidth: true

    title: "Camera: (requires SteamVR restart)"
    

    ColumnLayout {
        Layout.fillWidth: true

        

        RowLayout {
            spacing: 16

            MyToggleButton {
                id: steamvrCameraActiveToggle
                text: "Enable Camera"
                Layout.preferredWidth: 400
                onCheckedChanged: {
                       SteamVRTabController.setCameraActive(this.checked, false)
                    if(this.checked){
                        steamvrCameraBoundsToggle.enabled = true
                        steamvrCameraContToggle.enabled = true
                    }else{
                        steamvrCameraBoundsToggle.enabled = false
                        steamvrCameraContToggle.enabled = false
                    }
                }
            }


        }
        RowLayout {
            spacing: 16

            MyToggleButton {
                id: steamvrCameraBoundsToggle
                text: "Show camera on bounds collision"
                Layout.preferredWidth: 250
                onCheckedChanged: {
                       SteamVRTabController.setCameraBounds(this.checked, false)
                }
            }
            Item{
                Layout.preferredWidth: 100
            }

            MyToggleButton {
                id: steamvrCameraContToggle
                text: "Show camera on controller"
                onCheckedChanged: {
                    SteamVRTabController.setCameraCont(this.checked, false)
                }
            }
        }

    }

    Component.onCompleted: {
        var c1 = SteamVRTabController.cameraActive
        steamvrCameraActiveToggle.checked = c1
        steamvrCameraBoundsToggle.checked = SteamVRTabController.cameraBounds
        steamvrCameraContToggle.checked = SteamVRTabController.cameraCont

        if(!c1){

            steamvrCameraBoundsToggle.enabled = false;
            steamvrCameraContToggle.enabled = false;
        }

    }

    Connections {
        target: SteamVRTabController
        onCameraActiveChanged: {
            steamvrCameraActiveToggle.checked = SteamVRTabController.cameraActive
        }
        onCameraContChanged: {
            steamvrCameraContToggle.checked = SteamVRTabController.cameraCont
        }
        onCameraBoundsChanged: {
            steamvrCameraBoundsToggle.checked = SteamVRTabController.cameraBounds
        }


    }
}
