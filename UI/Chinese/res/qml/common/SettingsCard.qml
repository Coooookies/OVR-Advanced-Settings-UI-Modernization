import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import "."

Item {
    id: root
    
    property int topPadding: 20
    property int bottomPadding: 20
    property int leftPadding: 20
    property int rightPadding: 20
    
    default property alias contentData: innerContainer.data
    
    property color backgroundColor: "#141415"
    property int cardRadius: 12
    
    property string title: ""
    property color titleColor: "#EEEEEE"
    property int titleSize: 16
    
    property string description: ""
    
    Layout.fillWidth: true
    implicitHeight: mainLayout.implicitHeight + topPadding + bottomPadding
    
    Rectangle {
        anchors.fill: parent
        color: root.backgroundColor
        radius: root.cardRadius
        border.color: "#1D1D1E"
        border.width: 1
    }
    
    ColumnLayout {
        id: mainLayout
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: root.topPadding
        anchors.leftMargin: root.leftPadding
        anchors.rightMargin: root.rightPadding
        anchors.bottomMargin: root.bottomPadding
        spacing: 16

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 6
            visible: root.title !== "" || root.description !== ""

            MyText {
                text: root.title
                font.pixelSize: root.titleSize
                font.family: Style.sansExtraBold
                color: root.titleColor
                visible: root.title !== ""
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
            }
            
            MyText {
                text: root.description
                font.pixelSize: 14
                font.family: Style.sansMedium
                color: "#9A9A9A"
                visible: root.description !== ""
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            id: innerContainer
            Layout.fillWidth: true
            spacing: 14
        }
    }
}
