import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../common"
import "redirected"
import "space_turn"
import "snap_turn"
import "view_ratchet"


MyStackViewPage {
    headerText: "旋转设置"
    content: ColumnLayout {
        spacing: 16
        AutoTurnGroupBox{
            id: autoTurnGroupBox
        }

        RedirectedGroupBox{
            id: redirectedGroupBox
        }
        ViewRatchetGroupBox{
            id: vgiiewRatchetGroupBox
        }
        SpaceTurnGroupBox{
            id:spaceTurnGroupBox
        }

        SnapTurnGroupBox{
            id: snapTurnGroupBox
        }
    }
}
