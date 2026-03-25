import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "." 
import "common"

MyStackViewPage {
    id: summaryPage
    headerText: "首页"
    headerShowBackButton: false
    headerVisible: false
    isScrollable: false
    
    content: Item {
        ColumnLayout {
            anchors.centerIn: parent
            spacing: 10
            
            Image {
                source: "../img/common/home_logo.svg"
                Layout.preferredWidth: 202
                Layout.preferredHeight: 162
                Layout.alignment: Qt.AlignHCenter
                fillMode: Image.PreserveAspectFit
                smooth: true
            }

            Rectangle {
                id: summaryVersionCheckTextRect
                visible: summaryVersionCheckText.text !== ""
                color: "#E7A150"
                radius: 8
                
                Layout.preferredWidth: summaryVersionCheckText.contentWidth + 96
                Layout.preferredHeight: 16 * 1.5 + 28
                Layout.alignment: Qt.AlignHCenter

                MyText {
                    id: summaryVersionCheckText
                    anchors.centerIn: parent
                    text: OverlayController.versionCheckText
                    font.pixelSize: 16
                    color: "#FFFFFF"
                    font.family: Style.sansMedium
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            MyText {
                id: summaryVersionText
                text: applicationVersion
                font.pixelSize: 14
                color: "#414141"
                font.family: Style.sansRegular
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    Connections {
        target: OverlayController
        onVersionCheckTextChanged: {
            summaryVersionCheckText.text = OverlayController.versionCheckText
        }
    }
}

