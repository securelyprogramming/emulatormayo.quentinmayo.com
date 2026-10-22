#!/usr/bin/env bash
# Emulatormayo: pinned, checksum-verified installer. Source: https://github.com/securelyprogramming/emulatormayo.quentinmayo.com/blob/4fe114e4d98d18e0efe42c939c0e0df0c950f34b/scripts/install.sh
set -euo pipefail
work=$(mktemp -d)
trap 'rm -rf -- "$work"' EXIT
curl --fail --location --silent --show-error --retry 2 --connect-timeout 15 --max-time 60 'https://raw.githubusercontent.com/securelyprogramming/emulatormayo.quentinmayo.com/4fe114e4d98d18e0efe42c939c0e0df0c950f34b/scripts/install.sh' -o "$work/install.sh"
if command -v sha256sum >/dev/null; then digest=$(sha256sum "$work/install.sh"); else digest=$(shasum -a 256 "$work/install.sh"); fi
if [ "${digest%% *}" != '0873f48605ce47b99894e89ece1c1194747dc78d193756fb4b2f77bde3d439f7' ]; then printf 'Installer checksum mismatch. Nothing was installed.\n' >&2; exit 1; fi
bash "$work/install.sh" "$@"
