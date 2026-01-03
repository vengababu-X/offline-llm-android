# Offline LLM on Android  
### Qwen Chat Model + llama.cpp (Termux)

> A complete, honest documentation of deploying a chat-tuned Large Language Model fully offline on an Android device, including all real-world issues, failures, fixes, and final success.

---

## 🎯 Project Objective

The goal of this project was to determine whether a **modern conversational LLM** can be:

- Built from source on an Android phone  
- Executed fully **offline** (no APIs, no internet)  
- Used interactively like a chatbot  
- Customized with a **personal identity and controlled responses**

This repository intentionally documents **everything that went wrong**, because mobile on-device LLM deployment is not trivial and should not be presented as such.

---

## 📱 Device & Environment Used

**Device**
- Android smartphone (ARM64)
- Mid-range consumer hardware (no special AI accelerator)

**Software Environment**
- Android OS
- Termux (Linux environment on Android)
- Clang compiler (via Termux)
- CMake build system

**LLM Runtime**
- `llama.cpp` (compiled from source on the phone)

---

## 🎬 Demo (Offline, On-Device)

### Quick Preview (Auto-play)
> This GIF shows the AI responding **fully offline** on an Android device.

![Offline LLM Demo](screenshots/demo.gif)

### Full Demo Video
▶️ Click here to watch the full demo video:  
**(GitHub will host the uploaded `.mp4` automatically)**

---

## 🧠 Initial Approach & Problems Faced

### 1. Attempt with Large LLaMA-2 Models (7B)

The project initially started with **LLaMA-2-7B base and chat models**.

#### Issues encountered:
- Base models echoed prompts instead of answering
- Chat models frequently failed to load
- Repeated errors such as:
  - `tensor data is not within file bounds`
  - corrupted or incomplete GGUF files
- Android storage/network caused **silent corruption** of 4–5 GB model files
- Interactive chat mode caused confusion and unstable behavior

**Conclusion:**  
7B models are **impractical on Android phones** due to file size, memory pressure, and fragile downloads.

---

### 2. Hugging Face Download Restrictions

- Direct `wget` downloads returned `401 Unauthorized`
- Hugging Face now requires authentication for many repositories
- CLI downloads were unreliable on mobile networks

**Resolution:**
- Models were downloaded via **mobile browser**
- Files were manually moved into the project directory

This approach proved far more reliable on Android.

---

### 3. Android-Specific Challenges

- Hidden download directories
- Strict Linux path requirements
- Filename mismatches (`.` vs `_`)
- Running binaries from incorrect working directories
- Limited RAM and CPU-only inference

All issues were resolved through:
- Careful directory management
- Explicit verification of file sizes
- Simplifying the execution workflow

---

## ✅ Final Working Solution

### Model Selection (Key Decision)

Instead of forcing large models, the project switched to a **smaller, chat-tuned model** designed for efficiency:

- **Qwen1.5-1.8B-Chat**
- GGUF format (Q4_K_M)
- ~1.1–1.3 GB
- Stable on Android
- Designed for conversational tasks

This single decision made the project viable.

---

## ▶️ Final Execution Command

```bash
./llama.cpp/build/bin/llama-cli \
  -m models/qwen1_5-1_8b-chat-q4_k_m.gguf \
  --chat-template chatml \
  -t 0.3 \
  -p "<|system|>
You are Xking’s personal AI assistant.
When asked who you are or who built you, reply in ONE short sentence only.
<|end|>"
