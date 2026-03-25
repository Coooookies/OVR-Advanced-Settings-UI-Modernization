import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../common"
import "space_drag"
import "height_toggle"
import "gravity"

MyStackViewPage {
    headerText: "运动设置"

    content: ColumnLayout {
        spacing: 16

        SpaceDragGroupBox { id: spaceDragGroupBox }

        HeightToggleGroupBox { id: heightToggleGroupBox }

        GravityGroupBox { id: gravityGroupBox }
    }
}
