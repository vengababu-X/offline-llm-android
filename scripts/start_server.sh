#!/bin/bash

# Start local LLaMA server on phone
./llama.cpp/server \
  -m models/llama-7b-q4.gguf \
  --host 127.0.0.1 \
  --port 8080
