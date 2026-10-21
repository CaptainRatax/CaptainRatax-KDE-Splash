#!/usr/bin/env bash
# Install CaptainRatax KSplash themes for the current user (no root required).
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
destination="${XDG_DATA_HOME:-$HOME/.local/share}/plasma/look-and-feel"
mkdir -p -- "$destination"

for theme in com.captainratax.splash com.captainratax.splash.black; do
    if [[ ! -f "$script_dir/$theme/metadata.json" ]]; then
        printf 'Missing theme: %s\n' "$theme" >&2
        exit 1
    fi
    mkdir -p -- "$destination/$theme"
    cp -a -- "$script_dir/$theme/." "$destination/$theme/"
    printf 'Installed: %s\n' "$destination/$theme"
done

if command -v kbuildsycoca6 >/dev/null 2>&1; then
    kbuildsycoca6 --noincremental >/dev/null 2>&1 || true
fi

printf '\nOpen System Settings > Colors & Themes > Splash Screen.\n'
printf 'Choose CaptainRatax Splash or CaptainRatax Splash - Black and click Apply.\n'
printf 'The existing Kuro splash is not removed or changed automatically.\n'
