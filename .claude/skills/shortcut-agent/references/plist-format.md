# Apple Shortcuts Plist Format Specification

## Root Structure

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>WFWorkflowActions</key>
  <array>
    <!-- Array of action dictionaries -->
  </array>
  <key>WFWorkflowClientVersion</key>
  <string>2700.0.4</string>
  <key>WFWorkflowMinimumClientVersion</key>
  <integer>900</integer>
  <key>WFWorkflowMinimumClientVersionString</key>
  <string>900</string>
  <key>WFWorkflowIcon</key>
  <dict>
    <key>WFWorkflowIconGlyphNumber</key>
    <integer>59511</integer>
    <key>WFWorkflowIconStartColor</key>
    <integer>4282601983</integer>
  </dict>
  <key>WFWorkflowInputContentItemClasses</key>
  <array>
    <string>WFStringContentItem</string>
  </array>
  <key>WFWorkflowOutputContentItemClasses</key>
  <array/>
  <key>WFWorkflowTypes</key>
  <array/>
  <key>WFWorkflowHasOutputFallback</key>
  <false/>
  <key>WFWorkflowImportQuestions</key>
  <array/>
</dict>
</plist>
```

## Icon Glyphs

| Glyph | Number |
|-------|--------|
| Globe | 59511 |
| Star | 59446 |
| Heart | 59448 |
| Gear | 59458 |
| Document | 59493 |
| Folder | 59495 |
| Play | 59477 |
| Message | 59412 |
| Lightning | 59565 |
| Wand | 59544 |

## Icon Colors (ARGB Integer)

| Color | Integer |
|-------|---------|
| Blue | 4282601983 |
| Green | 4292093695 |
| Purple | 4285887861 |
| Red | 4282071867 |
| Orange | 4292940544 |
| Gray | 2846468607 |

## Input Content Item Classes

Use in `WFWorkflowInputContentItemClasses` based on what the shortcut accepts:

- `WFStringContentItem` — Text
- `WFURLContentItem` — URLs
- `WFImageContentItem` — Images
- `WFContactContentItem` — Contacts
- `WFGenericFileContentItem` — Files
- `WFDateContentItem` — Dates
- `WFLocationContentItem` — Locations
- `WFEmailAddressContentItem` — Email addresses
- `WFPhoneNumberContentItem` — Phone numbers

## Action Structure

Each action in the `WFWorkflowActions` array:

```xml
<dict>
  <key>WFWorkflowActionIdentifier</key>
  <string>is.workflow.actions.ACTIONNAME</string>
  <key>WFWorkflowActionParameters</key>
  <dict>
    <key>UUID</key>
    <string>XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX</string>
    <!-- action-specific parameters -->
  </dict>
</dict>
```

Always generate unique UUIDs for each action. Use uppercase hex format.

## Variable Reference System

### Plain Text (no variables)

```xml
<key>WFTextActionText</key>
<dict>
  <key>Value</key>
  <dict>
    <key>string</key>
    <string>Hello World!</string>
  </dict>
  <key>WFSerializationType</key>
  <string>WFTextTokenString</string>
</dict>
```

### Text with Embedded Variables

Uses U+FFFC (Object Replacement Character `&#xFFFC;`) as placeholder. The `attachmentsByRange` maps each placeholder position to a variable reference:

```xml
<key>Text</key>
<dict>
  <key>Value</key>
  <dict>
    <key>attachmentsByRange</key>
    <dict>
      <key>{0, 1}</key>
      <dict>
        <key>OutputName</key>
        <string>Text</string>
        <key>OutputUUID</key>
        <string>UUID-OF-SOURCE-ACTION</string>
        <key>Type</key>
        <string>ActionOutput</string>
      </dict>
    </dict>
    <key>string</key>
    <string>&#xFFFC; is your result</string>
  </dict>
  <key>WFSerializationType</key>
  <string>WFTextTokenString</string>
</dict>
```

### Single Variable Reference (no surrounding text)

```xml
<key>WFInput</key>
<dict>
  <key>Value</key>
  <dict>
    <key>OutputName</key>
    <string>Text</string>
    <key>OutputUUID</key>
    <string>UUID-OF-SOURCE-ACTION</string>
    <key>Type</key>
    <string>ActionOutput</string>
  </dict>
  <key>WFSerializationType</key>
  <string>WFTextTokenAttachment</string>
</dict>
```

### Variable Types

| Type | Description |
|------|-------------|
| `ActionOutput` | Output from a previous action (by UUID) |
| `Variable` | Named variable from Set Variable action |
| `CurrentDate` | Current date/time |
| `Clipboard` | Clipboard contents |
| `Ask` | Ask user at runtime |
| `ExtensionInput` | Share sheet input |
| `DeviceDetails` | Device information |

### Named Variables (Set Variable / Get Variable)

**Set Variable:**
```xml
<dict>
  <key>WFWorkflowActionIdentifier</key>
  <string>is.workflow.actions.setvariable</string>
  <key>WFWorkflowActionParameters</key>
  <dict>
    <key>UUID</key>
    <string>SET-VAR-UUID</string>
    <key>WFVariableName</key>
    <string>MyVariable</string>
    <key>WFInput</key>
    <dict>
      <key>Value</key>
      <dict>
        <key>OutputName</key>
        <string>Text</string>
        <key>OutputUUID</key>
        <string>UUID-OF-VALUE-SOURCE</string>
        <key>Type</key>
        <string>ActionOutput</string>
      </dict>
      <key>WFSerializationType</key>
      <string>WFTextTokenAttachment</string>
    </dict>
  </dict>
</dict>
```

**Get Variable:**
```xml
<dict>
  <key>WFWorkflowActionIdentifier</key>
  <string>is.workflow.actions.getvariable</string>
  <key>WFWorkflowActionParameters</key>
  <dict>
    <key>UUID</key>
    <string>GET-VAR-UUID</string>
    <key>WFVariable</key>
    <dict>
      <key>Value</key>
      <dict>
        <key>OutputName</key>
        <string>MyVariable</string>
        <key>OutputUUID</key>
        <string>SET-VAR-UUID</string>
        <key>Type</key>
        <string>Variable</string>
      </dict>
      <key>WFSerializationType</key>
      <string>WFTextTokenAttachment</string>
    </dict>
  </dict>
</dict>
```

### Aggrandizements (Property Access)

To access a property of a variable (e.g., get a dictionary key):

```xml
<key>Aggrandizements</key>
<array>
  <dict>
    <key>Type</key>
    <string>WFDictionaryValueVariableAggrandizement</string>
    <key>DictionaryKey</key>
    <string>fieldName</string>
  </dict>
</array>
```

Types: `WFPropertyVariableAggrandizement`, `WFDictionaryValueVariableAggrandizement`, `WFCoercionVariableAggrandizement` (with `CoercionItemClass`).

## Control Flow

All control flow uses `GroupingIdentifier` (shared UUID) and `WFControlFlowMode` (0=start, 1=middle/else, 2=end).

### If / Otherwise / End If

```xml
<!-- IF (mode 0) -->
<dict>
  <key>WFWorkflowActionIdentifier</key>
  <string>is.workflow.actions.conditional</string>
  <key>WFWorkflowActionParameters</key>
  <dict>
    <key>UUID</key>
    <string>IF-UUID</string>
    <key>GroupingIdentifier</key>
    <string>GROUP-UUID</string>
    <key>WFControlFlowMode</key>
    <integer>0</integer>
    <key>WFCondition</key>
    <string>Equals</string>
    <key>WFConditionalActionString</key>
    <string>comparison value</string>
    <key>WFInput</key>
    <dict>
      <key>Value</key>
      <dict>
        <key>OutputName</key>
        <string>Text</string>
        <key>OutputUUID</key>
        <string>UUID-OF-VARIABLE-TO-TEST</string>
        <key>Type</key>
        <string>ActionOutput</string>
      </dict>
      <key>WFSerializationType</key>
      <string>WFTextTokenAttachment</string>
    </dict>
  </dict>
</dict>
<!-- THEN actions go here -->

<!-- OTHERWISE (mode 1) -->
<dict>
  <key>WFWorkflowActionIdentifier</key>
  <string>is.workflow.actions.conditional</string>
  <key>WFWorkflowActionParameters</key>
  <dict>
    <key>UUID</key>
    <string>ELSE-UUID</string>
    <key>GroupingIdentifier</key>
    <string>GROUP-UUID</string>
    <key>WFControlFlowMode</key>
    <integer>1</integer>
  </dict>
</dict>
<!-- ELSE actions go here -->

<!-- END IF (mode 2) -->
<dict>
  <key>WFWorkflowActionIdentifier</key>
  <string>is.workflow.actions.conditional</string>
  <key>WFWorkflowActionParameters</key>
  <dict>
    <key>UUID</key>
    <string>ENDIF-UUID</string>
    <key>GroupingIdentifier</key>
    <string>GROUP-UUID</string>
    <key>WFControlFlowMode</key>
    <integer>2</integer>
  </dict>
</dict>
```

**Condition operators:** `Equals`, `Contains`, `Begins With`, `Ends With`, `Is Greater Than`, `Is Less Than`, `Has Any Value`, `Does Not Have Any Value`

### Repeat (Count)

```xml
<!-- REPEAT START (mode 0) -->
<dict>
  <key>WFWorkflowActionIdentifier</key>
  <string>is.workflow.actions.repeat.count</string>
  <key>WFWorkflowActionParameters</key>
  <dict>
    <key>UUID</key>
    <string>REPEAT-UUID</string>
    <key>GroupingIdentifier</key>
    <string>REPEAT-GROUP-UUID</string>
    <key>WFControlFlowMode</key>
    <integer>0</integer>
    <key>WFRepeatCount</key>
    <integer>5</integer>
  </dict>
</dict>
<!-- Loop body actions here -->

<!-- REPEAT END (mode 2) -->
<dict>
  <key>WFWorkflowActionIdentifier</key>
  <string>is.workflow.actions.repeat.count</string>
  <key>WFWorkflowActionParameters</key>
  <dict>
    <key>UUID</key>
    <string>REPEAT-END-UUID</string>
    <key>GroupingIdentifier</key>
    <string>REPEAT-GROUP-UUID</string>
    <key>WFControlFlowMode</key>
    <integer>2</integer>
  </dict>
</dict>
```

### Repeat with Each

```xml
<!-- REPEAT EACH START (mode 0) -->
<dict>
  <key>WFWorkflowActionIdentifier</key>
  <string>is.workflow.actions.repeat.each</string>
  <key>WFWorkflowActionParameters</key>
  <dict>
    <key>UUID</key>
    <string>FOREACH-UUID</string>
    <key>GroupingIdentifier</key>
    <string>FOREACH-GROUP-UUID</string>
    <key>WFControlFlowMode</key>
    <integer>0</integer>
    <key>WFInput</key>
    <dict>
      <key>Value</key>
      <dict>
        <key>OutputName</key>
        <string>List</string>
        <key>OutputUUID</key>
        <string>UUID-OF-LIST</string>
        <key>Type</key>
        <string>ActionOutput</string>
      </dict>
      <key>WFSerializationType</key>
      <string>WFTextTokenAttachment</string>
    </dict>
  </dict>
</dict>
<!-- Use "Repeat Item" magic variable (OutputUUID = FOREACH-UUID, OutputName = "Repeat Item") -->

<!-- REPEAT EACH END (mode 2) -->
<dict>
  <key>WFWorkflowActionIdentifier</key>
  <string>is.workflow.actions.repeat.each</string>
  <key>WFWorkflowActionParameters</key>
  <dict>
    <key>UUID</key>
    <string>FOREACH-END-UUID</string>
    <key>GroupingIdentifier</key>
    <string>FOREACH-GROUP-UUID</string>
    <key>WFControlFlowMode</key>
    <integer>2</integer>
  </dict>
</dict>
```

### Choose from Menu

```xml
<!-- MENU START (mode 0) -->
<dict>
  <key>WFWorkflowActionIdentifier</key>
  <string>is.workflow.actions.choosefrommenu</string>
  <key>WFWorkflowActionParameters</key>
  <dict>
    <key>UUID</key>
    <string>MENU-UUID</string>
    <key>GroupingIdentifier</key>
    <string>MENU-GROUP-UUID</string>
    <key>WFControlFlowMode</key>
    <integer>0</integer>
    <key>WFMenuItems</key>
    <array>
      <string>Option A</string>
      <string>Option B</string>
    </array>
    <key>WFMenuPrompt</key>
    <string>Choose an option:</string>
  </dict>
</dict>

<!-- CASE: Option A (mode 1) -->
<dict>
  <key>WFWorkflowActionIdentifier</key>
  <string>is.workflow.actions.choosefrommenu</string>
  <key>WFWorkflowActionParameters</key>
  <dict>
    <key>UUID</key>
    <string>CASE-A-UUID</string>
    <key>GroupingIdentifier</key>
    <string>MENU-GROUP-UUID</string>
    <key>WFControlFlowMode</key>
    <integer>1</integer>
    <key>WFMenuItemTitle</key>
    <string>Option A</string>
  </dict>
</dict>
<!-- Option A actions here -->

<!-- CASE: Option B (mode 1) -->
<dict>
  <key>WFWorkflowActionIdentifier</key>
  <string>is.workflow.actions.choosefrommenu</string>
  <key>WFWorkflowActionParameters</key>
  <dict>
    <key>UUID</key>
    <string>CASE-B-UUID</string>
    <key>GroupingIdentifier</key>
    <string>MENU-GROUP-UUID</string>
    <key>WFControlFlowMode</key>
    <integer>1</integer>
    <key>WFMenuItemTitle</key>
    <string>Option B</string>
  </dict>
</dict>
<!-- Option B actions here -->

<!-- MENU END (mode 2) -->
<dict>
  <key>WFWorkflowActionIdentifier</key>
  <string>is.workflow.actions.choosefrommenu</string>
  <key>WFWorkflowActionParameters</key>
  <dict>
    <key>UUID</key>
    <string>MENU-END-UUID</string>
    <key>GroupingIdentifier</key>
    <string>MENU-GROUP-UUID</string>
    <key>WFControlFlowMode</key>
    <integer>2</integer>
  </dict>
</dict>
```

## Dictionary Field Value

Used for HTTP headers, JSON bodies, and form data:

```xml
<key>WFHTTPHeaders</key>
<dict>
  <key>Value</key>
  <dict>
    <key>WFDictionaryFieldValueItems</key>
    <array>
      <dict>
        <key>WFItemType</key>
        <integer>0</integer>
        <key>WFKey</key>
        <dict>
          <key>Value</key>
          <dict>
            <key>string</key>
            <string>Content-Type</string>
          </dict>
          <key>WFSerializationType</key>
          <string>WFTextTokenString</string>
        </dict>
        <key>WFValue</key>
        <dict>
          <key>Value</key>
          <dict>
            <key>string</key>
            <string>application/json</string>
          </dict>
          <key>WFSerializationType</key>
          <string>WFTextTokenString</string>
        </dict>
      </dict>
    </array>
  </dict>
  <key>WFSerializationType</key>
  <string>WFDictionaryFieldValue</string>
</dict>
```

`WFItemType`: 0=Text, 1=Dictionary, 2=Array, 3=Number, 4=Boolean
