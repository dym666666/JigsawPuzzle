import QtQuick

Item {
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

    // 为每个块定义独特的颜色
    property var colorList: [
        "#FF1493", "#FF8C00", "#FF6347", "#FF0000",
        "#FFD700", "#FF69B4", "#DA70D6", "#FFFF00",
        "#FF8C00", "#ADFF2F", "#00CED1", "#87CEEB"
    ]

    property string pieceColor: colorList[pieceIndex % colorList.length]

    // 生成随机的凹凸边类型 (0=平，1=凸，2=凹)
    property var edgeTypes: [
        (pieceIndex % 2 === 0) ? 0 : ((pieceIndex % 3 === 0) ? 1 : 2),  // 上
        (pieceIndex % 3 === 0) ? 0 : ((pieceIndex % 5 === 0) ? 1 : 2),  // 右
        (pieceIndex % 4 === 0) ? 0 : ((pieceIndex % 7 === 0) ? 1 : 2),  // 下
        (pieceIndex % 5 === 0) ? 0 : ((pieceIndex % 2 === 0) ? 1 : 2)   // 左
    ]

    // 用 Canvas 绘制拼图块的形状
    Canvas {
        id: shapeCanvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            var w = width;
            var h = height;
            var tabRadius = 16;  // 凹凸圆形的半径
            var tabDepth = 10;   // 凹凸的深度

            // 清空
            ctx.clearRect(0, 0, w, h);

            // 开始绘制路径
            ctx.beginPath();
            ctx.moveTo(0, 0);

            // 上边
            if (edgeTypes[0] === 0) {
                // 平边
                ctx.lineTo(w, 0);
            } else if (edgeTypes[0] === 1) {
                // 凸起（圆形突出）
                ctx.lineTo(w / 2 - tabRadius, 0);
                ctx.arcTo(w / 2, -tabDepth, w / 2 + tabRadius, 0, tabRadius);
                ctx.lineTo(w, 0);
            } else {
                // 凹陷（圆形凹入）
                ctx.lineTo(w / 2 - tabRadius, 0);
                ctx.arcTo(w / 2, tabDepth, w / 2 + tabRadius, 0, tabRadius);
                ctx.lineTo(w, 0);
            }

            // 右边
            if (edgeTypes[1] === 0) {
                // 平边
                ctx.lineTo(w, h);
            } else if (edgeTypes[1] === 1) {
                // 凸起
                ctx.lineTo(w, h / 2 - tabRadius);
                ctx.arcTo(w + tabDepth, h / 2, w, h / 2 + tabRadius, tabRadius);
                ctx.lineTo(w, h);
            } else {
                // 凹陷
                ctx.lineTo(w, h / 2 - tabRadius);
                ctx.arcTo(w - tabDepth, h / 2, w, h / 2 + tabRadius, tabRadius);
                ctx.lineTo(w, h);
            }

            // 下边
            if (edgeTypes[2] === 0) {
                // 平边
                ctx.lineTo(0, h);
            } else if (edgeTypes[2] === 1) {
                // 凸起
                ctx.lineTo(w / 2 + tabRadius, h);
                ctx.arcTo(w / 2, h + tabDepth, w / 2 - tabRadius, h, tabRadius);
                ctx.lineTo(0, h);
            } else {
                // 凹陷
                ctx.lineTo(w / 2 + tabRadius, h);
                ctx.arcTo(w / 2, h - tabDepth, w / 2 - tabRadius, h, tabRadius);
                ctx.lineTo(0, h);
            }

            // 左边
            if (edgeTypes[3] === 0) {
                // 平边
                ctx.lineTo(0, 0);
            } else if (edgeTypes[3] === 1) {
                // 凸起
                ctx.lineTo(0, h / 2 + tabRadius);
                ctx.arcTo(-tabDepth, h / 2, 0, h / 2 - tabRadius, tabRadius);
                ctx.lineTo(0, 0);
            } else {
                // 凹陷
                ctx.lineTo(0, h / 2 + tabRadius);
                ctx.arcTo(tabDepth, h / 2, 0, h / 2 - tabRadius, tabRadius);
                ctx.lineTo(0, 0);
            }

            ctx.closePath();

            // 填充颜色
            ctx.fillStyle = pieceColor;
            ctx.fill();

            // 白色描边
            ctx.strokeStyle = "#FFFFFF";
            ctx.lineWidth = 3;
            ctx.stroke();
        }
    }

    // 拖拽处理
    MouseArea {
        anchors.fill: parent
        drag.target: isPlaced ? null : piece
        drag.smoothed: true
        hoverEnabled: true

        onPressed: {
            isDragging = true;
            piece.z = 100;
        }

        onReleased: {
            isDragging = false;
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

    // 已放置时的效果
    states: [
        State {
            name: "placed"
            when: isPlaced
            PropertyChanges { target: piece; scale: 1.0 }
            PropertyChanges { target: piece; opacity: 1.0 }
        }
    ]
}
