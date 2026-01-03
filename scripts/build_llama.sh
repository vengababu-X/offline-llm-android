#!/bin/bash

# Update packages
pkg update && pkg upgrade -y

# Install required tools
pkg install -y git cmake clang

# Clone llama.cpp
git clone https://github.com/ggml-org/llama.cpp.git

# Build using CMake
cd llama.cpp
mkdir build
cd build
cmake ..
cmake --build . --config Release
