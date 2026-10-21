// CaptainRatax Splash - KDE Plasma 6 session startup theme.
// This is a KSplash/QML theme, not a Plymouth boot theme.
// The same layout is created independently for each display by Plasma.

import QtQuick

Rectangle {
    id: root
    color: "#000000"

    // Set by KSplash as the Plasma session progresses.
    property int stage: 0

    // Theme variant selected at install time.
    readonly property bool useWallpaper: true
    readonly property real scaleFactor: Math.max(0.55, Math.min(width / 1920.0, height / 1080.0))
    function scaled(pixels) { return Math.round(pixels * scaleFactor); }

    Image {
        anchors.fill: parent
        visible: root.useWallpaper
        source: "images/background.jpg"
        fillMode: Image.PreserveAspectCrop
        smooth: true
        asynchronous: true
        cache: true
    }

    // Modest darkening keeps the logo clear without changing the image aspect ratio.
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: root.useWallpaper ? 0.12 : 0
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0

        Column {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -root.scaled(20)
            spacing: root.scaled(24)

            Image {
                id: logo
                anchors.horizontalCenter: parent.horizontalCenter
                width: root.scaled(230)
                height: width
                source: "images/logo.png"
                fillMode: Image.PreserveAspectFit
                smooth: true
                mipmap: true
                asynchronous: true
            }

            Canvas {
                id: spinner
                anchors.horizontalCenter: parent.horizontalCenter
                width: root.scaled(44)
                height: width
                antialiasing: true

                onPaint: {
                    var context = getContext("2d");
                    context.clearRect(0, 0, width, height);
                    var middle = width / 2;
                    var radius = width * 0.37;
                    context.lineWidth = Math.max(3, width * 0.09);
                    context.lineCap = "round";

                    // Quiet track under the rotating green arc.
                    context.strokeStyle = "rgba(255, 255, 255, 0.12)";
                    context.beginPath();
                    context.arc(middle, middle, radius, 0, Math.PI * 2, false);
                    context.stroke();

                    context.strokeStyle = "#35E780";
                    context.beginPath();
                    context.arc(middle, middle, radius, -Math.PI * 0.5, Math.PI * 0.80, false);
                    context.stroke();
                }

                RotationAnimator {
                    target: spinner
                    from: 0
                    to: 360
                    duration: 1100
                    loops: Animation.Infinite
                    running: true
                }
            }
        }
    }

    NumberAnimation {
        id: showAnimation
        target: content
        property: "opacity"
        from: 0
        to: 1
        duration: 450
        easing.type: Easing.OutCubic
    }

    // Leave the logo and spinner visible until KSplash actually exits.
    // Plasma may take another 1-2 seconds after stage 5 to close the window.
    // Fading the content out at stage 5 would leave a blank background.

    // Also show content in KSplash preview/test mode with no stage signals.
    Component.onCompleted: showAnimation.start()
}
