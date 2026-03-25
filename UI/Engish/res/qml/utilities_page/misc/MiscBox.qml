import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../../common"

    SettingsCard {
    id: utilMiscGroupBox
    Layout.fillWidth: true

    title: "Misc:"

    ColumnLayout {
        Layout.fillWidth: true

        RowLayout {
            spacing: 16

            MyToggleButton {
                id: trackerOvlToggle
                text: "Show Tracker Batteries"
                Layout.preferredWidth: 250
                onCheckedChanged: {
                    UtilitiesTabController.setTrackerOvlEnabled(this.checked, false)
                }
            }
        }

    }

    Component.onCompleted: {
            trackerOvlToggle.checked = UtilitiesTabController.trackerOvlEnabled
    }

    Connections {
        target: UtilitiesTabController
        onTrackerOvlEnabledChanged:{
            trackerOvlToggle.checked = UtilitiesTabController.trackerOvlEnabled
        }

    }
}

