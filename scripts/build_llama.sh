#!/bin/bash

# Update packages
pkg update && pkg upgrade -y

# Install required tools
pkg install -y git cmake clang

# Clone llama.cpp
git clone https://github.com/ggerganov/llama.cpp.git

# Build llama.cpp
cd llama.cpp
make
