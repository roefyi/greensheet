# Host Grotesk Font Setup

This directory contains placeholder files for the Host Grotesk font family.

## Required Font Files

To use Host Grotesk throughout the app, you need to replace the placeholder files with the actual font files:

1. **HostGrotesk-Regular.otf** - Regular weight font file
2. **HostGrotesk-Medium.otf** - Medium weight font file  
3. **HostGrotesk-Bold.otf** - Bold weight font file

## How to Add Font Files

1. Obtain the Host Grotesk font files (.otf or .ttf format)
2. Replace the placeholder files in this directory with the actual font files
3. Make sure the font files are added to your Xcode project target
4. The fonts are already registered in Info.plist

## Font Usage

The app is configured to use Host Grotesk throughout via the `GreensheetTheme.swift` file:

- `titleFont` - 28pt Bold
- `headlineFont` - 20pt Semibold  
- `bodyFont` - 16pt Regular
- `captionFont` - 14pt Regular
- `smallFont` - 12pt Regular

## Alternative: System Font Fallback

If you don't have access to Host Grotesk, you can temporarily use the system font by updating `GreensheetTheme.swift` to use:

```swift
static let titleFont = Font.system(size: 28, weight: .bold, design: .default)
static let headlineFont = Font.system(size: 20, weight: .semibold, design: .default)
static let bodyFont = Font.system(size: 16, weight: .regular, design: .default)
static let captionFont = Font.system(size: 14, weight: .regular, design: .default)
static let smallFont = Font.system(size: 12, weight: .regular, design: .default)
``` 