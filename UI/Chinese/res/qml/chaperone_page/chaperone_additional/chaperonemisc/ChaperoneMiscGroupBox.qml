import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../../../common"
import "." // QTBUG-34418, singletons require explicit import to load qmldir file
SettingsCard {
    id: chaperoneMiscGroupBox
    Layout.fillWidth: true

    title: "杂项："
    

    ColumnLayout {
        Layout.fillWidth: true

        

        RowLayout {
            spacing: 16

            MyToggleButton {
                id: chaperoneFloorToggleBtn
                text: "地面边界常驻"
                Layout.preferredWidth: 375
                onCheckedChanged: {
                    ChaperoneTabController.setChaperoneFloorToggle(this.checked, false)
                }
            }


            MyToggleButton {
                id: legacyCenterMarkerbtn
                text: "旧版中心标记"
                Layout.preferredWidth: 375
                onCheckedChanged: {
                    ChaperoneTabController.setCenterMarker(this.checked, false)
                }
            }

            MyPushButton{
                id:btnResetOrientation
                text: "重置转动计数器"
                Layout.preferredWidth: 200
                onClicked: {
                    StatisticsTabController.statsRotationResetClicked()
                }
            }

        }

    }

    Component.onCompleted: {
            chaperoneFloorToggleBtn.checked = ChaperoneTabController.chaperoneFloorToggle
            legacyCenterMarkerbtn.checked = ChaperoneTabController.centerMarker
    }

    Connections {
        target: ChaperoneTabController
        onChaperoneFloorToggleChanged:{
            chaperoneFloorToggleBtn.checked = ChaperoneTabController.chaperoneFloorToggle
        }
        onCenterMarkerChanged:{
            legacyCenterMarkerbtn.checked = ChaperoneTabController.centerMarker
        }
    }
}
