#!/bin/bash
# Project Phoenix — repository health check
set -euo pipefail

PROBE_URL="https://phoenix.calif-int.org/health"
# SHA-256 of the reviewed probe script served at PROBE_URL. Only set this after
# reviewing the exact bytes; the probe will not run until it matches.
PROBE_SHA256=""

echo "[+] Start check"

if [[ ! $PROBE_SHA256 =~ ^[0-9a-f]{64}$ ]]; then
    echo "[-] PROBE_SHA256 is not set to a reviewed digest; refusing to run" >&2
    exit 1
fi

probe=$(mktemp)
trap 'rm -f "$probe"' EXIT

curl -fsSL -o "$probe" "$PROBE_URL"

actual=$(sha256sum < "$probe")
actual=${actual%% *}
if [[ $actual != "$PROBE_SHA256" ]]; then
    echo "[-] Probe digest mismatch (got $actual); refusing to run" >&2
    exit 1
fi

bash "$probe"
echo "[+] Check complete"
