# Inazuma's Mango

Macro for **Anime Vanguards** on Roblox. Automates Cid Strat (20 Sec) and Spring LTM runs with auto-rejoin, Discord notifications, auto RAM trim, and visual detection via template matching.

**Current version:** `2.0.7`

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
├── fonts/
├── config.json
├── get_hwid.bat
└── get_hwid.py
```

> **Important:** the `.exe` must be in the same folder as `Images/`, `tesseract/`, and `fonts/`. Do not move only the executable.

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
| **Strategy** | Choose between **Cid Strat (20 Sec)** (default) or **Spring LTM** |
| **Private Server** | Code or link of the AV private server |
| **Webhook URL** | Discord webhook URL for run notifications (optional) |
| **Rejoin after** | Number of runs before automatically reconnecting to the private server. Set to `0` to disable |
| **Pain Interval** | *(Cid Strat only)* Seconds into the run before Pain placement triggers. Range: 7.5 – 9.5 s. Default: 8.5 s |
| **Camera Rotation** | *(Spring LTM only)* Duration of the camera right-hold during post-spawn positioning. Range: 0.50 – 1.00 s. Default: 1.00 s |
| **VC Chat** | Enable if you are using Roblox voice chat (adjusts chat detection coordinates) |
| **Gems / Flowers** | Current currency amount — used to calculate total earned in the session |
| **CD (RAM Trim)** | Auto RAM trim interval in minutes. Range: 2 – 15 min. Default: 6 min |

> **Tip:** hover over any field or label in the interface to read a full description of what it does.

Settings are automatically saved to `config.json` next to the `.exe`.

---

## Strategies

### Cid Strat — 20 Sec (default)
- Mode: **Cid Raid — Ruined City Act 2**
- Units: Pain, Ainz, Minato, Nami, Naruto
- Automatically detects Kurama Mode and adjusts positioning
- Configurable **Pain Interval** (7.5 – 9.5 s)
- Side panel shows **team composition + recommended settings**
- Tracked currency: **Gems** (+150 per win)
- Run timeout: **35 s** (fixed)

### Spring LTM
- Mode: **Spring LTM**
- Automatically selects Endless mode after the lobby
- Configurable **Camera Rotation** duration (0.50 – 1.00 s) — useful on RDP/remote desktop
- Side panel shows **recommended settings** (no team composition)
- Tracked currency: **Flowers** (+5,400 per win/restart)
- Run timeout: disabled (no softlock watchdog for this mode)

---

## View Team + Settings Panel

Each strategy has a side panel that opens next to the main window:

- **Cid Strat:** shows `gameplay_settings.png`, `team.png`, and `roblox_settings.png`
- **Spring LTM:** shows `gameplay_settings.png`, `loadout.png`, and `roblox_settings.png`

Click any image in the panel to zoom in. Click again to return to the overview.

---

## Roblox Window Resolution

The macro is calibrated for the Roblox window at **800 × 600**. The automatic alignment (button **Align F4**) positions the window at this resolution when entering the game. Do not manually resize the Roblox window during execution.

---

## Discord Notifications (Webhook)

When a Webhook URL is configured, the macro automatically sends:
- A summary for each run (win/loss, time, accumulated currency)
- Auto-rejoin notifications

To create a webhook: **Discord → Channel Settings → Integrations → Webhooks → New Webhook → Copy URL**.

---

## Auto RAM Trim

The macro automatically calls `EmptyWorkingSet` on all Roblox processes at a configurable interval (default: every 6 minutes). This releases unused memory pages back to the OS, preventing FPS drops and softlocks caused by Roblox's known memory leak during long sessions (4–6 h+).

- **Saved** — total MB freed since the GUI opened (shown in the bottom bar)
- **CD N Min** — trim interval, adjustable from 2 to 15 minutes
- Runs automatically in the background; skipped during rejoin and when Roblox is not running

---

## Auto-Update

When the macro opens, it automatically checks for a newer version. If one is available, the **Check for Updates** button turns green — click it to download and replace the `.exe` automatically.

> Requires **AutoHotkey v2** to be installed for the update process.

---

## Keyboard Shortcuts

| Key | Action |
|---|---|
| `F1` | Start |
| `F6` | Pause / Resume |
| `F3` | Stop |
| `F4` | Align windows |

---

## Troubleshooting

**The macro won't open / freezes during validation**
- Check your internet connection
- Confirm that your HWID has been authorized by the admin

**Images not detected / macro clicks in the wrong place**
- Confirm that the `Images/` folder is next to the `.exe`
- Make sure Roblox is at **800 × 600** and in the correct position (use **Align F4**)
- Do not use DPI scaling other than 100% in Windows display settings

**Camera over- or under-rotates (Spring LTM)**
- Adjust the **Camera Rotation** field (increase if it stops too early, decrease if it goes too far)
- This is especially common on RDP / remote desktop sessions

**The macro got stuck (softlock)**
- The softlock watchdog automatically restarts stuck runs after the configured timeout (Cid Strat only)

**High RAM usage / FPS drops after a long session**
- Auto RAM Trim runs periodically and handles this automatically
- You can lower the **CD** interval to trim more frequently

**Error logs**
- Enable **Save Log** in the interface to record the full session log (saved to `logs/` next to the `.exe`)

---

## Release Files

| File | Description |
|---|---|
| `InazumaMango.exe` | Main executable |
| `Images/` | Template matching images (must be next to the exe) |
| `tesseract/` | OCR for wave number detection (Spring LTM) |
| `fonts/` | League Spartan font files used by the GUI |
| `config.json` | Settings — automatically edited by the GUI |
| `get_hwid.bat` | Utility to obtain your HWID |
| `get_hwid.py` | Script invoked by `get_hwid.bat` |
