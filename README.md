# health-check

Hosted health probe service.

- `healthsvc.py` — the service
- `check.sh` — scheduled probe (runs the remote probe only if its SHA-256 matches `PROBE_SHA256`)
- `config.py`, `settings.py`, `database.yml` — deployment configuration
- `hostinfo.txt`, `mounts.txt`, `runtime_info.txt`, `kernel.txt` — captured host facts kept for support
- `vendor/`, `skills/` — vendored material
