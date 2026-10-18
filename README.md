# Steal-an-Egg-Fishing-Macro

# Roblox Fishing Macro (AutoHotkey v2)

An AutoHotkey v2 script that automates the fishing loop in Steal an Egg:

1. Holds the mouse to cast, releasing at the fixed sweet spot
2. Waits for the **"Click Fast!"** prompt by watching for the red **STOP** button on screen
3. Spam-clicks while the prompt is visible
4. Recasts automatically

Because it watches the screen instead of using fixed timers, it handles the variable time before the prompt appears.

> **Disclaimer:** Roblox and many games prohibit automation. Using a macro can get your account banned. Use at your own risk.

## Requirements

- Windows
- [AutoHotkey v2](https://www.autohotkey.com/) (v1 will not work)

## Setup

1. Install AutoHotkey **v2**.
2. Download `egg.ahk` and double-click it. A green "H" icon appears in your system tray.
3. Run Roblox **windowed or maximized** and keep it in the same spot every time.
4. Bring up the "Click Fast!" prompt, move your mouse away from the STOP button, and press **F8** (or **F10** for the vertical profile).
   - It should say **Prompt FOUND**. Press it again after the prompt disappears and it should say **NOT found**.
5. Press the start hotkey and let it run.

If clicks don't register in the game, right-click `egg.ahk` and choose **Run as administrator**.

## Hotkeys

| Key | Action |
|-----|--------|
| **F6** | Start / stop (normal monitor profile) |
| **F3** | Start / stop (vertical monitor profile) |
| **F8** | Test detection (normal profile) |
| **F10** | Test detection (vertical profile) |
| **F12** | Show mouse position and pixel color (for calibration) |
| **F7** | Quit the script |

Press the start key again to stop. Move your mouse to the correct monitor before starting, and keep the cursor away from the STOP button, since the script clicks wherever the cursor is.

## Settings you'll probably need to change

At the top of the script:

| Setting | What it does |
|---------|--------------|
| `HoldTime` | Milliseconds to hold the cast. **Tune this for your setup** (frame rate and ping affect it). Adjust in steps of about 50. |
| `ClickDelay` | Milliseconds between spam clicks |
| `LoopDelay` | Pause before recasting |
| `PromptTimeout` | Gives up waiting for the prompt and recasts after this many ms |
| `PromptColor` / `Variation` | Color of the STOP button and how much it may differ |

## Calibrating for your screen

The default detection boxes were made for a **1920x1080** display with Roblox maximized. On a different resolution, display scale, or window position you'll need to update them.

The `Profiles` map holds a search box for each monitor as `[X1, Y1, X2, Y2]`, in screen coordinates. The box should surround the STOP button with a bit of margin.

1. Bring up the "Click Fast!" prompt.
2. Hover over the center of the STOP button and press **F12** to read its screen position.
3. Build the box around it, for example `X1 = x - 36`, `X2 = x + 40`, `Y1 = y - 18`, `Y2 = y + 19`.
4. Replace the matching entry in `Profiles`, reload the script, and test with **F8** / **F10**.

Notes:
- Coordinates are desktop-wide, so a second monitor to the left or above your main one will have **negative** numbers. That's normal.
- The STOP button changes color when hovered, so test detection with the mouse parked elsewhere.
- Moving or resizing the Roblox window breaks detection until you recalibrate.
- Fish on the pond located at the Halloween Event spawn, not any other areas of water.
- IMPORTANT. Remove the fishing rod on the hotbar and instead equip the fishing rod using the inventory, this is due to each time you get an item, the fishing rod shifts one place to the right of the hotbar. If it exceeds the hotbar, it unequips itself.

## Troubleshooting

- **"Prompt NOT found" while the prompt is showing:** the box doesn't line up with the button. Recheck coordinates with F12, or widen the box.
- **Macro casts but never clicks:** run the script as administrator.
- **Version error on launch:** you have AutoHotkey v1 installed. Install v2.
