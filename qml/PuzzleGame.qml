import QtQuick

Item {
    id: root

    property int totalPieces: 0
    property int completedPieces: 0
    property string gameStatus: "准备开始游戏"
    property var puzzlePieces: []
    property var placedPieces: []
    property real pieceSize: 60

    function startGame(difficulty) {
        // 清空前面的拼图
        reset();
        totalPieces = difficulty;
        completedPieces = 0;
        gameStatus = "游戏已开始，难度：" + (difficulty === 12 ? "简单" : difficulty === 24 ? "中等" : "困难");

        generatePuzzlePieces();
    }

    function reset() {
        // 移除所有拼图块
        for (var i = puzzlePieces.length - 1; i >= 0; i--) {
            puzzlePieces[i].destroy();
        }
        puzzlePieces = [];
        placedPieces = [];
        completedPieces = 0;
        totalPieces = 0;
        gameStatus = "游戏已重置";
    }

    function generatePuzzlePieces() {
        var rows = Math.ceil(Math.sqrt(totalPieces));
        var cols = Math.ceil(totalPieces / rows);
        var pieceWidth = (root.width - 20) / cols;
        var pieceHeight = (root.height - 20) / rows;

        var index = 0;
        for (var row = 0; row < rows && index < totalPieces; row++) {
            for (var col = 0; col < cols && index < totalPieces; col++) {
                var component = Qt.createComponent("PuzzlePiece.qml");
                if (component.status === Component.Ready) {
                    var piece = component.createObject(root, {
                        pieceIndex: index,
                        correctX: col * pieceWidth + 10,
                        correctY: row * pieceHeight + 10,
                        pieceWidth: pieceWidth,
                        pieceHeight: pieceHeight,
                        parent: root
                    });
                    puzzlePieces.push(piece);
                    index++;
                }
            }
        }

        // 随机打乱拼图块位置
        shufflePieces();
    }

    function shufflePieces() {
        for (var i = 0; i < puzzlePieces.length; i++) {
            var piece = puzzlePieces[i];
            piece.x = Math.random() * (root.width - piece.width - 30) + 15;
            piece.y = Math.random() * (root.height - piece.height - 30) + 15;
        }
    }

    function checkPieceAlignment(piece) {
        var tolerance = 15; // 像素偏差容限
        var dx = Math.abs(piece.x - piece.correctX);
        var dy = Math.abs(piece.y - piece.correctY);

        if (dx < tolerance && dy < tolerance) {
            piece.x = piece.correctX;
            piece.y = piece.correctY;
            piece.isPlaced = true;
            completedPieces++;

            if (completedPieces === totalPieces) {
                gameStatus = "恭喜！拼图完成！";
            } else {
                gameStatus = "已拼好 " + completedPieces + " / " + totalPieces + " 块";
            }
            return true;
        }
        return false;
    }
}
