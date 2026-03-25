pragma Singleton
import QtQuick 2.7

QtObject {
    // Font Loaders for all available weights using qrc references
    property FontLoader fontLoaderLight:    FontLoader { source: "../../font/RedHatDisplay-Light.ttf" }
    property FontLoader fontLoaderRegular:  FontLoader { source: "../../font/RedHatDisplay-Regular.ttf" }
    property FontLoader fontLoaderMedium:   FontLoader { source: "../../font/RedHatDisplay-Medium.ttf" }
    property FontLoader fontLoaderSemiBold: FontLoader { source: "../../font/RedHatDisplay-SemiBold.ttf" }
    property FontLoader fontLoaderBold:     FontLoader { source: "../../font/RedHatDisplay-Bold.ttf" }
    property FontLoader fontLoaderExtraBold:FontLoader { source: "../../font/RedHatDisplay-ExtraBold.ttf" }
    property FontLoader fontLoaderBlack:    FontLoader { source: "../../font/RedHatDisplay-Black.ttf" }

    // Family names for each weight (derived from the font loader name property)
    readonly property string sansLight:     fontLoaderLight.name + ", 'Segoe UI', 'Microsoft YaHei', 'Noto Sans SC'"
    readonly property string sansRegular:   fontLoaderRegular.name + ", 'Segoe UI', 'Microsoft YaHei', 'Noto Sans SC'"
    readonly property string sansMedium:    fontLoaderMedium.name + ", 'Segoe UI', 'Microsoft YaHei', 'Noto Sans SC'"
    readonly property string sansSemiBold:  fontLoaderSemiBold.name + ", 'Segoe UI', 'Microsoft YaHei', 'Noto Sans SC'"
    readonly property string sansBold:      fontLoaderBold.name + ", 'Segoe UI', 'Microsoft YaHei', 'Noto Sans SC'"
    readonly property string sansExtraBold: fontLoaderExtraBold.name + ", 'Segoe UI', 'Microsoft YaHei', 'Noto Sans SC'"
    readonly property string sansBlack:     fontLoaderBlack.name + ", 'Segoe UI', 'Microsoft YaHei', 'Noto Sans SC'"

    // Main shortcut (uses Regular as default)
    readonly property string sansFont: sansRegular
}
