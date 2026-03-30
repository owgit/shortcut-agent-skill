<div align="center">

# Shortcut Agent Skill

### AI-Powered Apple Shortcuts Generator

Describe what you want to automate in plain language.
Get a signed `.shortcut` file ready to install on your iPhone, iPad, or Mac.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform: macOS](https://img.shields.io/badge/Platform-macOS-black?logo=apple&logoColor=white)](https://support.apple.com/shortcuts)
[![Actions: 427+](https://img.shields.io/badge/Actions-427%2B-orange)](.claude/skills/shortcut-agent/references/actions.md)
[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/uygarduzgun)

**Works with** &nbsp; [Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview) &nbsp;|&nbsp; [Cursor](https://cursor.sh) &nbsp;|&nbsp; [OpenAI Codex](https://openai.com/codex)

---

```
/shortcut "Check my battery and warn me if it's below 20%"
```

</div>

## Requirements

- **macOS** (required for the `shortcuts sign` CLI tool)
- **Python 3** (for plist validation)
- One of the following AI coding tools:
  - [Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview)
  - [Cursor](https://cursor.sh)
  - [OpenAI Codex](https://openai.com/codex)

## Supported AI Tools

| Tool | Config File | How It Works |
|------|-------------|--------------|
| **Claude Code** | `.claude/skills/shortcut-agent/SKILL.md` | Auto-detected as a skill. Use `/shortcut "..."` |
| **Cursor** | `.cursorrules` | Auto-loaded on project open. Ask naturally |
| **OpenAI Codex** | `AGENTS.md` | Auto-loaded on project open. Ask naturally |

All three tools share the same reference files in `.claude/skills/shortcut-agent/references/` for action identifiers, plist format, and CLI usage.

## Installation

### Step 1: Clone the repo

```bash
git clone https://github.com/owgit/shortcut-agent-skill.git
cd shortcut-agent-skill
```

### Step 2: Open the project in your AI tool

**Claude Code:**
```bash
claude
```
Claude Code automatically detects the skill from `.claude/skills/shortcut-agent/SKILL.md`.

**Cursor:**
Open the project folder in Cursor. It automatically reads `.cursorrules` for shortcut generation instructions.

**OpenAI Codex:**
Open the project folder. Codex reads `AGENTS.md` for shortcut generation instructions.

### Alternative: Add to an existing project

If you want to use this skill inside another project:

```bash
cd /path/to/your/project

# Option A: Copy the skill directory
cp -r /path/to/shortcut-agent-skill/.claude/skills/shortcut-agent .claude/skills/shortcut-agent

# Option B: Git submodule (keeps it updatable)
git submodule add https://github.com/owgit/shortcut-agent-skill.git vendor/shortcut-agent
cp -r vendor/shortcut-agent/.claude/skills/shortcut-agent .claude/skills/shortcut-agent
```

Also copy the helper scripts:

```bash
cp -r /path/to/shortcut-agent-skill/scripts ./scripts
cp -r /path/to/shortcut-agent-skill/examples ./examples
mkdir -p output
```

### Step 3: Verify it works

**Claude Code:**
```
/shortcut "Show a notification that says Hello World"
```

**Cursor / Codex:**
```
Create a shortcut that shows a notification saying Hello World
```

The AI generates a `.shortcut` file, signs it, and opens it in the Shortcuts app.

## Usage

Describe any automation in natural language:

```
/shortcut "Check my battery and warn me if it's below 20%"
```

```
/shortcut "Ask me for a URL, fetch the JSON, and show the title field"
```

```
/shortcut "Give me a menu: Check IP, Random number, or Quick note to clipboard"
```

### What happens

1. Claude analyzes your request
2. Plans the action chain and shows it to you
3. Generates valid plist XML with proper UUIDs and variable wiring
4. Signs it using `shortcuts sign --mode anyone`
5. Opens it in the Shortcuts app for you to review and add

### Transfer to iPhone/iPad

After adding the shortcut on your Mac, it **syncs automatically** via iCloud to your iPhone and iPad (if signed into the same Apple ID with Shortcuts sync enabled).

## Examples

The `examples/` folder contains ready-made shortcuts you can install immediately:

| File | Description | Actions tested |
|------|-------------|---------------|
| `hello_world.plist` | Shows "Hello World" | Text, Show Result, variable reference |
| `ask_and_notify.plist` | Asks your name, sends notification | Ask, Set Variable, Notification |
| `api_call.plist` | Fetches a URL, parses JSON, shows result | URL, HTTP GET, Dictionary, Show Result |

### Install an example

```bash
cp examples/hello_world.plist output/hello_world.plist
bash scripts/sign_and_open.sh hello_world
```

The shortcut opens in the Shortcuts app. Click "Add Shortcut" to install it.

## Supported Actions (427+)

| Category | Examples |
|----------|---------|
| **Text** | Create, combine, replace, match, split, change case |
| **Web/HTTP** | GET/POST/PUT/DELETE with headers, JSON bodies, form data |
| **User Interaction** | Ask for input, show result, alert, notification, speak, menu |
| **Variables** | Set, get, append, named variables, magic variables |
| **Control Flow** | If/else, repeat count, repeat each, choose from menu |
| **Data** | Dictionary, list, number, math, statistics, base64, hash |
| **Date/Time** | Format, compare, wait/delay |
| **Device** | Battery, brightness, volume, Bluetooth, Wi-Fi, airplane mode, DND |
| **Location** | Current location, search maps |
| **Calendar** | Create events, find events, create reminders |
| **Media** | Take photo, resize image, play/pause music |
| **Files** | Save, open, AirDrop, share, zip/unzip, clipboard |
| **Communication** | Send message, send email, FaceTime, phone call |

## Project Structure

```
shortcut-agent-skill/
├── .claude/skills/shortcut-agent/
│   ├── SKILL.md                        # Skill definition (Claude Code)
│   └── references/
│       ├── actions.md                  # 100+ action identifiers & parameters
│       ├── plist-format.md             # Plist XML spec, variables, control flow
│       └── url-schemes-and-cli.md      # URL schemes, CLI, automation triggers
├── .cursorrules                        # Cursor AI instructions
├── AGENTS.md                           # OpenAI Codex instructions
├── CLAUDE.md                           # Claude Code project context
├── scripts/
│   ├── generate_plist.py               # Plist validation helper
│   └── sign_and_open.sh               # Sign shortcut + open in Shortcuts app
├── examples/
│   ├── hello_world.plist               # Minimal example
│   ├── ask_and_notify.plist            # Input + notification
│   └── api_call.plist                  # HTTP + JSON parsing
├── output/                             # Generated files (gitignored)
├── README.md                           # This file
└── LICENSE                             # MIT
```

## Troubleshooting

### "shortcuts: command not found"

The `shortcuts` CLI is only available on **macOS 12 (Monterey)** or later. Check with:

```bash
which shortcuts
```

### Signing fails with "not in the correct format"

The `shortcuts sign` command requires the input file to have a `.shortcut` extension. The `sign_and_open.sh` script handles this automatically. If running manually:

```bash
# Wrong:
shortcuts sign --input file.plist --output file.shortcut

# Right:
cp file.plist file.shortcut
shortcuts sign --mode anyone --input file.shortcut --output signed.shortcut
```

### Shortcut doesn't sync to iPhone

Make sure:
- Same Apple ID on both devices
- **Settings > [Your Name] > iCloud > Shortcuts** is enabled on both
- Give it a minute — sync isn't instant

### Shortcut installs but doesn't work

Some actions behave differently on macOS vs iOS (e.g., notifications, haptics). Test on the target device. You can also validate via CLI:

```bash
shortcuts run "Shortcut Name"
```

## Contributing

1. Fork the repo
2. Add new example templates in `examples/`
3. Improve action coverage in `.claude/skills/shortcut-agent/references/actions.md`
4. Submit a PR

## Support

If you find this useful, consider buying me a coffee:

[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/uygarduzgun)

## Author

- Website: [uygarduzgun.com](https://uygarduzgun.com)
- GitHub: [owgit](https://github.com/owgit)
- Support: [Buy Me a Coffee](https://buymeacoffee.com/uygarduzgun)

## License

MIT
