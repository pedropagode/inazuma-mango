# Inazuma's Mango

Macro for **Anime Vanguards** on Roblox. Automates Cid Raid (Pain Strat) and Spring LTM runs with auto-rejoin, Discord notifications, and visual detection via template matching.

**Current version:** `1.1.21`

---

## 💬 Community

Questions, support, updates, and license activation — everything happens on our Discord server.

[![Discord](https://img.shields.io/badge/Join%20Discord-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/QsxH3mHhjr)

> Join at: [discord.gg/QsxH3mHhjr](https://discord.gg/QsxH3mHhjr)

---

## Requirements

- Windows 10 or 11
- Roblox installed
- Active license (HWID authorized by the admin)
- Internet connection (license validation on startup)

---

## Installation

1. Download the `.zip` file from the **Releases** tab of the repository
2. Extract all files to a folder of your choice
3. Make sure the final folder structure looks like this:

```
folder/
├── InazumaMango.exe
├── Images/
├── tesseract/
├── config.json
├── get_hwid.bat
└── get_hwid.py
```

> **Important:** the `.exe` must be in the same folder as `Images/` and `tesseract/`. Do not move only the executable.

---

## First Use — License Activation

The macro uses **HWID** (unique hardware identifier) validation. Before using it for the first time:

1. Run `get_hwid.bat`
2. Copy the code displayed in the window
3. Send the code to the admin to activate your access
4. After activation, open `InazumaMango.exe` normally — no need to download anything new

---

## Configuration

Open `InazumaMango.exe`. Fill in the fields in the interface:

| Field | Description |
|---|---|
| **Private Server** | Code or link of the AV private server |
| **Webhook URL** | Discord webhook URL for run notifications (optional) |
| **Run Timeout** | Maximum time per run in seconds before considering a softlock (default: 90s) |
| **Auto-Rejoin** | Number of runs before automatically restarting Roblox to prevent FPS leak (default: 300) |
| **VC Chat** | Enable if you are using Roblox voice chat (adjusts chat coordinates) |
| **Strategy** | Choose between **Pain Strat** (default) or **Spring LTM** |
| **Gems / Flowers** | Current currency amount — used to calculate total earned in the session |

Settings are automatically saved to `config.json` next to the `.exe`.

---

## Strategies

### Pain Strat (default)
- Mode: **Cid Raid — Ruined City Act 2**
- Units: Pain, Ainz, Minato, Nami, Naruto
- Automatically detects Kurama Mode and adjusts positioning
- Tracked currency: **Gems** (+150 per win)

### Spring LTM
- Mode: **Spring LTM**
- Automatically selects Endless mode after the lobby
- Tracked currency: **Flowers** (+5400 per win/restart)

---

## Roblox Window Resolution

The macro is calibrated for the Roblox window at **800 × 600**. The automatic alignment positions the window at this resolution when entering the game. Do not manually resize the window during execution.

---

## Discord Notifications (Webhook)

When a Webhook URL is configured, the macro automatically sends:
- A summary for each run (win/loss, time, accumulated gems)
- Auto-rejoin notification

To create a webhook: **Discord → Channel → Settings → Integrations → Webhooks → New Webhook → Copy URL**.

---

## Auto-Update

When the macro opens, it automatically checks for a newer version. If one is available, an update button appears in the interface — click it to download and replace the `.exe` automatically.

---

## Troubleshooting

**The macro won't open / freezes during validation**
- Check your internet connection
- Confirm that your HWID has been authorized by the admin

**Images not detected / macro clicks in the wrong place**
- Confirm that the `Images/` folder is next to the `.exe`
- Make sure Roblox is at **800 × 600** and in the correct position (use the GUI's automatic alignment)
- Do not use DPI scaling other than 100% in Windows

**The macro got stuck (softlock)**
- The softlock watchdog automatically restarts stuck runs after the configured timeout

**Error logs**
- Crashes are saved in `crash/` next to the `.exe`
- Enable **Save Log** in the interface to record the full session log

---

## Release Files

| File | Description |
|---|---|
| `InazumaMango.exe` | Main executable |
| `Images/` | Template matching images (must be next to the exe) |
| `tesseract/` | OCR for wave number detection (Spring LTM) |
| `config.json` | Settings — automatically edited by the GUI |
| `get_hwid.bat` | Utility to obtain your HWID |
| `get_hwid.py` | Script invoked by `get_hwid.bat` |