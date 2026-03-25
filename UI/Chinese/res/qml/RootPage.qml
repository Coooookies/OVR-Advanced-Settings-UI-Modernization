import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "." // QTBUG-34418, singletons require explicit import to load qmldir file
import "common"
import "utilities_page"
import "audio_page"
import "video_page"

MyStackViewPage {
    id: rootPage
    width: 1200
    height: 800
    headerText: "OVR Advanced Settings"
    headerShowBackButton: false
    stackView: mainView

   Component.onCompleted: {
       reloadChaperoneProfiles()
       reloadVideoProfiles()

       summaryVersionText.text = applicationVersion
       summaryVersionCheckText.text = OverlayController.versionCheckText
       if (OverlayController.newVersionDetected)
       {
           summaryVersionCheckTextRect.color = "#ff0000"
       } else {
           summaryVersionCheckTextRect.color = "#111112"
       }


       if (MoveCenterTabController.trackingUniverse === 0) {
           summaryPlaySpaceModeText.text = "Sitting"
       } else if (MoveCenterTabController.trackingUniverse === 1) {
           summaryPlaySpaceModeText.text = "Standing"
       } else {
           summaryPlaySpaceModeText.text = "Unknown(" + MoveCenterTabController.trackingUniverse + ")"
       }
       updateStatistics()
       if (visible) {
           summaryUpdateTimer.start()
       }
       summaryMicVolumeSlider.value = AudioTabController.micVolume
       summaryMicMuteToggle.checked = AudioTabController.micMuted
       summaryPttToggle.checked = AudioTabController.pttEnabled
   }

   Connections {
       target: OverlayController
       onNewVersionDetectedChanged: {
           if (OverlayController.newVersionDetected)
           {
               summaryVersionCheckTextRect.color = "#ff0000"
           } else {
               summaryVersionCheckTextRect.color = "#111112"
           }
       }
       onVersionCheckTextChanged: {
           summaryVersionCheckText.text = OverlayController.versionCheckText
       }
       onDisableVersionCheckChanged: {
           if (OverlayController.disableVersionCheck)
           {
               summaryVersionCheckText.visible = false
               summaryVersionCheckTextRect.color = "#111112"
           } else {
               summaryVersionCheckText.visible = true
               if (OverlayController.newVersionDetected)
               {
                   summaryVersionCheckTextRect.color = "#ff0000"
               } else {
                   summaryVersionCheckTextRect.color = "#111112"
               }
           }
       }
   }

   Connections {
       target: ChaperoneTabController
       onChaperoneProfilesUpdated: {
           reloadChaperoneProfiles()
       }
   }

   Connections {
       target: VideoTabController
       onVideoProfilesUpdated: {
           reloadVideoProfiles()
       }
   }

   Connections {
       target: AudioTabController
       onMicVolumeChanged: {
           summaryMicVolumeSlider.value = AudioTabController.micVolume
       }
       onMicMutedChanged: {
           summaryMicMuteToggle.checked = AudioTabController.micMuted
       }
       onPttEnabledChanged: {
           summaryPttToggle.checked = AudioTabController.pttEnabled
       }
   }

   Connections {
       target: MoveCenterTabController
       onTrackingUniverseChanged: {
           if (MoveCenterTabController.trackingUniverse === 0) {
               summaryPlaySpaceModeText.text = "坐姿"
           } else if (MoveCenterTabController.trackingUniverse === 1) {
               summaryPlaySpaceModeText.text = "站姿"
           } else {
               summaryPlaySpaceModeText.text = "未知 (" + MoveCenterTabController.trackingUniverse + ")"
           }
       }
   }


   function updateStatistics() {
       var rotations = StatisticsTabController.hmdRotations
       if (rotations > 0) {
           summaryHmdRotationsText.text = rotations.toFixed(2) + " CCW"
       } else {
           summaryHmdRotationsText.text = -rotations.toFixed(2) + " CW"
       }
       summaryDroppedFramesText.text = StatisticsTabController.droppedFrames
       summaryReprojectedFramesText.text = StatisticsTabController.reprojectedFrames
       summaryTimedOutText.text = StatisticsTabController.timedOut
       summaryTotalRatioText.text = (StatisticsTabController.totalReprojectedRatio*100.0).toFixed(1) + "%"
   }

   Timer {
       id: summaryUpdateTimer
       repeat: true
       interval: 100
       onTriggered: {
           parent.updateStatistics()
       }
   }

   onVisibleChanged: {
       if (visible) {
           updateStatistics()
           summaryUpdateTimer.start()
       } else {
           summaryUpdateTimer.stop()
       }
   }


    function reloadChaperoneProfiles() {
       var profiles = [""]
       var profileCount = ChaperoneTabController.getChaperoneProfileCount()
       for (var i = 0; i < profileCount; i++) {
           profiles.push(ChaperoneTabController.getChaperoneProfileName(i))
       }
       summaryChaperoneProfileComboBox.currentIndex = 0
       summaryChaperoneProfileComboBox.model = profiles
    }


    function reloadVideoProfiles() {
       var profiles = [""]
       var profileCount = VideoTabController.getVideoProfileCount()
       for (var i = 0; i < profileCount; i++) {
           profiles.push(VideoTabController.getVideoProfileName(i))
       }
       summaryVideoProfileComboBox.currentIndex = 0
       summaryVideoProfileComboBox.model = profiles
    }
}
