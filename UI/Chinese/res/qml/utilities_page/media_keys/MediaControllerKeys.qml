import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../../common"

    SettingsCard {
    id: mediaKeysGroupBox
    Layout.fillWidth: true

    title: "媒体控制键"

    ColumnLayout {
        Layout.fillWidth: true

        RowLayout {
            spacing: 10

            property string playPauseButtonPath: "../../../img/audio/media_keys/outline_play_pause_white_24dp"
            property string stopButtonPath: "../../../img/audio/media_keys/outline_stop_white_24dp"
            property string previousButtonPath: "../../../img/audio/media_keys/outline_skip_previous_white_24dp"
            property string nextButtonPath: "../../../img/audio/media_keys/outline_skip_next_white_24dp"

            MediaButton {
                id: previousSongButton
                imagePath: parent.previousButtonPath
                onClicked: {
                    UtilitiesTabController.sendMediaPreviousSong()
                }
            }

            MediaButton {
                id: stopSongButton
                imagePath: parent.stopButtonPath
                onClicked: {
                    UtilitiesTabController.sendMediaStopSong()
                }
            }

            MediaButton {
                id: playPauseSongButton
                imagePath: parent.playPauseButtonPath
                onClicked: {
                    UtilitiesTabController.sendMediaPausePlay()
                }
            }

            MediaButton {
                id: nextSongButton
                imagePath: parent.nextButtonPath
                onClicked: {
                    UtilitiesTabController.sendMediaNextSong()
                }
            }
        }
    }
}
