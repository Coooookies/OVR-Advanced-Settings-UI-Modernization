import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0
import ovras.advsettings 1.0
import ".."
import "../utilities_page"
import "../audio_page"
import "../motion_page"
import "../video_page"
import "../chaperone_page"
import "../steamvr_page"
import "../rotation_page"
import "../chaperone_page/chaperone_additional"
import "../steamvr_page/steamvr_additional"

Rectangle {
    id: root
    color: "#111112"
    width: 1200
    height: 800

    property SummaryPage summaryPage: SummaryPage {
        stackView: mainView
    }

    property SteamVRPage steamVRPage: SteamVRPage {
        stackView: mainView
        visible: false
    }

    property ChaperonePage chaperonePage: ChaperonePage {
        stackView: mainView
        visible: false
    }

    property ChaperoneWarningsPage chaperoneWarningsPage: ChaperoneWarningsPage {
        stackView: mainView
        visible: false
    }

    property ChaperoneAdditionalPage chaperoneAdditionalPage: ChaperoneAdditionalPage{
        stackView: mainView
        visible: false
    }

    property SteamVRTXRXPage steamVRTXRXPage: SteamVRTXRXPage{
        stackView: mainView
        visible: false
    }

    property PlayspacePage playspacePage: PlayspacePage {
        stackView: mainView
        visible: false
    }

    property MotionPage motionPage: MotionPage {
        stackView: mainView
        visible: false
    }

    property RotationPage  rotationPage: RotationPage {
        stackView: mainView
        visible: false
    }

    property FixFloorPage fixFloorPage: FixFloorPage {
        stackView: mainView
        visible: false
    }

    property StatisticsPage statisticsPage: StatisticsPage {
        stackView: mainView
        visible: false
    }

    property SettingsPage settingsPage: SettingsPage {
        stackView: mainView
        visible: false
    }

    property AudioPage audioPage: AudioPage {
        stackView: mainView
        visible: false
    }

    property UtilitiesPage utilitiesPage: UtilitiesPage {
        stackView: mainView
        visible: false
    }

    property VideoPage videoPage: VideoPage {
        stackView: mainView
        visible:false
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // Sidebar Container
        Rectangle {
            id: sidebarContainer
            visible: mainView.depth === 1
            Layout.preferredWidth: 280
            Layout.fillHeight: true
            color: "#141415"

            ColumnLayout {
                anchors.fill: parent
                anchors.topMargin: 14
                anchors.bottomMargin: 16
                anchors.leftMargin: 16
                anchors.rightMargin: 16
                spacing: 0 // We'll handle individual spacing

                // Part 1: Top Title Section
                Image {
                    id: titleImage
                    source: "../../img/main_menu_icons/title"
                    Layout.preferredWidth: 248
                    Layout.preferredHeight: 32
                    fillMode: Image.PreserveAspectFit
                }

                Item { Layout.preferredHeight: 8 } // Spacing between Title and Head

                // Part 2: Head Menu Area
                ColumnLayout {
                    id: headMenu
                    Layout.fillWidth: true
                    spacing: 2
                    
                    NavButton {
                        text: "首页"
                        iconPath: "../../img/main_menu_icons/dashboard_tab_icon"
                        isSelected: mainView.currentItem === summaryPage
                        onClicked: {
                            mainView.replace(summaryPage)
                            MyResources.playFocusChangedSound()
                        }
                    }
                    NavButton {
                        text: "统计"
                        iconPath: "../../img/main_menu_icons/statistics_tab_icon"
                        isSelected: mainView.currentItem === statisticsPage
                        onClicked: {
                            mainView.replace(statisticsPage)
                            MyResources.playFocusChangedSound()
                        }
                    }
                }

                Item { Layout.preferredHeight: 12 } // Space before divider
                Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 1; color: "#1D1D1E" }
                Item { Layout.preferredHeight: 12 } // Space after divider

                // Part 3: Core Menu Area (Flex: 1, Scrollable)
                ScrollView {
                    id: coreMenuScroll
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    ScrollBar.vertical.policy: ScrollBar.AsNeeded

                    ColumnLayout {
                        id: coreMenu
                        width: parent.width
                        spacing: 2
                        
                        NavButton {
                            text: "SteamVR"
                            iconPath: "../../img/main_menu_icons/steamvr_tab_icon"
                            isSelected: mainView.currentItem === steamVRPage
                            onClicked: {
                                mainView.replace(steamVRPage)
                                MyResources.playFocusChangedSound()
                            }
                        }
                        NavButton {
                            text: "安全区域"
                            iconPath: "../../img/main_menu_icons/chaperone_tab_icon"
                            isSelected: mainView.currentItem === chaperonePage
                            onClicked: {
                                mainView.replace(chaperonePage)
                                MyResources.playFocusChangedSound()
                            }
                        }
                        NavButton {
                            text: "空间偏移"
                            iconPath: "../../img/main_menu_icons/offsets_tab_icon"
                            isSelected: mainView.currentItem === playspacePage
                            onClicked: {
                                mainView.replace(playspacePage)
                                MyResources.playFocusChangedSound()
                            }
                        }
                        NavButton {
                            text: "运动"
                            iconPath: "../../img/main_menu_icons/motion_tab_icon"
                            isSelected: mainView.currentItem === motionPage
                            onClicked: {
                                mainView.replace(motionPage)
                                MyResources.playFocusChangedSound()
                            }
                        }
                        NavButton {
                            text: "旋转"
                            iconPath: "../../img/main_menu_icons/rotation_tab_icon"
                            isSelected: mainView.currentItem === rotationPage
                            onClicked: {
                                mainView.replace(rotationPage)
                                MyResources.playFocusChangedSound()
                            }
                        }
                        NavButton {
                            text: "空间修复"
                            iconPath: "../../img/main_menu_icons/space_fix_tab_icon"
                            isSelected: mainView.currentItem === fixFloorPage
                            onClicked: {
                                mainView.replace(fixFloorPage)
                                MyResources.playFocusChangedSound()
                            }
                        }
                        NavButton {
                            text: "音频"
                            iconPath: "../../img/main_menu_icons/audio_tab_icon"
                            isSelected: mainView.currentItem === audioPage
                            onClicked: {
                                mainView.replace(audioPage)
                                MyResources.playFocusChangedSound()
                            }
                        }
                        NavButton {
                            text: "视频"
                            iconPath: "../../img/main_menu_icons/video_tab_icon"
                            isSelected: mainView.currentItem === videoPage
                            onClicked: {
                                mainView.replace(videoPage)
                                MyResources.playFocusChangedSound()
                            }
                        }
                        NavButton {
                            text: "工具"
                            iconPath: "../../img/main_menu_icons/utilities_tab_icon"
                            isSelected: mainView.currentItem === utilitiesPage
                            onClicked: {
                                mainView.replace(utilitiesPage)
                                MyResources.playFocusChangedSound()
                            }
                        }
                    }
                }

                Item { Layout.preferredHeight: 12 } // Space before divider
                Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 1; color: "#1D1D1E" }
                Item { Layout.preferredHeight: 12 } // Space after divider

                // Part 4: Bottom Menu Area
                ColumnLayout {
                    id: bottomMenu
                    Layout.fillWidth: true
                    spacing: 2
                    
                    NavButton {
                        text: "按键绑定"
                        iconPath: "../../img/main_menu_icons/bindings_tab_icon"
                        onClicked: {
                            SteamVRTabController.launchBindingUI()
                        }
                    }
                    NavButton {
                        text: "设置"
                        iconPath: "../../img/main_menu_icons/settings_tab_icon"
                        isSelected: mainView.currentItem === settingsPage
                        onClicked: {
                            mainView.replace(settingsPage)
                            MyResources.playFocusChangedSound()
                        }
                    }
                }
            }
        }

        // Right Content Area
        StackView {
            id: mainView
            Layout.fillWidth: true
            Layout.fillHeight: true

            pushEnter: Transition { NumberAnimation { duration: 0 } }
            pushExit: Transition { NumberAnimation { duration: 0 } }
            popEnter: Transition { NumberAnimation { duration: 0 } }
            popExit: Transition { NumberAnimation { duration: 0 } }
            replaceEnter: Transition { NumberAnimation { duration: 0 } }
            replaceExit: Transition { NumberAnimation { duration: 0 } }

            initialItem: summaryPage
        }
    }
}

