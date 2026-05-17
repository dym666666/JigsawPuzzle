# 拼图游戏 - Jigsaw Puzzle Game

基于 Qt Quick 框架开发的交互式拼图游戏，具有真实的凹凸拼图块和拖拽功能。

## 功能特性

✨ **核心功能：**
- 🧩 真实的凹凸拼图块形状
- 🖱️ 流畅的拖拽交互
- 🎯 自动对齐和碰撞检测
- 🎮 三个难度级别（简单/中等/困难）
- 🎨 现代化的 UI 设计
- 📊 实时进度显示

## 项目结构

```
JigsawPuzzle/
├── JigsawPuzzle.pro          # Qt 项目文件
├── src/
│   └── main.cpp              # C++ 入口程序
├── qml/
│   ├── main.qml              # 主应用界面
│   ├── PuzzleGame.qml        # 游戏逻辑控制
│   ├── PuzzlePiece.qml       # 拼图块组件
│   └── qml.qrc               # 资源文件
└── README.md                 # 本文件
```

## 安装和运行

### 前置条件
- Qt 6.0 或更高版本
- Qt Creator IDE
- C++17 编译器

### 步骤

1. **克隆仓库**
   ```bash
   git clone https://github.com/dym666666/JigsawPuzzle-.git
   cd JigsawPuzzle-
   ```

2. **在 Qt Creator 中打开项目**
   - 打开 Qt Creator
   - File → Open File or Project
   - 选择 `JigsawPuzzle.pro`

3. **构建和运行**
   - 点击 "Build" 按钮 (Ctrl+B)
   - 点击 "Run" 按钮 (Ctrl+R)

## 游戏说明

### 基本操作

1. **选择难度**
   - 点击「简单」、「中等」或「困难」按钮开始游戏
   - 简单: 12 块拼图
   - 中等: 24 块拼图
   - 困难: 42 块拼图

2. **拖拽拼图块**
   - 用鼠标拖动左侧待拼图块区域中的拼图块
   - 将拼图块放到正确位置
   - 块会自动对齐到目标位置（在容差范围内）

3. **游戏进度**
   - 右上角显示已拼好的块数
   - 底部状态栏显示实时游戏状态
   - 拼完所有块后会显示完成信息

4. **重新开始**
   - 点击「新游戏」按钮重置当前游戏

### 拼图块设计

- 每块拼图具有独特的凹凸形状
- 块的编号显示在中央
- 已正确拼合的块会变成绿色
- 块在被拖动时会放大 1.1 倍

## 技术细节

### Qt Quick 组件
- **ApplicationWindow**: 主应用窗口
- **Canvas**: 绘制拼图块的凹凸形状
- **MouseArea**: 处理拖拽交互
- **Flow**: 布局待拼图块
- **Behavior**: 动画过渡效果

### 核心算法

#### 拼图块生成
```javascript
// 根据难度计算行列数
var rows = Math.ceil(Math.sqrt(totalPieces));
var cols = Math.ceil(totalPieces / rows);
```

#### 位置对齐检测
```javascript
// 使用容差值检测是否对齐
var tolerance = 15; // 像素
if (dx < tolerance && dy < tolerance) {
    // 对齐成功
}
```

## 自定义选项

### 修改难度
在 `PuzzleGame.qml` 中修改 `startGame()` 函数的参数：
```javascript
function startGame(difficulty) {
    totalPieces = difficulty; // 修改这里
}
```

### 修改对齐容差
在 `PuzzleGame.qml` 中调整 `tolerance` 值：
```javascript
var tolerance = 15; // 增大值使对齐更容易
```

### 修改拼图块大小
在 `PuzzlePiece.qml` 中修改 `pieceWidth` 和 `pieceHeight`：
```javascript
property real pieceWidth: 80
property real pieceHeight: 80
```

## 未来改进

- [ ] 添加背景图片支持
- [ ] 实现计时功能和排行榜
- [ ] 添加游戏音效
- [ ] 支持键盘快捷键
- [ ] 添加网络多人模式
- [ ] 自定义拼图图片导入

## 许可证

MIT License

## 作者

dym666666

## 联系方式

如有问题或建议，欢迎提交 Issue 或 Pull Request！
