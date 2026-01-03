#!/bin/bash

# Run a single prompt using a local model
./llama.cpp/main \
  -m models/llama-7b-q4.gguf \
  -p "$1"
