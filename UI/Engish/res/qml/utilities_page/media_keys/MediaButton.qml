import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../../common"

MyPushButton2 {
    id: mediaButton
    onClicked: {
        // Overload this
    }
    property string imagePath: ""

    // Private properties
    Layout.preferredHeight: 48
    Layout.preferredWidth: 48
    contentItem: Image {
        source: parent.imagePath
        sourceSize: Qt.size( imgSP.sourceSize.width*2, imgSP.sourceSize.height*2 )
        Image{
            id: imgSP
            source: parent.source
            sourceSize.width: 32
            sourceSize.height: 32
            anchors.centerIn: parent
        }
    }
}
