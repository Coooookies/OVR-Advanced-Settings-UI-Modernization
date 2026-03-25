import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.2
import ovras.advsettings 1.0
import "." 
import ".."

Rectangle {
    id: rootContainer
    color: "#111112"

    property StackView stackView
    property string headerText: "Header Title"
    property bool headerShowBackButton: true
    property bool headerVisible: true
    
    property bool isScrollable: true

    property Item content: Item {}

    ColumnLayout {
        id: mainLayout
        anchors.fill: parent
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 32
        anchors.bottomMargin: isScrollable ? 0 : 32
        spacing: 24

        Item {
            id: headerArea
            visible: headerVisible
            Layout.fillWidth: true
            Layout.preferredHeight: 32
            Layout.leftMargin: 32
            Layout.rightMargin: 32
            
            RowLayout {
                anchors.fill: parent
                spacing: 6

                Button {
                    id: headerBackButton
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 32
                    padding: 0
                    
                    visible: (stackView && stackView.depth > 1) && headerShowBackButton
                    hoverEnabled: true

                    contentItem: Image {
                        source: "../../img/common/backarrow.svg"
                        sourceSize.width: 32
                        sourceSize.height: 32
                        fillMode: Image.PreserveAspectFit
                        anchors.fill: parent
                    }
                    
                    background: Rectangle {
                        radius: 8
                        color: headerBackButton.down ? "#1B1B1C" : 
                               (headerBackButton.hovered || headerBackButton.activeFocus) ? "#2B2B2C" : "transparent"
                    }   

                    onClicked: {
                        MyResources.playFocusChangedSound()
                        if (stackView && stackView.depth > 1) {
                            stackView.pop()
                        }
                    }
                }
               
                MyText {
                    id: headerTitle
                    text: headerText
                    font.pixelSize: 20
                    font.family: Style.sansExtraBold
                    color: "#FFFFFF"
                    Layout.alignment: Qt.AlignVCenter
                }
                
                Item {
                    Layout.fillWidth: true
                }
            }
        }

        Item {
            id: contentContainer
            Layout.fillWidth: true
            Layout.fillHeight: true

            ScrollView {
                id: pageScroll
                anchors.fill: parent
                visible: isScrollable
                clip: true
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                
                Column {
                    id: scrollColumnInner
                    width: pageScroll.availableWidth
                    
                    Item {
                        id: contentProxy
                        width: parent.width
                        height: (content && isScrollable) ? content.height : 0
                    }

                    Item {
                        width: 1
                        height: 32
                    }
                }
            }

            Item {
                id: staticWrapper
                anchors.fill: parent
                visible: !isScrollable
                anchors.leftMargin: 32
                anchors.rightMargin: 32
            }
        }
    }

    Component.onCompleted: {
        if (content) {
            if (isScrollable) {
                content.parent = contentProxy
                content.x = 32
                content.width = Qt.binding(function() { return contentProxy.width - 64; })
            } else {
                content.parent = staticWrapper
                content.anchors.fill = staticWrapper
            }
        }
    }
}
