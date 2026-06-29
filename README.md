# Mentorly

Mentorly is a Flutter-based mobile application project structured as a modern cross-platform app foundation with UI theming, shared constants, and video-conferencing-oriented integrations. The repository is currently in an early scaffold state, but the organization is designed so a new developer can quickly understand where core app concerns live and how the main files relate to each other.

## Tech Stack

- Flutter SDK: Dart/Flutter application framework
- Language: Dart
- UI: Material Design with Flutter widgets
- Styling: custom theme tokens and Google Fonts support
- Internationalization: `intl` package
- Video/conference support: `zego_uikit_prebuilt_video_conference`
- Development tooling: `flutter_test` and `flutter_lints`

## Architecture Overview

The application follows a simple layered structure suited for a growing Flutter app:

1. App entry layer
   - The app starts from `lib/main.dart`.
   - `main()` initializes the app by calling `runApp()`.
   - `MyApp` serves as the root widget and defines the global app shell.

2. Presentation layer
   - The current UI is centered around the home screen defined in `lib/main.dart`.
   - The UI is built using Flutter widgets and Material components.

3. Theme and design system layer
   - `lib/theme/app_theme.dart` contains shared color constants and theme-related values.
   - This is the central place for app-wide design tokens such as primary, secondary, background, and text colors.

4. Shared configuration layer
   - `lib/utils/constants.dart` holds reusable configuration values.
   - In the current version, it includes the Zego configuration placeholders used by the video conferencing integration.

5. Platform layer
   - Android and iOS platform-specific setup lives in the `android/` and `ios/` folders.
   - These folders are generated and maintained by Flutter for native build support.

## Project Structure

```text
mentorly/
├── android/                  # Native Android project files
├── ios/                      # Native iOS project files
├── lib/
│   ├── main.dart             # App entry point and root widgets
│   ├── theme/
│   │   └── app_theme.dart    # Shared theme values and colors
│   └── utils/
│       └── constants.dart    # Shared config and service constants
├── test/                     # Widget and app-level tests
├── pubspec.yaml              # Flutter package metadata and dependencies
└── README.md                 # Project documentation
```

## File Responsibilities

- `lib/main.dart`
  - Entry point of the application.
  - Creates the root `MaterialApp`.
  - Defines the current home page widget and basic app behavior.

- `lib/theme/app_theme.dart`
  - Holds app-wide design constants.
  - Keeps colors and theme values centralized so UI changes remain consistent.

- `lib/utils/constants.dart`
  - Stores reusable constants and service configuration values.
  - Intended to be extended as the app grows and more modules need shared configuration.

- `pubspec.yaml`
  - Declares package dependencies and Flutter configuration.
  - Tracks key libraries such as video conferencing, Google Fonts, and internationalization support.

- `test/widget_test.dart`
  - Contains the default widget test scaffold for future regression testing.

## How the Main Files Connect

- `main.dart` is the orchestration point for the app shell.
- `app_theme.dart` provides style values that should be referenced by screens added later.
- `constants.dart` is meant to be consumed by services or feature modules that require shared configuration.
- `pubspec.yaml` supplies the dependencies that these modules rely on, including the video-conferencing SDK and styling packages.

## Extension Points for Future Development

As the app evolves, the project can grow naturally by adding feature-specific folders such as:

- `lib/screens/` for page-level UI
- `lib/widgets/` for reusable UI components
- `lib/models/` for data models
- `lib/services/` for API and platform integrations
- `lib/providers/` or `lib/controllers/` for state management

This structure keeps the current scaffold simple while leaving room for a larger app architecture as features are introduced.
