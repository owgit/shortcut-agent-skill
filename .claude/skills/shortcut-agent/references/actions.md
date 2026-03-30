# Apple Shortcuts Action Reference

Complete reference of action identifiers and their parameters.

## Text & String

| Action | Identifier | Key Parameters |
|--------|-----------|----------------|
| Text | `is.workflow.actions.gettext` | `WFTextActionText` |
| Combine Text | `is.workflow.actions.text.combine` | `WFTextSeparator`, `text` |
| Replace Text | `is.workflow.actions.text.replace` | `WFInput`, `WFReplaceTextFind`, `WFReplaceTextReplace`, `WFReplaceTextRegularExpression` (bool) |
| Match Text | `is.workflow.actions.text.match` | `WFMatchTextPattern`, `WFMatchTextCaseSensitive` |
| Split Text | `is.workflow.actions.text.split` | `WFTextSeparator`, `WFTextCustomSeparator` |
| Change Case | `is.workflow.actions.text.changecase` | `WFCaseType` (UPPERCASE, lowercase, Capitalize) |
| Count | `is.workflow.actions.count` | `WFCountType` (Items, Characters, Words, Sentences, Lines) |

## User Interaction

| Action | Identifier | Key Parameters |
|--------|-----------|----------------|
| Ask for Input | `is.workflow.actions.ask` | `WFAskActionPrompt`, `WFAskActionDefaultAnswer`, `WFInputType` (Text, Number, URL, Date, Time, Date and Time) |
| Show Result | `is.workflow.actions.showresult` | `Text` |
| Show Alert | `is.workflow.actions.alert` | `WFAlertActionTitle`, `WFAlertActionMessage`, `WFAlertActionCancelButtonShown` |
| Show Notification | `is.workflow.actions.notification` | `WFNotificationActionBody`, `WFNotificationActionTitle`, `WFNotificationActionSound` |
| Speak Text | `is.workflow.actions.speaktext` | `WFSpeakTextRate`, `WFSpeakTextLanguage` |
| Choose from List | `is.workflow.actions.choosefromlist` | `WFChooseFromListActionPrompt` |

## Variables

| Action | Identifier | Key Parameters |
|--------|-----------|----------------|
| Set Variable | `is.workflow.actions.setvariable` | `WFVariableName`, `WFInput` |
| Get Variable | `is.workflow.actions.getvariable` | `WFVariable` |
| Add to Variable | `is.workflow.actions.appendvariable` | `WFVariableName`, `WFInput` |
| Nothing | `is.workflow.actions.nothing` | (pass-through) |
| Comment | `is.workflow.actions.comment` | `WFCommentActionText` |

## Web & HTTP

| Action | Identifier | Key Parameters |
|--------|-----------|----------------|
| Get Contents of URL | `is.workflow.actions.downloadurl` | `WFURL` or `WFInput`, `WFHTTPMethod` (GET/POST/PUT/PATCH/DELETE), `WFHTTPHeaders`, `WFHTTPBodyType` (JSON/Form/File), `WFJSONValues`, `WFFormValues`, `WFRequestVariable` |
| URL | `is.workflow.actions.url` | `WFURLActionURL` |
| Open URL | `is.workflow.actions.openurl` | `WFInput` |
| URL Encode | `is.workflow.actions.urlencode` | `WFInput`, `WFEncodeMode` (Encode/Decode) |
| Get Web Page Contents | `is.workflow.actions.getwebpagecontents` | `WFInput` |
| Run JavaScript on Web Page | `is.workflow.actions.runjavascriptonwebpage` | `WFJavaScript` |

## Data & Collections

| Action | Identifier | Key Parameters |
|--------|-----------|----------------|
| Dictionary | `is.workflow.actions.dictionary` | `WFItems` (WFDictionaryFieldValue) |
| Get Dictionary Value | `is.workflow.actions.getvalueforkey` | `WFDictionaryKey`, `WFGetDictionaryValueType` (Value/All Keys/All Values) |
| Set Dictionary Value | `is.workflow.actions.setvalueforkey` | `WFDictionaryKey`, `WFDictionaryValue` |
| List | `is.workflow.actions.list` | `WFItems` |
| Get Item from List | `is.workflow.actions.getitemfromlist` | `WFItemSpecifier` (First Item/Last Item/Random Item/Item At Index), `WFItemIndex` |
| Number | `is.workflow.actions.number` | `WFNumberActionNumber` |
| Random Number | `is.workflow.actions.number.random` | `WFRandomNumberMinimum`, `WFRandomNumberMaximum` |
| Calculate | `is.workflow.actions.math` | `WFMathOperation` (+, -, x, /, Modulus), `WFMathOperand` |
| Calculate Statistics | `is.workflow.actions.statistics` | `WFStatisticsOperation` (Average, Minimum, Maximum, Sum, Median, Mode, Range, Standard Deviation) |
| Base64 Encode | `is.workflow.actions.base64encode` | `WFEncodeMode` (Encode/Decode) |
| Generate Hash | `is.workflow.actions.hash` | `WFHashType` (MD5, SHA1, SHA256, SHA512) |

## Date & Time

| Action | Identifier | Key Parameters |
|--------|-----------|----------------|
| Date | `is.workflow.actions.date` | `WFDateActionDate` |
| Format Date | `is.workflow.actions.format.date` | `WFDateFormatString`, `WFDateFormatStyle` |
| Get Time Between Dates | `is.workflow.actions.gettimebetweendates` | `WFTimeUntilUnit` (Seconds/Minutes/Hours/Days/Weeks/Months/Years) |
| Wait | `is.workflow.actions.delay` | `WFDelayTime` (seconds) |

## Device & System

| Action | Identifier | Key Parameters |
|--------|-----------|----------------|
| Get Battery Level | `is.workflow.actions.getbatterylevel` | — |
| Get Device Details | `is.workflow.actions.getdevicedetails` | `WFDeviceDetail` (Device Name/System Version/Model/etc.) |
| Get IP Address | `is.workflow.actions.getipaddress` | `WFIPAddressSourceOption` (Local/External), `WFIPAddressTypeOption` (IPv4/IPv6) |
| Set Brightness | `is.workflow.actions.setbrightness` | `WFBrightness` (0.0-1.0) |
| Set Volume | `is.workflow.actions.setvolume` | `WFVolume` (0.0-1.0) |
| Toggle Flashlight | `is.workflow.actions.flashlight` | `WFFlashlightSetting` (Toggle/On/Off) |
| Set Bluetooth | `is.workflow.actions.bluetooth.set` | `WFBluetoothSetting` (true/false) |
| Set Wi-Fi | `is.workflow.actions.wifi.set` | `WFWiFiSetting` (true/false) |
| Set Airplane Mode | `is.workflow.actions.airplanemode.set` | `WFAirplaneModeSetting` (true/false) |
| Set Do Not Disturb | `is.workflow.actions.dnd.set` | `Enabled` (true/false) |
| Set Low Power Mode | `is.workflow.actions.lowpowermode.set` | `WFLowPowerModeSetting` (true/false) |
| Vibrate | `is.workflow.actions.vibrate` | — |
| Get Current Location | `is.workflow.actions.getcurrentlocation` | — |

## Calendar & Reminders

| Action | Identifier | Key Parameters |
|--------|-----------|----------------|
| Add New Event | `is.workflow.actions.addnewevent` | `WFCalendarItemTitle`, `WFCalendarItemStartDate`, `WFCalendarItemEndDate`, `WFCalendarItemLocation`, `WFCalendarItemNotes`, `WFCalendarItemCalendar` |
| Find Calendar Events | `is.workflow.actions.filter.calendarevents` | `WFContentItemFilter` (predicate) |
| Add New Reminder | `is.workflow.actions.addnewreminder` | `WFCalendarItemTitle`, `WFCalendarItemDueDate`, `WFCalendarItemNotes`, `WFReminderList` |
| Find Reminders | `is.workflow.actions.filter.reminders` | `WFContentItemFilter` |

## Media & Photos

| Action | Identifier | Key Parameters |
|--------|-----------|----------------|
| Take Photo | `is.workflow.actions.takephoto` | `WFCameraCaptureShowPreview` |
| Get Latest Photos | `is.workflow.actions.getlastphoto` | `WFGetLatestPhotoCount` |
| Get Last Screenshot | `is.workflow.actions.getlastscreenshot` | — |
| Resize Image | `is.workflow.actions.image.resize` | `WFImageResizeWidth`, `WFImageResizeHeight` |
| Crop Image | `is.workflow.actions.image.crop` | `WFImageCropPosition`, `WFImageCropWidth`, `WFImageCropHeight` |
| Play Sound | `is.workflow.actions.playsound` | — |
| Play/Pause | `is.workflow.actions.pausemusic` | `WFPlayPauseBehavior` (Play/Pause/Toggle) |

## Files & Sharing

| Action | Identifier | Key Parameters |
|--------|-----------|----------------|
| Save File | `is.workflow.actions.documentpicker.save` | `WFFileDestinationPath`, `WFSaveFileOverwrite` |
| Get File | `is.workflow.actions.documentpicker.open` | `WFFileStorageService`, `WFGetFilePath` |
| AirDrop | `is.workflow.actions.airdropdocument` | — |
| Share | `is.workflow.actions.share` | — |
| Quick Look | `is.workflow.actions.previewdocument` | — |
| Make ZIP | `is.workflow.actions.makezip` | `WFArchiveName` |
| Copy to Clipboard | `is.workflow.actions.setclipboard` | `WFInput` |
| Get Clipboard | `is.workflow.actions.getclipboard` | — |

## Communication

| Action | Identifier | Key Parameters |
|--------|-----------|----------------|
| Send Message | `is.workflow.actions.sendmessage` | `WFSendMessageContent`, `WFSendMessageActionRecipients` |
| Send Email | `is.workflow.actions.sendemail` | `WFSendEmailActionToRecipients`, `WFSendEmailActionSubject`, `WFSendEmailActionBody` |
| FaceTime | `com.apple.facetime.facetime` | `WFSelectedContactHandle` |
| Phone Call | `com.apple.mobilephone.call` | `WFSelectedContactHandle` |

## Shortcuts

| Action | Identifier | Key Parameters |
|--------|-----------|----------------|
| Run Shortcut | `is.workflow.actions.runworkflow` | `WFWorkflowName`, `WFInput` |
| Stop Shortcut | `is.workflow.actions.exit` | `WFResult` |
| Get My Shortcuts | `is.workflow.actions.getmyworkflows` | — |
| Open App | `is.workflow.actions.openapp` | `WFAppIdentifier` (bundle ID), `WFSelectedApp` |

## Detection & Conversion

| Action | Identifier | Key Parameters |
|--------|-----------|----------------|
| Get Text from Input | `is.workflow.actions.detect.text` | — |
| Get URLs from Input | `is.workflow.actions.detect.link` | — |
| Get Dates from Input | `is.workflow.actions.detect.date` | — |
| Get Dictionary from Input | `is.workflow.actions.detect.dictionary` | — |
| Get Name | `is.workflow.actions.getitemname` | — |
| Get Type | `is.workflow.actions.getitemtype` | — |

## Control Flow

| Action | Identifier | Key Parameters |
|--------|-----------|----------------|
| If/Otherwise | `is.workflow.actions.conditional` | `WFCondition`, `WFConditionalActionString`, `WFInput`, `GroupingIdentifier`, `WFControlFlowMode` |
| Repeat Count | `is.workflow.actions.repeat.count` | `WFRepeatCount`, `GroupingIdentifier`, `WFControlFlowMode` |
| Repeat with Each | `is.workflow.actions.repeat.each` | `WFInput`, `GroupingIdentifier`, `WFControlFlowMode` |
| Choose from Menu | `is.workflow.actions.choosefrommenu` | `WFMenuItems`, `WFMenuPrompt`, `WFMenuItemTitle`, `GroupingIdentifier`, `WFControlFlowMode` |
