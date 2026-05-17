import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 1200
    height: 800
    title: "拼图游戏 - Jigsaw Puzzle Game"

    color: "#f0f0f0"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        // 标题和按钮栏
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            color: "#2c3e50"
            radius: 5

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                Text {
                    text: "拼图游戏"
                    font.pixelSize: 24
                    font.bold: true
                    color: "white"
                }

                Item { Layout.fillWidth: true }

                Button {
                    text: "新游戏"
                    onClicked: puzzleGame.reset()
                }

                Button {
                    text: "简单"
                    onClicked: puzzleGame.startGame(12)
                }

                Button {
                    text: "中等"
                    onClicked: puzzleGame.startGame(24)
                }

                Button {
                    text: "困难"
                    onClicked: puzzleGame.startGame(42)
                }

                Text {
                    text: "已拼好: " + puzzleGame.completedPieces + "/" + puzzleGame.totalPieces
                    font.pixelSize: 16
                    color: "white"
                }
            }
        }

        // 主游戏区域
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            // 左侧：待拼图块区域
            Rectangle {
                Layout.preferredWidth: 280
                Layout.fillHeight: true
                color: "#ecf0f1"
                radius: 5
                border.color: "#bdc3c7"
                border.width: 2

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 5

                    Text {
                        text: "待拼图块"
                        font.pixelSize: 14
                        font.bold: true
                        color: "#2c3e50"
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Flow {
                            id: piecesPool
                            width: parent.width - 20
                            spacing: 8
                        }
                    }
                }
            }

            // 右侧：拼图画布
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "white"
                radius: 5
                border.color: "#95a5a6"
                border.width: 2

                Canvas {
                    id: canvasBackground
                    anchors.fill: parent
                    anchors.margins: 10

                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.fillStyle = "#ecf0f1";
                        ctx.fillRect(0, 0, width, height);

                        // 绘制网格
                        ctx.strokeStyle = "#bdc3c7";
                        ctx.lineWidth = 1;
                        for (var i = 0; i < width; i += 50) {
                            ctx.beginPath();
                            ctx.moveTo(i, 0);
                            ctx.lineTo(i, height);
                            ctx.stroke();
                        }
                        for (var j = 0; j < height; j += 50) {
                            ctx.beginPath();
                            ctx.moveTo(0, j);
                            ctx.lineTo(width, j);
                            ctx.stroke();
                        }
                    }
                }

                PuzzleGame {
                    id: puzzleGame
                    anchors.fill: parent
                    anchors.margins: 10
                }
            }
        }

        // 底部状态栏
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            color: "#34495e"
            radius: 5

            Text {
                anchors.fill: parent
                anchors.leftMargin: 10
                verticalAlignment: Text.AlignVCenter
                text: puzzleGame.gameStatus
                font.pixelSize: 14
                color: "white"
            }
        }
    }

    Component.onCompleted: {
        puzzleGame.startGame(12);
    }
}
