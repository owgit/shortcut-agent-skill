# URL Schemes, CLI & Integration

## URL Schemes

### Run a Shortcut
```
shortcuts://run-shortcut?name=My%20Shortcut&input=text&text=hello%20world
```

| Parameter | Required | Description |
|-----------|----------|-------------|
| `name` | Yes | URL-encoded shortcut name |
| `input` | No | `text` or `clipboard` |
| `text` | No | URL-encoded input text (when input=text) |

### Run with x-callback-url (get result back)
```
shortcuts://x-callback-url/run-shortcut?name=Calculate%20Tip&input=text&text=24.99&x-success=myapp://success&x-cancel=myapp://cancel&x-error=myapp://error
```

| Parameter | Description |
|-----------|-------------|
| `x-success` | URL to open on success. Appends `?result=<output>` |
| `x-cancel` | URL to open if user cancels |
| `x-error` | URL to open on error. Appends `?errorMessage=<msg>` |

### Import a Shortcut
```
shortcuts://import-shortcut?url=<encoded-url>&name=<name>&silent=true
```

### Open/Create
```
shortcuts://open-shortcut?name=My%20Shortcut
shortcuts://create-shortcut
```

## macOS Command Line

### Run
```bash
shortcuts run "Shortcut Name"
shortcuts run "Shortcut Name" -i input.txt          # file input
shortcuts run "Shortcut Name" -i ~/Desktop/*.jpg     # wildcard
echo "hello" | shortcuts run "Shortcut Name"         # pipe input
```

### Run with output
```bash
shortcuts run "Name" -o output.txt                   # save to file
shortcuts run "Name" --output-type public.plain-text  # specify UTI
shortcuts run "Name" -i file.jpg | other-command      # pipe output
```

### List, View, Sign
```bash
shortcuts list                                       # list all shortcuts
shortcuts view "Name"                                # open in editor
shortcuts sign --mode anyone -i in.shortcut -o out.shortcut
```

## Variable Best Practices (from Apple docs)

### Prefer Magic Variables over Set Variable
Magic Variables automatically capture the output of each action. Using Set Variable lengthens shortcuts and makes them harder to read. In most cases, Magic Variables do the same work more concisely.

**When to use Set Variable:**
- When the same value is needed much later in the shortcut (many actions apart)
- When building up a list with Add to Variable across iterations

**When to use Magic Variables:**
- For passing output between adjacent or nearby actions (default approach)
- For referencing any previous action's output directly

### Repeat with Each — Automatic Result Collection
The output of a Repeat with Each loop is automatically collected in "Repeat Results". No need to manually append to a variable inside the loop. Place actions inside the loop, and the final output of each iteration becomes one item in Repeat Results.

### Run JavaScript on Webpage
- **Requires Safari share sheet input** — must be run from share sheet in Safari, SFSafariViewController, or ASWebAuthenticationSession
- Can inject additional data via Magic Variables
- Input is the active webpage, output is whatever the JS returns via `completion()`

## Personal Automation Triggers

Personal automations run based on events (not manual invocation):

| Trigger Type | Examples |
|-------------|----------|
| **Time** | Time of day, specific date |
| **Location** | Arrive at / leave a place |
| **App** | When app is opened/closed |
| **Settings** | Airplane mode, DND, Low Power Mode toggled |
| **Communication** | Receive message/email from specific person |
| **Travel** | Connect to CarPlay, NFC tag scanned |
| **Battery** | Battery level reaches threshold |

Personal automations are device-specific (backed up to iCloud but not synced).
Some can run without user confirmation ("Run Immediately").
