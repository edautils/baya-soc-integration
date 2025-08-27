# baya-soc-integration

A framework for designers to integrate IPs/SubSystems to build System-on-Chip (SoC) using the Baya tool.

This repository provides:
- A place to upload Baya tool releases (`baya_releases/`)
- Example SoC integration projects (`baya-shell/<REL-VER>/examples/`)
- Scripts for automatic installation and setup (`scripts/`)
---

## Getting Started

### 1. Upload or Obtain the Baya Tool Release

- Download the latest Baya tool release from your organization or obtain it from a maintainer.
- Place the release archive (`.zip` or `.tar.gz`) in the `baya_releases/` directory.

### 2. Automatic Installation and Setup

#### For Linux/macOS:
```sh
bash scripts/install.sh
```

#### For Windows:
```
scripts\install.bat
```

- The script will:
  - Check for the Baya tool release in `baya_releases/`.
  - Extract and install Baya.
  - Source environment setup (`setup_env.sh` on Linux/macOS, `setup_env.bat` on Windows, if available).
  - Discover and run examples (see below).

### 3. Example Projects

- Example SoC projects are under `baya-shell/<REL-VER>/examples/`, each in its own folder.
- Each example can contain a run script:
  - `runme.csh` for Linux/macOS (UNIX shell)
  - `runme.bat` for Windows (`cmd`)
- The install scripts will attempt to run the appropriate script for each example, if present.

### 4. Environment Setup

- If your Baya tool includes environment setup scripts:
  - On Linux/macOS: `setup_env.sh` will be sourced automatically.
  - On Windows: `setup_env.bat` will be run if present.
- If no environment script is found, you may need to configure environment variables manually as per Baya tool documentation.

---

## Directory Structure

```
baya_releases/      # Place Baya tool releases here (.zip, .tar.gz, etc.)
demo/               # SoC integration example projects (each with runme.csh and/or runme.bat)
scripts/            # Installation and helper scripts (install.sh, install.bat)
README.md           # This file
```

---

## Contributing

- Add new examples under `demo/` as separate folders.
- Example folders should include either a `runme.csh` (Linux/macOS) or `runme.bat` (Windows) script for automated execution.
- Update this README with a short description of your example if you contribute one.
- If you are a maintainer, upload new Baya releases into `baya_releases/`.

---

## Support
- Please contact : help@edautils.com
- Please open an issue or contact the maintainers if you need help or have suggestions.
