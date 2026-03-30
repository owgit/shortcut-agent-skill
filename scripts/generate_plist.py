#!/usr/bin/env python3
"""
Validate and prepare an Apple Shortcut plist file.

Usage:
    python3 scripts/generate_plist.py "Shortcut Name" --file input.plist
    python3 scripts/generate_plist.py "Shortcut Name" '<plist XML content>'

Validates the XML and writes it to output/<name>.plist.
"""

import sys
import os
import re
import subprocess


def sanitize_filename(name):
    """Convert a shortcut name to a safe filename."""
    return re.sub(r'[^\w\s-]', '', name).strip().replace(' ', '_').lower()


def validate_plist(path):
    """Validate plist format using plutil."""
    result = subprocess.run(['plutil', '-lint', path], capture_output=True, text=True)
    if result.returncode != 0:
        print(f"Error: Invalid plist format")
        print(result.stdout + result.stderr)
        return False
    return True


def main():
    if len(sys.argv) < 3:
        print("Usage: python3 generate_plist.py <name> --file <input.plist>")
        print("       python3 generate_plist.py <name> '<plist XML>'")
        sys.exit(1)

    name = sys.argv[1]
    safe_name = sanitize_filename(name)

    # Get XML content
    if sys.argv[2] == '--file':
        if len(sys.argv) < 4:
            print("Error: --file requires a path argument")
            sys.exit(1)
        with open(sys.argv[3], 'r') as f:
            xml_content = f.read()
    else:
        xml_content = sys.argv[2]

    # Ensure output directory exists
    output_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'output')
    os.makedirs(output_dir, exist_ok=True)

    output_path = os.path.join(output_dir, f'{safe_name}.plist')

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(xml_content)

    # Validate
    if not validate_plist(output_path):
        os.remove(output_path)
        sys.exit(1)

    print(f"Valid plist written to: {output_path}")
    return output_path


if __name__ == '__main__':
    main()
