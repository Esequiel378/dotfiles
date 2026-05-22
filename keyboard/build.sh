#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ZMK_CONFIG="$SCRIPT_DIR/zmk-config"
FIRMWARE_DIR="$SCRIPT_DIR/firmware"
DOCKER_IMAGE="zmkfirmware/zmk-dev-arm:stable"
DOCKER_VOLUME="zmk-workspace"
BOARD="nice_nano/nrf52840/zmk"

mkdir -p "$FIRMWARE_DIR"

# Create persistent volume for the west workspace (avoids re-cloning every build)
docker volume create "$DOCKER_VOLUME" >/dev/null 2>&1 || true

echo "Building ZMK firmware via Docker..."
echo ""

docker run --rm \
  -v "$DOCKER_VOLUME:/workspace" \
  -v "$ZMK_CONFIG/config:/zmk-config-src:ro" \
  -v "$FIRMWARE_DIR:/firmware" \
  "$DOCKER_IMAGE" \
  sh -c '
    set -e
    BOARD="'"$BOARD"'"

    mkdir -p /workspace/config
    cp -r /zmk-config-src/* /workspace/config/
    cd /workspace

    # Initialize west workspace on first run
    if [ ! -d /workspace/.west ]; then
      echo "==> Initializing west workspace (first run)..."
      west init -l config
      west update
    fi

    # Always re-register Zephyr cmake package (stored in ephemeral ~/)
    west zephyr-export 2>/dev/null

    echo ""
    echo "==> Building left half..."
    rm -rf build
    west build -s zmk/app -b "$BOARD" -- \
      -DSHIELD=corne_left \
      -DZMK_CONFIG=/workspace/config
    cp build/zephyr/zmk.uf2 /firmware/corne_left.uf2

    echo ""
    echo "==> Building right half..."
    rm -rf build
    west build -s zmk/app -b "$BOARD" -- \
      -DSHIELD=corne_right \
      -DZMK_CONFIG=/workspace/config
    cp build/zephyr/zmk.uf2 /firmware/corne_right.uf2

    echo ""
    echo "Build complete!"
  '

echo ""
echo "Firmware files:"
ls -lh "$FIRMWARE_DIR"/*.uf2
echo ""
echo "To flash: double-tap reset on each half, then:"
echo "  cp firmware/corne_left.uf2 /Volumes/NICENANO"
echo "  cp firmware/corne_right.uf2 /Volumes/NICENANO"
