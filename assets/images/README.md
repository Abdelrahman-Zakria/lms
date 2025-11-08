# Assets Directory

This directory contains the app's assets including images, icons, and fonts.

## Required Files

### Images
- `lmsLogo.png` - The main app logo (512x512 pixels recommended)
  - Used for app icon and splash screen
  - Should be a PNG file with transparent background
  - Place the actual logo file here

### Icons
- Place any custom icons here

### Fonts
- Cairo font family files are already configured in pubspec.yaml
- Place any additional font files here

## Setup Instructions

1. Add your `lmsLogo.png` file to this directory
2. Run `flutter pub get` to install dependencies
3. Run `flutter pub run flutter_launcher_icons:main` to generate app icons
4. Run `flutter pub run flutter_native_splash:create` to generate splash screen
5. Build the app for release

## Note

The app is designed to work with a placeholder logo and will show a school icon as fallback if the logo is not found.


