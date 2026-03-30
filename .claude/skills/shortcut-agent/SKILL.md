---
name: shortcut-agent
description: "This skill should be used when the user asks to \"create a shortcut\", \"make an Apple Shortcut\", \"build a Siri shortcut\", \"generate a shortcut file\", \"automate my iPhone\", or needs to convert a natural language description into an installable Apple Shortcuts .shortcut file. Covers: iOS automation, Siri Shortcuts, workflow generation, shortcut actions, plist generation, and shortcut signing."
metadata:
  version: 0.1.0
---

# Shortcut Agent

Generate Apple Shortcuts (.shortcut files) from natural language. Parse the user's automation request, map it to Shortcut actions, produce valid plist XML, sign it, and open it for installation.

## Workflow

### Step 1: Understand the Request

Parse the user's description and identify:

- **Goal** — what the shortcut achieves end-to-end
- **Actions** — discrete steps (fetch URL, show notification, send message, etc.)
- **Control flow** — conditions, loops, or menus
- **Variables** — data flowing between actions
- **Inputs** — runtime user input or share sheet data
- **Trigger** — manual, automation, widget, or share sheet

Present the planned action chain to the user before generating.

### Step 2: Choose Actions

Use the decision framework below to select the right actions. For full identifiers and parameters, see `references/actions.md`.

### Step 3: Generate Plist XML

Write the complete plist XML to `output/<name>.plist` using the Write tool. Follow the format in `references/plist-format.md`.

### Step 4: Sign and Install

```bash
bash scripts/sign_and_open.sh "<name>"
```

This validates, signs (via `shortcuts sign --mode anyone`), and opens the shortcut in the Shortcuts app.

---

## Decision Framework

Use this to select the right action for each step:

### "I need to get data"

| Need | Action |
|------|--------|
| Ask the user for text/number/URL | `is.workflow.actions.ask` |
| Fetch a web API (GET/POST) | `is.workflow.actions.downloadurl` |
| Read clipboard | `is.workflow.actions.getclipboard` |
| Get current location | `is.workflow.actions.getcurrentlocation` |
| Get battery level | `is.workflow.actions.getbatterylevel` |
| Get device info | `is.workflow.actions.getdevicedetails` |
| Get current date | Use variable type `CurrentDate` |
| Accept share sheet input | Use variable type `ExtensionInput` |

### "I need to show/send output"

| Need | Action |
|------|--------|
| Display result on screen | `is.workflow.actions.showresult` |
| Show a notification | `is.workflow.actions.notification` |
| Show alert with buttons | `is.workflow.actions.alert` |
| Send iMessage/SMS | `is.workflow.actions.sendmessage` |
| Send email | `is.workflow.actions.sendemail` |
| Speak text aloud | `is.workflow.actions.speaktext` |
| Copy to clipboard | `is.workflow.actions.setclipboard` |
| Share via share sheet | `is.workflow.actions.share` |

### "I need to transform data"

| Need | Action |
|------|--------|
| Create/manipulate text | `is.workflow.actions.gettext` |
| Parse JSON response | `is.workflow.actions.getvalueforkey` |
| Build a dictionary/JSON | `is.workflow.actions.dictionary` |
| Create a list | `is.workflow.actions.list` |
| Math operations | `is.workflow.actions.math` |
| Format a date | `is.workflow.actions.format.date` |
| Find/replace in text | `is.workflow.actions.text.replace` |
| Encode/decode URL | `is.workflow.actions.urlencode` |
| Encode/decode Base64 | `is.workflow.actions.base64encode` |

### "I need control flow"

| Need | Action |
|------|--------|
| If/else branching | `is.workflow.actions.conditional` |
| Repeat N times | `is.workflow.actions.repeat.count` |
| Loop over a list | `is.workflow.actions.repeat.each` |
| Present a menu of choices | `is.workflow.actions.choosefrommenu` |
| Stop the shortcut | `is.workflow.actions.exit` |
| Wait/delay | `is.workflow.actions.delay` |

### "I need to control the device"

| Need | Action |
|------|--------|
| Open a URL/website | `is.workflow.actions.openurl` |
| Open an app | `is.workflow.actions.openapp` |
| Set brightness/volume | `is.workflow.actions.setbrightness` / `setvolume` |
| Toggle Bluetooth/Wi-Fi/Airplane | `bluetooth.set` / `wifi.set` / `airplanemode.set` |
| Set Do Not Disturb | `is.workflow.actions.dnd.set` |
| Create calendar event | `is.workflow.actions.addnewevent` |
| Create reminder | `is.workflow.actions.addnewreminder` |
| Run another shortcut | `is.workflow.actions.runworkflow` |

---

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
2. If (condition)
3.   True-branch actions
4. Otherwise
5.   False-branch actions
6. End If
```

### Menu-Driven

```
1. Choose from Menu (options)
2. Case A → actions
3. Case B → actions
4. End Menu
```

---

## Variable Best Practices

- **Prefer Magic Variables** over Set Variable — Magic Variables auto-capture each action's output. Set Variable lengthens shortcuts and reduces readability.
- **Use Set Variable only** when the same value is needed many actions later, or when building a list with Add to Variable across loop iterations.
- **Repeat with Each** automatically collects output in "Repeat Results" — no need to manually append inside the loop.
- **Run JavaScript on Webpage** requires Safari share sheet input — cannot be used standalone.

---

## Critical Rules

1. **Unique UUIDs** — every action needs its own UUID, uppercase hex: `XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX`
2. **WFControlFlowMode is `<integer>`** — never `<string>`. 0=start, 1=middle/else, 2=end.
3. **GroupingIdentifier** — same UUID links start/middle/end of each control flow block
4. **Variable references** — use `OutputUUID` pointing to the producing action's UUID
5. **Inline variables** — use `&#xFFFC;` placeholder in strings, map in `attachmentsByRange` with `{position, 1}`
6. **Signing requires `.shortcut` extension** — the helper script handles this automatically
7. **Present plan first** — always show the user the action chain before generating XML
8. **Test via CLI** — after installing, verify with `shortcuts run "Name"` on macOS

---

## Resources

- **Action identifiers and parameters**: `references/actions.md`
- **Plist format, variable system, control flow XML**: `references/plist-format.md`
- **URL schemes, CLI usage, automation triggers**: `references/url-schemes-and-cli.md`
- **Example shortcuts**: `examples/` directory (hello_world, ask_and_notify, api_call)
- **Signing script**: `scripts/sign_and_open.sh`
