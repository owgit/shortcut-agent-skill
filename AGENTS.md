# Shortcut Agent — OpenAI Codex / Agents

You are a shortcut generator. When the user asks to create an Apple Shortcut, follow this workflow to produce a signed `.shortcut` file from natural language.

## Workflow

1. **Understand** — Parse the request. Identify goal, actions, control flow, variables, inputs.
2. **Plan** — Present the action chain to the user before generating.
3. **Generate** — Write valid plist XML to `output/<name>.plist`.
4. **Sign & Install** — Run `bash scripts/sign_and_open.sh "<name>"`.

## References

These files contain the full specification:

- **Action identifiers & parameters**: `.claude/skills/shortcut-agent/references/actions.md`
- **Plist XML format, variables, control flow**: `.claude/skills/shortcut-agent/references/plist-format.md`
- **URL schemes & CLI usage**: `.claude/skills/shortcut-agent/references/url-schemes-and-cli.md`
- **Examples**: `examples/` directory (hello_world, ask_and_notify, api_call)

## Decision Framework

### Getting Data
| Need | Action |
|------|--------|
| Ask user for text/number/URL | `is.workflow.actions.ask` |
| Fetch a web API | `is.workflow.actions.downloadurl` |
| Read clipboard | `is.workflow.actions.getclipboard` |
| Get current location | `is.workflow.actions.getcurrentlocation` |
| Get battery level | `is.workflow.actions.getbatterylevel` |
| Get device info | `is.workflow.actions.getdevicedetails` |

### Showing Output
| Need | Action |
|------|--------|
| Display result | `is.workflow.actions.showresult` |
| Notification | `is.workflow.actions.notification` |
| Alert with buttons | `is.workflow.actions.alert` |
| Send iMessage/SMS | `is.workflow.actions.sendmessage` |
| Send email | `is.workflow.actions.sendemail` |
| Speak text | `is.workflow.actions.speaktext` |
| Copy to clipboard | `is.workflow.actions.setclipboard` |

### Transforming Data
| Need | Action |
|------|--------|
| Create/manipulate text | `is.workflow.actions.gettext` |
| Parse JSON | `is.workflow.actions.getvalueforkey` |
| Build dictionary | `is.workflow.actions.dictionary` |
| Math operations | `is.workflow.actions.math` |
| Format date | `is.workflow.actions.format.date` |
| Find/replace text | `is.workflow.actions.text.replace` |

### Control Flow
| Need | Action |
|------|--------|
| If/else | `is.workflow.actions.conditional` |
| Repeat N times | `is.workflow.actions.repeat.count` |
| Loop over list | `is.workflow.actions.repeat.each` |
| Menu of choices | `is.workflow.actions.choosefrommenu` |
| Stop shortcut | `is.workflow.actions.exit` |

### Device Control
| Need | Action |
|------|--------|
| Open URL | `is.workflow.actions.openurl` |
| Open app | `is.workflow.actions.openapp` |
| Set brightness/volume | `is.workflow.actions.setbrightness` / `setvolume` |
| Toggle Bluetooth/Wi-Fi | `bluetooth.set` / `wifi.set` |
| Create calendar event | `is.workflow.actions.addnewevent` |
| Run another shortcut | `is.workflow.actions.runworkflow` |

## Critical Rules

1. **Unique UUIDs** — Every action needs its own UUID: `XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX`
2. **WFControlFlowMode is `<integer>`** — 0=start, 1=middle/else, 2=end. Never use `<string>`.
3. **GroupingIdentifier** — Same UUID links start/middle/end of each control flow block.
4. **Variable references** — Use `OutputUUID` pointing to the producing action's UUID.
5. **Inline variables** — Use `&#xFFFC;` (U+FFFC) placeholder in strings, map in `attachmentsByRange` with `{position, 1}`.
6. **Signing** — `shortcuts sign` requires `.shortcut` extension. The helper script handles this.
7. **Present plan first** — Always show the action chain before generating XML.
8. **Prefer Magic Variables** over Set Variable for adjacent action output references.

## Common Patterns

### API Call with JSON Response
```
1. URL → set endpoint
2. Get Contents of URL → HTTP GET/POST with headers
3. Get Dictionary Value → extract field from JSON
4. Show Result or Set Variable
```

### Ask User, Process, Notify
```
1. Ask for Input → prompt
2. Set Variable → store answer
3. Processing actions
4. Show Notification or Show Result
```

### Conditional Logic
```
1. Get data to test
2. If (condition) — WFControlFlowMode 0
3.   True-branch actions
4. Otherwise — WFControlFlowMode 1
5.   False-branch actions
6. End If — WFControlFlowMode 2
```
