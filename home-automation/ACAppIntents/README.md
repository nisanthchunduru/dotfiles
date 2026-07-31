# AC Siri App Intents (macOS)

This folder contains reusable `AppIntents` for:

- Turn AC on
- Turn AC off
- Set AC temperature

The intents call your existing SmartThings script:

`~/repos/dotfiles/scripts/samsung_ac.rb`

## Add to your app target

1. Copy `ACControlIntents.swift` into a macOS app target that already uses `AppIntents`.
2. Ensure your app exposes `ACAppShortcutsProvider` (the file already provides it).
3. Build and run the app once, then open Shortcuts/Siri and search for:
   - `Turn On AC`
   - `Turn Off AC`
   - `Set AC Temperature`

## Optional installer script

You can copy the Swift file into your app source folder with:

```bash
./home-automation/ACAppIntents/install.sh ~/repos/my-mac-app/MyMacApp
```

If you want to overwrite an existing `ACControlIntents.swift`:

```bash
./home-automation/ACAppIntents/install.sh --force ~/repos/my-mac-app/MyMacApp
```

## Optional: override script location

If your script is not at the default location, set this user default from your app startup:

```swift
UserDefaults.standard.set("/absolute/path/to/samsung_ac.rb", forKey: "ac_script_path")
```

## Notes

- These intents are wrapped in `#if os(macOS)` because they use `Process` to call Ruby.
- If you want iOS support, switch `ACCommandRunner` to a direct SmartThings API client instead of shelling out.
