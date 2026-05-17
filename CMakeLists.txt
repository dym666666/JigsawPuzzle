cmake_minimum_required(VERSION 3.21)

project(JigsawPuzzle LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 COMPONENTS Core Gui Quick REQUIRED)

add_executable(JigsawPuzzle
    src/main.cpp
    qml/qml.qrc
)

target_link_libraries(JigsawPuzzle
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
)
