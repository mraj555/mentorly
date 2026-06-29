# Mentorly

Mentorly is a Flutter-based mobile app scaffold for an online-learning and class-scheduling experience. The current codebase is intentionally lightweight, but it already separates the app into clear layers for UI, state, domain models, theme, and platform integration.

This README is written for the next developer who needs to understand how the project is structured and how the main files connect to each other.

## Tech Stack

- Flutter SDK with Dart for cross-platform mobile application development
- Material 3 and Flutter widgets for the app UI
- Provider for state management and reactive UI updates
- Google Fonts for typography and theme polish
- Intl for date and time formatting utilities
- Cupertino Icons for iOS-style icons
- Zego prebuilt video conference UI and Zego Express Engine for future live-class integration
- Flutter test and Flutter lints for validation and code quality

## Architecture Overview

The project follows a simple layered structure that keeps the app easy to extend:

- UI layer: screens and widgets render the experience
- State layer: providers expose data and actions to the UI
- Domain layer: models describe the business objects used by the app
- Shared support layer: theme and constants provide reusable definitions
- Platform layer: Android and iOS folders host native build configuration

### Runtime Flow

1. `lib/main.dart` boots the app and creates the root provider container.
2. `HomeScreen` is mounted as the initial screen and listens to `ClassProvider`.
3. `ClassProvider` seeds sample `OnlineClass` data and exposes filtered lists such as live, upcoming, and completed classes.
4. `OnlineClass` holds the shape of each class and provides computed flags like `isLive`, `isUpcoming`, and `isCompleted`.
5. Theme values and config placeholders are shared through `app_theme.dart` and `constants.dart`.

## Project Structure

```text
mentorly/
├── android/                      # Native Android project and Gradle configuration
├── ios/                          # Native iOS project and Xcode configuration
├── lib/                          # Main Flutter application source
│   ├── main.dart                 # App entry point and provider/root widget setup
│   ├── models/                   # Domain models
│   │   └── online_class.dart     # OnlineClass model, status enum, and copyWith logic
│   ├── providers/                # State management layer
│   │   └── class_provider.dart   # ChangeNotifier for class data and actions
│   ├── screens/                  # Screen-level widgets
│   │   └── home_screen.dart      # Main home screen scaffold with tabs
│   ├── theme/                    # Shared styling and color definitions
│   │   └── app_theme.dart        # App theme constants and subject color map
│   └── utils/                    # Shared utilities and config placeholders
│       └── constants.dart        # Zego-related placeholder configuration
├── test/                         # Flutter widget and unit tests
├── pubspec.yaml                  # App metadata and dependencies
├── analysis_options.yaml         # Linting and analyzer rules
└── README.md                     # Contributor-facing project documentation
```

## Core Modules and Responsibilities

### `lib/main.dart`

- Defines `main()` and starts the app with `runApp()`.
- Creates a `ChangeNotifierProvider` with `ClassProvider`.
- Builds the root `MaterialApp` and applies the app theme.
- Points the app to `HomeScreen` as the initial route.

### `lib/screens/home_screen.dart`

- Contains the main user interface entry screen.
- Uses `TabController` to organize content into Live, Upcoming, and Completed sections.
- Watches `ClassProvider` so the UI can react to class-state changes.
- Currently acts as a scaffold for the home experience and is expected to grow into a richer screen.

### `lib/providers/class_provider.dart`

- Implements the app’s main state container using `ChangeNotifier`.
- Initializes a sample list of `OnlineClass` instances.
- Exposes derived lists such as `liveClasses`, `upComingClasses`, and `completedClasses`.
- Provides actions such as `onRefreshClasses()` and `onJoinClass()`.
- This is the central place for class-related state logic.

### `lib/models/online_class.dart`

- Defines the core data model for a class or session.
- Stores fields such as title, instructor, subject, schedule, duration, description, and participants.
- Includes computed properties for current activity state:
  - `isLive`
  - `isUpcoming`
  - `isCompleted`
- Uses `copyWith()` for immutable-style updates.
- Defines `ClassStatus` for lifecycle handling.

### `lib/theme/app_theme.dart`

- Centralizes shared color constants for the app.
- Provides a consistent palette for brand styling and subject-based UI accents.
- Should be used across screens and widgets to keep visual design consistent.

### `lib/utils/constants.dart`

- Holds app-level configuration placeholders.
- Contains `ZegoConfig` values for video conferencing integration.
- Useful for future API keys, feature flags, endpoints, and environment-specific settings.

## How the Files Connect

- `lib/main.dart` is the application bootstrap and wiring point.
- `lib/main.dart` creates `ClassProvider` and passes it to the widget tree through `ChangeNotifierProvider`.
- `lib/screens/home_screen.dart` consumes that provider using `context.watch<ClassProvider>()`.
- `lib/providers/class_provider.dart` uses `OnlineClass` from `lib/models/online_class.dart` as the data contract.
- The UI layer can rely on `app_theme.dart` for styling and `constants.dart` for configuration values.
- Native platform folders remain separate and should only contain platform-specific logic when needed.

## Current Development Shape

The app is currently a structured starter project with a clear foundation for future expansion. The main areas that are already present are:

- a root app shell and theme setup
- a provider-based state layer for class data
- a domain model for online classes
- a home screen scaffold for learning content
- platform-ready Android and iOS project folders

## Suggested Extension Path

For the next developer, the natural next steps are:

- add dedicated feature screens under `lib/screens/`
- create reusable widgets under `lib/widgets/`
- move API or backend logic into `lib/services/`
- expand routing and navigation once multiple screens exist
- replace the current placeholder Zego configuration with real credentials when live sessions are implemented
- connect additional screens and UI states to the existing provider layer
