#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")/.."

export PIP_BREAK_SYSTEM_PACKAGES=1

python3 -m pip install -e "./python" --no-build-isolation
python3 -m pip install -e tokenspeed-kernel/python/ --no-build-isolation
python3 -m pip install -e tokenspeed-scheduler/
