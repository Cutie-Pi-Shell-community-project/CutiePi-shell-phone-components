import QtQuick 2.12
import QtGraphicalEffects 1.0
import QtWayland.Compositor 1.14

Rectangle {
    anchors.fill: parent
    opacity: 0
    color: "transparent"
    enabled: root.state == "notificationScreen"

    FastBlur {
        anchors.fill: parent
        source: realWallpaper
        radius: 70
    }

    ListView {
        id: notificationList
        model: notifications
        orientation: ListView.Vertical
        anchors.fill: parent
        anchors.topMargin: 30 * shellScaleFactor

        header: Item {
            height: notificationHeader.height + descriptionText.height * 3
            Text {
                id: notificationHeader
                text: qsTr("Notifications")
                anchors.top: parent.top
                anchors.topMargin: height / 2
                anchors.left: parent.left
                anchors.leftMargin: 20 * shellScaleFactor
                anchors.right: parent.right
                anchors.rightMargin: 20 * shellScaleFactor
                font.pixelSize: 34 * shellScaleFactor
                font.family: "Lato"
                font.weight: Font.Bold
                horizontalAlignment: Text.AlignLeft
                state: atmosphereVariant
                states: [
                    State {
                        name: "dark"
                        PropertyChanges { target: notificationHeader; color: "#ffffff" }
                    },
                    State {
                        name: "light"
                        PropertyChanges { target: notificationHeader; color: "#000000" }
                    }
                ]
                transitions: Transition {
                    ColorAnimation { properties: "color"; duration: 500; easing.type: Easing.InOutQuad }
                }
            }

            Text {
                id: descriptionText
                text: Qt.formatDateTime(new Date(), "dddd, MMMM d")
                anchors.top: notificationHeader.bottom
                anchors.topMargin: height / 2
                anchors.left: parent.left
                anchors.leftMargin: 20 * shellScaleFactor
                anchors.rightMargin: 20 * shellScaleFactor
                font.pixelSize: 15 * shellScaleFactor
                font.family: "Lato"
                font.weight: Font.Normal
                horizontalAlignment: Text.AlignLeft
                state: atmosphereVariant
                states: [
                    State {
                        name: "dark"
                        PropertyChanges { target: descriptionText; color: "#ffffff" }
                    },
                    State {
                        name: "light"
                        PropertyChanges { target: descriptionText; color: "#000000" }
                    }
                ]
                transitions: Transition {
                    ColorAnimation { properties: "color"; duration: 500; easing.type: Easing.InOutQuad }
                }
            }

            Timer {
                interval: 100; running: true; repeat: true;
                onTriggered: timeChanged()
            }

            function timeChanged() {
                descriptionText.text = Qt.formatDateTime(new Date(), "dddd, MMMM d");
            }
        }

        delegate: Item {
            width: notificationList.width
            height: titleText.height + bodyText.height + 40 * shellScaleFactor * (1 - Math.abs(x/width))
            opacity: 1 - Math.abs(x/width)

            Rectangle {
                color: (atmosphereVariant == "dark") ? "#2fffffff" : "#4f000000"
                radius: 10 * shellScaleFactor
                anchors.fill: parent
                anchors.topMargin: 10 * shellScaleFactor
                anchors.leftMargin: 15 * shellScaleFactor
                anchors.rightMargin: 15 * shellScaleFactor
            }

            MouseArea {
                anchors.fill: parent

                drag.target: parent
                drag.axis: Drag.XAxis

                onReleased: {
                    if (parent.x < - parent.width / 2 || parent.x > parent.width / 2) {
                        notifications.remove(index)
                    }
                    parent.x = 0
                }
            }

            Text {
                id: titleText
                text: title
                anchors.left: parent.left
                anchors.leftMargin: 25 * shellScaleFactor
                anchors.right: parent.right
                anchors.rightMargin: 25 * shellScaleFactor
                anchors.top: parent.top
                anchors.topMargin: 20 * shellScaleFactor * (1 - Math.abs(parent.x/parent.width))
                font.pixelSize: 14 * shellScaleFactor * (1 - Math.abs(parent.x/parent.width))
                font.family: "Lato"
                font.weight: Font.Black
                wrapMode: Text.Wrap
                state: atmosphereVariant
                states: [
                    State {
                        name: "dark"
                        PropertyChanges { target: titleText; color: "#ffffff" }
                    },
                    State {
                        name: "light"
                        PropertyChanges { target: titleText; color: "#000000" }
                    }
                ]
                transitions: Transition {
                    ColorAnimation { properties: "color"; duration: 500; easing.type: Easing.InOutQuad }
                }
            }

            Text {
                id: bodyText
                text: body
                anchors.left: parent.left
                anchors.leftMargin: 25 * shellScaleFactor
                anchors.right: parent.right
                anchors.rightMargin: 25 * shellScaleFactor
                anchors.top: titleText.bottom
                anchors.topMargin: 10 * shellScaleFactor * (1 - Math.abs(parent.x/parent.width))
                font.pixelSize: 14 * shellScaleFactor * (1 - Math.abs(parent.x/parent.width))
                font.family: "Lato"
                font.bold: false
                wrapMode: Text.Wrap
                state: atmosphereVariant
                states: [
                    State {
                        name: "dark"
                        PropertyChanges { target: bodyText; color: "#ffffff" }
                    },
                    State {
                        name: "light"
                        PropertyChanges { target: bodyText; color: "#000000" }
                    }
                ]
                transitions: Transition {
                    ColorAnimation { properties: "color"; duration: 500; easing.type: Easing.InOutQuad }
                }
            }
        }
    }
}