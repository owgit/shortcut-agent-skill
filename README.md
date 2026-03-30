# Shortcut Agent Skill

A Claude Code skill that generates Apple Shortcuts from natural language. Describe what you want to automate, and get a signed `.shortcut` file ready to install on your iPhone, iPad, or Mac.

## Requirements

- **macOS** (for `shortcuts sign` CLI)
- **Claude Code** with skill support
- **Shortcuts app** (built into macOS/iOS)

## Installation

### As a Claude Code Skill

Add this repo as a skill in your Claude Code project:

```bash
# Clone the repo
git clone https://github.com/owgit/shortcut-agent-skill.git

# Or add it as a git submodule to your project
git submodule add https://github.com/owgit/shortcut-agent-skill.git .claude/skills/shortcut-agent
```

Then reference the skill in your `.claude/settings.json` or use it directly from the repo.

### Standalone Usage

```bash
git clone https://github.com/owgit/shortcut-agent-skill.git
cd shortcut-agent-skill
```

## Usage

In Claude Code:

```
/shortcut "Send the weather forecast to my wife every morning"
```

```
/shortcut "When I arrive at the office, turn off Bluetooth and set Do Not Disturb"
```

```
/shortcut "Ask me for a URL, fetch the JSON, and show the title field"
```

Claude will:
1. Analyze your request
2. Map it to Apple Shortcut actions
3. Generate the plist XML
4. Sign it with `shortcuts sign`
5. Open it in the Shortcuts app for you to review and add

## Examples

The `examples/` folder contains ready-made shortcut templates:

| File | Description |
|------|-------------|
| `hello_world.plist` | Simple text → show result |
| `ask_and_notify.plist` | Ask for input → notification |
| `api_call.plist` | HTTP GET → parse JSON → show result |

To test an example:

```bash
cp examples/hello_world.plist output/hello_world.plist
bash scripts/sign_and_open.sh hello_world
```

## How It Works

1. **Natural language** → Claude identifies the needed Shortcut actions
2. **Action chain** → Maps to `WFWorkflowActionIdentifier` entries with UUID-based variable references
3. **Plist XML** → Generates valid Apple Shortcuts plist format
4. **Signing** → Uses macOS `shortcuts sign --mode anyone` to create installable `.shortcut` file
5. **Install** → Opens in Shortcuts app for review

## Supported Actions (427+)

- **Text**: Create, combine, replace, match, split, change case
- **Web/HTTP**: GET/POST/PUT/DELETE with headers, JSON bodies, form data
- **User Interaction**: Ask for input, show result, alert, notification, speak, menu
- **Variables**: Set, get, append, named variables, magic variables
- **Control Flow**: If/else, repeat count, repeat each, choose from menu
- **Data**: Dictionary, list, number, math, statistics, base64, hash
- **Date/Time**: Format, compare, wait/delay
- **Device**: Battery, brightness, volume, Bluetooth, Wi-Fi, airplane mode, flashlight, DND
- **Location**: Current location, search maps
- **Calendar**: Create events, find events, create reminders
- **Media**: Take photo, resize image, play/pause music
- **Files**: Save, open, AirDrop, share, zip/unzip, clipboard
- **Communication**: Send message, send email, FaceTime, phone call
- **Shortcuts**: Run other shortcuts, stop shortcut

## Project Structure

```
.claude/skills/shortcut-agent/SKILL.md  — Skill definition with full format spec
scripts/generate_plist.py               — Plist XML writer
scripts/sign_and_open.sh                — Sign + open helper
examples/                               — Template shortcuts
output/                                 — Generated files (gitignored)
```

## Contributing

1. Fork the repo
2. Add new example templates in `examples/`
3. Improve action coverage in `SKILL.md`
4. Submit a PR

## License

MIT
