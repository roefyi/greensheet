# Host Grotesk Font Setup Guide

## Current Status
✅ Font files are present in the Fonts directory
✅ Font registration has been added to the project configuration
✅ Theme has been updated to use the variable font
⚠️ Fonts need to be tested after building the app

## To Add Host Grotesk Fonts

### 1. Obtain Font Files
You need the following Host Grotesk font files:
- `HostGrotesk-Regular.otf` (or `.ttf`)
- `HostGrotesk-Medium.otf` (or `.ttf`)
- `HostGrotesk-Bold.otf` (or `.ttf`)

### 2. Add Font Files to Project
1. Replace the placeholder files in `Greensheet/Fonts/` with actual font files
2. In Xcode, drag the font files into the project navigator
3. Make sure "Add to target" is checked for the Greensheet target
4. Verify the font files appear in the "Copy Bundle Resources" build phase

### 3. Update GreensheetTheme.swift
The font definitions in `GreensheetTheme.swift` have been updated to use the variable font:

```swift
// MARK: - Typography
static let titleFont = Font.custom("HostGrotesk-VariableFont_wght", size: 28).weight(.bold)
static let headlineFont = Font.custom("HostGrotesk-VariableFont_wght", size: 20).weight(.semibold)
static let bodyFont = Font.custom("HostGrotesk-VariableFont_wght", size: 16).weight(.regular)
static let captionFont = Font.custom("HostGrotesk-VariableFont_wght", size: 14).weight(.regular)
static let smallFont = Font.custom("HostGrotesk-VariableFont_wght", size: 12).weight(.regular)
```

### 4. Register Fonts in Project Configuration
Font registration has been added to the project configuration in both Debug and Release builds:

```
INFOPLIST_KEY_UIAppFonts = (
    "Fonts/HostGrotesk-Regular.ttf",
    "Fonts/HostGrotesk-Medium.ttf",
    "Fonts/HostGrotesk-Bold.ttf",
    "Fonts/HostGrotesk-VariableFont_wght.ttf",
);
```

### 5. Verify Font Names
The exact font names may vary. To find the correct font names:
1. Add the fonts to your system
2. Use Font Book or similar tool to check the exact font names
3. Update the `Font.custom()` calls with the correct names

### 6. Test the Implementation
1. Build and run the app
2. Check that all text elements use Host Grotesk
3. Verify different font weights display correctly

## Font Usage Throughout the App

The following components use the theme fonts:
- **WelcomeScreen**: Title and body text
- **HomeDashboardScreen**: Headers, course names, and stats
- **CourseSelectionScreen**: Course listings and search
- **ScorecardScreen**: Score display and hole information
- **All buttons and UI elements**: Via button styles

## Troubleshooting

### Font Not Loading
- Check that font files are in the correct location
- Verify font files are added to the target
- Check Info.plist registration
- Use `UIFont.familyNames` to debug available fonts

### Wrong Font Displaying
- Verify the exact font name in Font Book
- Check that the font weight is supported
- Ensure the font file contains the required weight

### Build Errors
- Make sure font files are valid
- Check file permissions
- Verify file paths in Info.plist

## Current Fallback
Until Host Grotesk fonts are added, the app uses system fonts:
- SF Pro Display (iOS default)
- Maintains the same sizing and weight hierarchy
- Ensures consistent typography across the app 