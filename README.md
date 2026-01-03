

# Offline LLM on Android  
### Qwen Chat Model + llama.cpp (Termux)

> A complete and honest engineering log of deploying a chat-tuned Large Language Model fully offline on an Android device, documenting real-world failures, constraints, fixes, and final success.

---

## 🎯 Project Objective

The objective of this project was to evaluate whether a **modern conversational LLM** can be:

- Built from source on an Android phone  
- Executed fully **offline** (no APIs, no internet)  
- Used interactively as a chatbot  
- Customized with a **personal identity and controlled responses**

This repository intentionally documents **all challenges and failures**, as mobile on-device LLM deployment is non-trivial and should not be presented as effortless.

---
---

## 🧩 Features Achieved

- Fully offline LLM inference on Android

- Interactive chat interface

- Custom system identity (Xking’s personal AI assistant)

- Controlled one-sentence responses

- No cloud APIs or internet dependency

- Stable CPU-only runtime
  
---

## ⚠️ Limitations

- Large (7B+) models are unreliable on Android devices

- GGUF files must be handled carefully to avoid corruption

- Performance is limited to CPU execution

- This is a prototype, not a production consumer app

--- 
## 🧪 What This Project Demonstrates

- On-device LLM inference is feasible on consumer Android hardware

- Model selection matters more than parameter count

- Mobile AI engineering requires different trade-offs than desktop/server AI

- Honest documentation improves reproducibility and learning



---

## 📂 Repository Notes

- .gguf model files are not included due to GitHub size limits

- See models/README.md for model download instructions

- This repository focuses on deployment and execution, not model training

--- 

## 📱 Device & Environment Used

### Hardware
- Android smartphone (ARM64)
- Mid-range consumer device
- No dedicated AI accelerator

### Software Environment
- Android OS  
- Termux (Linux environment on Android)  
- Clang compiler (via Termux)  
- CMake build system  

### LLM Runtime
- `llama.cpp` (compiled from source directly on the phone)

---

## 🎬 Demo (Offline, On-Device)

### Quick Preview (Auto-play GIF)

This animation demonstrates the AI responding **fully offline** on an Android device.

![Offline LLM Demo](screenshots/demo.gif)

### Full Demo Video

▶️ [Click to watch the full offline demo](assets/screen-recording-20260103-180722-termux_1FeFZ0Ai.mp4)

*Recorded fully offline on an Android device using Termux, llama.cpp, and the Qwen chat model.*

---

## 🧠 Initial Approach & Problems Faced

### 1. Attempt with Large LLaMA-2 Models (7B)

The project initially used **LLaMA-2-7B base and chat models**.

#### Issues encountered
- Base models echoed prompts instead of responding meaningfully
- Chat models failed to load repeatedly
- Frequent runtime errors:
  - `tensor data is not within file bounds`
  - corrupted or incomplete GGUF files
- Android storage/network caused **silent corruption** of 4–5 GB model files
- Interactive chat mode caused unstable and confusing behavior

**Conclusion:**  
Large 7B models are **impractical on Android phones** due to file size, memory pressure, and fragile downloads.

---

### 2. Hugging Face Download Restrictions

- Direct `wget` downloads returned `401 Unauthorized`
- Hugging Face now enforces authentication for many repositories
- CLI downloads were unreliable on mobile networks

**Resolution**
- Models were downloaded using the **mobile browser**
- Files were manually moved into the project directory

This proved significantly more reliable on Android.

---

### 3. Android-Specific Challenges

- Hidden or inconsistent download paths
- Strict Linux path resolution
- Filename mismatches (`.` vs `_`)
- Executing binaries from incorrect working directories
- Limited RAM and CPU-only inference

These were resolved by:
- Strict directory discipline
- Explicit file size verification
- Simplifying execution commands

---

## ✅ Final Working Solution

### Model Selection (Key Engineering Decision)

The project switched to a **smaller, chat-tuned model** optimized for efficiency:

- **Qwen1.5-1.8B-Chat**
- GGUF format (`Q4_K_M`)
- ~1.1–1.3 GB
- Stable on Android
- Designed for conversational use

This decision made the project viable.


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


---


## 👤 Author

Xking


---

## 📌 Project Status

✔ Prototype completed
✔ Offline inference verified
✔ Stable chat interaction
✔ Custom identity implemented

Future work may include UI integration or migration to a mobile-optimized runtime.

---
