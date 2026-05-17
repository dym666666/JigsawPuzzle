import QtQuick

Rectangle {
    id: piece

    property int pieceIndex: 0
    property real correctX: 0
    property real correctY: 0
    property real pieceWidth: 80
    property real pieceHeight: 80
    property bool isPlaced: false
    property bool isDragging: false

    width: pieceWidth
    height: pieceHeight
    color: "#3498db"
    radius: 4
    border.color: "#2980b9"
    border.width: 2

    // 生成渐变背景
    gradient: Gradient {
        GradientStop { position: 0.0; color: isPlaced ? "#2ecc71" : "#3498db" }
        GradientStop { position: 1.0; color: isPlaced ? "#27ae60" : "#2980b9" }
    }

    // 拼图块的凹凸形状装饰
    Canvas {
        id: shapeCanvas
        anchors.fill: parent
        anchors.margins: 2

        onPaint: {
            var ctx = getContext("2d");
            var w = width;
            var h = height;

            // 清空画布
            ctx.clearRect(0, 0, w, h);

            // 绘制凹凸纹理
            ctx.strokeStyle = "rgba(255, 255, 255, 0.3)";
            ctx.lineWidth = 1;
            ctx.setLineDash([3, 3]);

            // 在边缘绘制锯齿纹
            var tabSize = Math.min(w, h) / 4;

            // 顶部凸起
            if (pieceIndex % 4 !== 0) {
                ctx.beginPath();
                ctx.moveTo(w / 2 - tabSize / 2, 0);
                ctx.bezierCurveTo(w / 2 - tabSize / 4, -tabSize / 2, w / 2 + tabSize / 4, -tabSize / 2, w / 2 + tabSize / 2, 0);
                ctx.stroke();
            }

            // 右侧凹陷
            if (pieceIndex % 3 !== 0) {
                ctx.beginPath();
                ctx.moveTo(w, h / 2 - tabSize / 2);
                ctx.bezierCurveTo(w + tabSize / 2, h / 2 - tabSize / 4, w + tabSize / 2, h / 2 + tabSize / 4, w, h / 2 + tabSize / 2);
                ctx.stroke();
            }

            // 底部凸起
            if (pieceIndex % 5 !== 0) {
                ctx.beginPath();
                ctx.moveTo(w / 2 - tabSize / 2, h);
                ctx.bezierCurveTo(w / 2 - tabSize / 4, h + tabSize / 2, w / 2 + tabSize / 4, h + tabSize / 2, w / 2 + tabSize / 2, h);
                ctx.stroke();
            }

            // 左侧凹陷
            if (pieceIndex % 2 !== 0) {
                ctx.beginPath();
                ctx.moveTo(0, h / 2 - tabSize / 2);
                ctx.bezierCurveTo(-tabSize / 2, h / 2 - tabSize / 4, -tabSize / 2, h / 2 + tabSize / 4, 0, h / 2 + tabSize / 2);
                ctx.stroke();
            }
        }
    }

    // 拼图块编号
    Text {
        anchors.centerIn: parent
        text: pieceIndex + 1
        font.pixelSize: 18
        font.bold: true
        color: "white"
        z: 2
    }

    // 拖拽处理
    MouseArea {
        anchors.fill: parent
        drag.target: isPlaced ? null : piece
        drag.smoothed: true
        hoverEnabled: true

        onPressed: {
            isDragging = true;
            piece.z = 100; // 置于顶层
        }

        onReleased: {
            isDragging = false;
            // 尝试将拼图块对齐到目标位置
            var parent_item = piece.parent;
            if (parent_item && parent_item.checkPieceAlignment) {
                parent_item.checkPieceAlignment(piece);
            }
            if (!isPlaced) {
                piece.z = 1;
            }
        }

        onEntered: {
            if (!isPlaced) {
                piece.scale = 1.1;
            }
        }

        onExited: {
            if (!isPlaced) {
                piece.scale = 1.0;
            }
        }
    }

    // 动画效果
    Behavior on scale {
        NumberAnimation { duration: 150 }
    }

    Behavior on x {
        enabled: isPlaced
        NumberAnimation { duration: 300 }
    }

    Behavior on y {
        enabled: isPlaced
        NumberAnimation { duration: 300 }
    }

    // 放置时的发光效果
    states: [
        State {
            name: "placed"
            when: isPlaced
            PropertyChanges { target: piece; scale: 1.0 }
            PropertyChanges { target: piece; opacity: 1.0 }
        }
    ]
}
