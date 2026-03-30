# CLAUDE.md

This file provides guidance to Claude Code when working with this repository.

## Project Overview

Shortcut Agent Skill is a Claude Code skill that generates Apple Shortcuts (.shortcut files) from natural language descriptions. Users describe what they want to automate, and the skill produces a signed, installable shortcut file.

## Usage

```
/shortcut "Send the weather to my wife every morning at 7"
```

## Architecture

```
.claude/skills/shortcut-agent/SKILL.md  — Skill definition (prompt + knowledge)
scripts/generate_plist.py               — Converts action JSON to plist XML
scripts/sign_and_open.sh                — Signs and opens the shortcut
data/actions.json                       — Complete action reference (427+ actions)
examples/                               — Example shortcut templates
output/                                 — Generated .shortcut files (gitignored)
```

## Key Commands

```bash
# Generate a shortcut from plist XML
python3 scripts/generate_plist.py output/my_shortcut.plist

# Sign a shortcut (requires macOS)
shortcuts sign --mode anyone --input output/unsigned.plist --output output/signed.shortcut

# Open in Shortcuts app
open output/signed.shortcut
```

## Development Notes

- Shortcut files are plist (XML or binary) format
- iOS 15+ requires signing via `shortcuts sign`
- Actions use UUID-based references for variable passing
- U+FFFC (Object Replacement Character) is the placeholder for variables in text strings
- Control flow uses GroupingIdentifier + WFControlFlowMode (0=start, 1=middle, 2=end)
