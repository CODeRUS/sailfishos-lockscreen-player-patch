import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.configuration 1.0

Page {
    id: page

    property var serviceList: ["org.mpris.MediaPlayer2.jolla-mediaplayer",
                               "org.mpris.MediaPlayer2.quasarmx",
                               "org.mpris.MediaPlayer2.sirensong",
                               "org.mpris.MediaPlayer2.daedalus"]

    Component.onCompleted: {
        mediaCombo._updating = false
        var index = serviceList.indexOf(mazeLockSettings.value)
        if (index >= 0) {
            mediaCombo.currentIndex = index
        }
        else {
            mediaCombo.currentIndex = serviceList.length
        }
    }

    ConfigurationValue {
        id: mazeLockSettings
        key: "/desktop/lipstick-jolla-home/mprisService"
        defaultValue: "org.mpris.MediaPlayer2.jolla-mediaplayer"
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: content.height
        interactive: contentHeight > height

        Column {
            width: parent.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: "Lockscreen player controls"
            }

            ComboBox {
                id: mediaCombo
                width: parent.width
                label: "Active media player"

                menu: ContextMenu {
                    MenuItem { text: "Jolla Mediaplayer" }
                    MenuItem { text: "QuasarMX" }
                    MenuItem { text: "SirenSong" }
                    MenuItem { text: "Daedalus" }
                    MenuItem { text: "Custom" }
                }

                onCurrentIndexChanged: {
                    if (currentIndex < page.serviceList.length) {
                        mazeLockSettings.value = page.serviceList[currentIndex]
                    }
                }
            }

            TextField {
                width: parent.width
                text: mazeLockSettings.value
                visible: mediaCombo.currentIndex == page.serviceList.length
                inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText
                onTextChanged: mazeLockSettings.value = text
            }
        }
    }
}
