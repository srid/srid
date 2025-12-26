---
slug: whisper
---

# OpenAI Whisper

[GitHub Repository](https://github.com/openai/whisper)

## Subtitle creation

To transcribe a video file into an SRT subtitle file using the **medium** model:

```bash
nix run nixpkgs#openai-whisper -- input.mp4 --model medium --output_format srt
```

### High accuracy (Large models)

On a 64GB MacBook Pro M1, you can use the largest models for maximum accuracy. `large-v3` is the most accurate, while `turbo` offers a similar accuracy at much higher speeds.

**Large V3:**
```bash
nix run nixpkgs#openai-whisper -- input.mp4 --model large-v3 --output_format srt
```

**Turbo:**
```bash
nix run nixpkgs#openai-whisper -- input.mp4 --model turbo --output_format srt
```

*Available models: `tiny`, `base`, `small`, `medium`, `large`, `large-v1`, `large-v2`, `large-v3`, `turbo`.*
