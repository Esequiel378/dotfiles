#!/usr/bin/env python3
"""Convert VIA (crkbd.layout.json) to ZMK keymap (corne.keymap)."""

import json
import re
import sys
from pathlib import Path

# QMK keycode -> ZMK binding mapping
KEYCODE_MAP = {
    # Letters
    **{f"KC_{c}": f"&kp {c}" for c in "ABCDEFGHIJKLMNOPQRSTUVWXYZ"},
    # Numbers
    **{f"KC_{n}": f"&kp N{n}" for n in range(10)},
    # Modifiers
    "KC_LSFT": "&kp LSHFT",
    "KC_RSFT": "&kp RSHFT",
    "KC_LCTL": "&kp LCTRL",
    "KC_RCTL": "&kp RCTRL",
    "KC_LALT": "&kp LALT",
    "KC_RALT": "&kp RALT",
    "KC_LGUI": "&kp LGUI",
    "KC_RGUI": "&kp RGUI",
    # Common keys
    "KC_SPC": "&kp SPACE",
    "KC_ENT": "&kp RET",
    "KC_BSPC": "&kp BSPC",
    "KC_TAB": "&kp TAB",
    "KC_ESC": "&kp ESC",
    "KC_DEL": "&kp DEL",
    "KC_CAPS": "&kp CAPS",
    # Punctuation
    "KC_MINS": "&kp MINUS",
    "KC_EQL": "&kp EQUAL",
    "KC_LBRC": "&kp LBKT",
    "KC_RBRC": "&kp RBKT",
    "KC_BSLS": "&kp BSLH",
    "KC_SCLN": "&kp SEMI",
    "KC_QUOT": "&kp SQT",
    "KC_GRV": "&kp GRAVE",
    "KC_COMM": "&kp COMMA",
    "KC_DOT": "&kp DOT",
    "KC_SLSH": "&kp FSLH",
    # Arrow keys
    "KC_LEFT": "&kp LEFT",
    "KC_RGHT": "&kp RIGHT",
    "KC_UP": "&kp UP",
    "KC_DOWN": "&kp DOWN",
    # Navigation
    "KC_HOME": "&kp HOME",
    "KC_END": "&kp END",
    "KC_PGUP": "&kp PG_UP",
    "KC_PGDN": "&kp PG_DN",
    "KC_INS": "&kp INS",
    "KC_PSCR": "&kp PSCRN",
    # Function keys
    **{f"KC_F{n}": f"&kp F{n}" for n in range(1, 25)},
    # Special
    "KC_NO": "&none",
    "KC_TRNS": "&trans",
    # Media
    "KC_MUTE": "&kp K_MUTE",
    "KC_VOLU": "&kp K_VOL_UP",
    "KC_VOLD": "&kp K_VOL_DN",
    # RGB — mapped to &none since RGB is disabled for BLE battery savings.
    # To re-enable: set CONFIG_ZMK_RGB_UNDERGLOW=y in corne.conf and
    # change these to &rgb_ug RGB_TOG, &rgb_ug RGB_EFF, etc.
    "RGB_TOG": "&none",
    "RGB_MOD": "&none",
    "RGB_RMOD": "&none",
    "RGB_HUI": "&none",
    "RGB_HUD": "&none",
    "RGB_SAI": "&none",
    "RGB_SAD": "&none",
    "RGB_VAI": "&none",
    "RGB_VAD": "&none",
}

# Shifted key mappings: S(KC_X) -> ZMK name
SHIFTED_MAP = {
    "KC_1": "EXCL",
    "KC_2": "AT",
    "KC_3": "HASH",
    "KC_4": "DLLR",
    "KC_5": "PRCNT",
    "KC_6": "CARET",
    "KC_7": "AMPS",
    "KC_8": "ASTRK",
    "KC_9": "LPAR",
    "KC_0": "RPAR",
    "KC_MINS": "UNDER",
    "KC_EQL": "PLUS",
    "KC_LBRC": "LBRC",
    "KC_RBRC": "RBRC",
    "KC_BSLS": "PIPE",
    "KC_SCLN": "COLON",
    "KC_QUOT": "DQT",
    "KC_GRV": "TILDE",
    "KC_COMM": "LT",
    "KC_DOT": "GT",
    "KC_SLSH": "QMARK",
}

LAYER_NAMES = ["default_layer", "lower_layer", "raise_layer", "function_layer"]
LAYER_DISPLAY = ["Default", "Lower", "Raise", "Function"]

# BT keys to inject into layer 3 (function layer) right-side rows
# These replace &none slots on the right half
BT_KEYS = {
    # Right row 1 positions (after F6-F10 keys): fill remaining &none slots
    # We'll inject into specific positions in the final layout
}


def convert_keycode(qmk_key: str) -> str:
    """Convert a single QMK keycode to ZMK binding."""
    qmk_key = qmk_key.strip()

    # Direct mapping
    if qmk_key in KEYCODE_MAP:
        return KEYCODE_MAP[qmk_key]

    # MO(n) -> &mo n
    mo_match = re.match(r"MO\((\d+)\)", qmk_key)
    if mo_match:
        return f"&mo {mo_match.group(1)}"

    # TG(n) -> &tog n
    tg_match = re.match(r"TG\((\d+)\)", qmk_key)
    if tg_match:
        return f"&tog {tg_match.group(1)}"

    # LT(layer, kc) -> &lt layer kc
    lt_match = re.match(r"LT\((\d+),\s*(KC_\w+)\)", qmk_key)
    if lt_match:
        layer = lt_match.group(1)
        kc = lt_match.group(2)
        zmk_kc = convert_keycode(kc).replace("&kp ", "")
        return f"&lt {layer} {zmk_kc}"

    # S(KC_X) -> shifted key
    shift_match = re.match(r"S\((KC_\w+)\)", qmk_key)
    if shift_match:
        inner = shift_match.group(1)
        if inner in SHIFTED_MAP:
            return f"&kp {SHIFTED_MAP[inner]}"
        # Fallback: use LS() wrapper
        zmk_inner = convert_keycode(inner).replace("&kp ", "")
        return f"&kp LS({zmk_inner})"

    # LSFT(kc) / LCTL(kc) etc
    mod_match = re.match(r"(LSFT|RSFT|LCTL|RCTL|LALT|RALT|LGUI|RGUI)\((KC_\w+)\)", qmk_key)
    if mod_match:
        mod_map = {
            "LSFT": "LS", "RSFT": "RS", "LCTL": "LC", "RCTL": "RC",
            "LALT": "LA", "RALT": "RA", "LGUI": "LG", "RGUI": "RG",
        }
        mod = mod_map[mod_match.group(1)]
        kc = mod_match.group(2)
        zmk_kc = convert_keycode(kc).replace("&kp ", "")
        return f"&kp {mod}({zmk_kc})"

    print(f"WARNING: Unknown keycode '{qmk_key}', using &none", file=sys.stderr)
    return "&none"


def extract_layer_keys(layer_keys: list[str]) -> list[list[str]]:
    """Extract physical key layout from VIA's flat array.

    VIA stores 48 keys per layer for the Corne:
      Left:  rows 0-2 (6 each) + row 3 (3 padding KC_NO + 3 thumb)
      Right: rows 0-2 (6 each, reversed) + row 3 (3 padding KC_NO + 3 thumb, reversed)

    Returns 4 rows: [row0_12keys, row1_12keys, row2_12keys, thumb_6keys]
    """
    # Left side
    left_row0 = layer_keys[0:6]
    left_row1 = layer_keys[6:12]
    left_row2 = layer_keys[12:18]
    left_thumb = layer_keys[21:24]  # skip indices 18-20 (KC_NO padding)

    # Right side (stored reversed, need to flip back)
    right_row0 = list(reversed(layer_keys[24:30]))
    right_row1 = list(reversed(layer_keys[30:36]))
    right_row2 = list(reversed(layer_keys[36:42]))
    right_thumb = list(reversed(layer_keys[45:48]))  # skip indices 42-44 (KC_NO padding)

    return [
        left_row0 + right_row0,
        left_row1 + right_row1,
        left_row2 + right_row2,
        left_thumb + right_thumb,
    ]


def inject_bt_keys(rows: list[list[str]]) -> list[list[str]]:
    """Inject Bluetooth profile keys into the function layer.

    BT_CLR lives on the bottom-right corner (the ESC key on the base layer),
    so lower+raise+ESC clears bonds. BT_SEL 0-4 run across the right home row
    starting at H. Only overwrites &none slots.
    """
    # (row, col) -> binding. Right home row cols 6-10 = H J K L ;
    # Row 2 col 11 = the ESC corner.
    placements = {
        (1, 6): "&bt BT_SEL 0",   # H
        (1, 7): "&bt BT_SEL 1",   # J
        (1, 8): "&bt BT_SEL 2",   # K
        (1, 9): "&bt BT_SEL 3",   # L
        (1, 10): "&bt BT_SEL 4",  # ;
        (2, 11): "&bt BT_CLR",    # ESC corner
    }
    for (row, col), binding in placements.items():
        if rows[row][col] == "&none":
            rows[row][col] = binding
    return rows


def format_binding(binding: str, width: int = 12) -> str:
    """Pad a binding string to a fixed width for alignment."""
    return binding.ljust(width)


def generate_keymap(layers: list[list[str]]) -> str:
    """Generate the full ZMK keymap devicetree source."""
    lines = []
    lines.append("/*")
    lines.append(" * Auto-generated by convert.py from crkbd.layout.json")
    lines.append(" * Do not edit manually — re-run the converter instead.")
    lines.append(" */")
    lines.append("")
    lines.append("#include <behaviors.dtsi>")
    lines.append("#include <dt-bindings/zmk/keys.h>")
    lines.append("#include <dt-bindings/zmk/bt.h>")
    lines.append("")
    lines.append("/ {")
    # Tri-layer: holding lower (1) + raise (2) activates function (3).
    # Required because VIA's flat-layer model can't express this — without it,
    # layer 3 (BT controls) is unreachable.
    lines.append("    conditional_layers {")
    lines.append('        compatible = "zmk,conditional-layers";')
    lines.append("        tri_layer {")
    lines.append("            if-layers = <1 2>;")
    lines.append("            then-layer = <3>;")
    lines.append("        };")
    lines.append("    };")
    lines.append("")
    lines.append("    keymap {")
    lines.append('        compatible = "zmk,keymap";')

    for layer_idx, layer_keys in enumerate(layers):
        rows = extract_layer_keys(layer_keys)

        # Convert all keycodes
        zmk_rows = []
        for row in rows:
            zmk_rows.append([convert_keycode(k) for k in row])

        # Inject BT keys into the function layer (layer 3)
        if layer_idx == 3:
            zmk_rows = inject_bt_keys(zmk_rows)

        layer_name = LAYER_NAMES[layer_idx] if layer_idx < len(LAYER_NAMES) else f"layer_{layer_idx}"
        display_name = LAYER_DISPLAY[layer_idx] if layer_idx < len(LAYER_DISPLAY) else f"Layer {layer_idx}"

        lines.append("")
        lines.append(f"        {layer_name} {{")
        lines.append(f"            // {display_name}")
        lines.append("            bindings = <")

        for i, zmk_row in enumerate(zmk_rows):
            left = zmk_row[:6]
            right = zmk_row[6:]

            if i < 3:
                # Main rows: 6 left + 6 right
                left_str = " ".join(format_binding(k) for k in left)
                right_str = " ".join(format_binding(k) for k in right)
                lines.append(f"                {left_str}   {right_str}")
            else:
                # Thumb row: 3 left + 3 right, indented to center
                left_str = " ".join(format_binding(k) for k in left)
                right_str = " ".join(format_binding(k) for k in right)
                lines.append(f"                                        {left_str}   {right_str}")

        lines.append("            >;")
        lines.append("        };")

    lines.append("    };")
    lines.append("};")
    lines.append("")

    return "\n".join(lines)


def main():
    via_path = Path(__file__).parent / "crkbd.layout.json"
    out_path = Path(__file__).parent / "zmk-config" / "config" / "corne.keymap"

    if not via_path.exists():
        print(f"Error: {via_path} not found", file=sys.stderr)
        sys.exit(1)

    with open(via_path) as f:
        via_data = json.load(f)

    layers = via_data["layers"]
    print(f"Found {len(layers)} layers in {via_path.name}")

    keymap = generate_keymap(layers)

    out_path.parent.mkdir(parents=True, exist_ok=True)
    with open(out_path, "w") as f:
        f.write(keymap)

    print(f"Generated {out_path}")


if __name__ == "__main__":
    main()
