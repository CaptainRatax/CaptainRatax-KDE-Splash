# CaptainRatax KDE Splash

**Version 1.0.1** - Prevents the logo and spinner from disappearing before KDE closes the splash.

Custom **KDE Plasma 6 session splash** inspired by a minimal Kuro-style presentation. This is **not** a Plymouth theme or an SDDM login theme.

## Features

- Personal CaptainRatax logo, centered on every screen.
- Smooth green spinning progress indicator implemented with QtQuick Canvas and RotationAnimator.
- Responsive, monitor-local geometry based on the window dimensions provided by Plasma.
- Two selectable variants:
  - **CaptainRatax Splash**: original CaptainRatax wallpaper.
  - **CaptainRatax Splash - Black**: solid black background.
- QML intro fade-in; logo and spinner remain visible until KSplash closes (no premature fade-out).
- No changes to Limine, Plymouth, systemd or the current Kuro splash theme.

## Compatibility

Designed for KDE Plasma 6 / Qt 6. Not tested on older Plasma versions. Other desktop environments are not supported.

## Installation

Extract the archive and run:

```bash
cd ~/Downloads
tar -xzf CaptainRatax-KDE-Splash-v1.0.1.tar.gz
cd CaptainRatax-KDE-Splash-v1.0.1
./install.sh
```

The script installs into `~/.local/share/plasma/look-and-feel/` without root. Open **System Settings → Colors & Themes → Splash Screen**, select a CaptainRatax theme, and choose **Apply**. If it does not appear immediately, close and reopen System Settings.

You can also install manually by copying either `com.captainratax.splash` folder into `~/.local/share/plasma/look-and-feel/`.

## Test without logging out

```bash
ksplashqml --test --window "$HOME/.local/share/plasma/look-and-feel/com.captainratax.splash"
ksplashqml --test --window "$HOME/.local/share/plasma/look-and-feel/com.captainratax.splash.black"
```

Use the **Preview** button in KDE System Settings for another quick check. Actual login timing and display appearance may vary from the test mode.

## Switch back to Kuro

Select **Kuro** in System Settings → Splash Screen and click Apply. No files need to be deleted.

## Uninstall

Switch away from these themes in System Settings first, then:

```bash
rm -rf -- "$HOME/.local/share/plasma/look-and-feel/com.captainratax.splash" \
          "$HOME/.local/share/plasma/look-and-feel/com.captainratax.splash.black"
```

## Assets and licensing

All QML scripts, inline comments, installers, and this README are written in English. The CaptainRatax logo and original background are personal artwork; their inclusion here does not by itself grant public reuse or redistribution rights. Decide and document the graphic asset licensing before uploading the archive to a public repository.

## Changes in v1.0.1

- Removed stage-5 fade-out from both wallpaper and black variants.
- Logo and spinner now stay visible until Plasma dismisses KSplash.
- Kept original intro animation, design, images, scaling, and installation behavior unchanged.

## Notes

- The spinner is an indeterminate loading indicator; it is not an accurate measure of boot progress.
- Unlike Plymouth, this splash is displayed **after login while Plasma initializes**.
- The wallpaper is rendered with `Image.PreserveAspectCrop`. On 16:9 displays such as 1920×1080 and 2560×1440, it should keep the same composition when the display reports the correct aspect ratio.
- The KDE session can start too quickly for the splash to remain visible for long. The theme does not introduce artificial delays.
