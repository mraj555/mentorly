# Mentorly

Mentorly is a Flutter mobile application for browsing and managing online learning classes. This README explains the core technologies, architecture, and file structure so a new developer can quickly understand which files are responsible for what and how they connect.

> This document intentionally focuses on architecture, tech stack, and project structure. It does not include cloning or installation instructions.

## Overview

The app presents a simple learning experience: a home screen with three class categories — Live, Upcoming, and Completed. The UI is composed from screen-level widgets and small, reusable components. App state is managed with Provider and ChangeNotifier.

## Tech Stack

- **Flutter & Dart**: Cross-platform UI toolkit and language (stable channel recommended). See `pubspec.yaml` for exact SDK constraints.
- **State management**: `provider` with `ChangeNotifier` for lightweight, observable app state.
- **UI / Theming**: Material (Material 3 where applicable), `google_fonts`, and `cupertino_icons` for platform-consistent UI.
- **Formatting & Localization**: `intl` for dates/times and future localization.
- **Real-time / Video (planned)**: Zego prebuilt UI and Zego Express Engine placeholders are present for future live-class features.
- **Testing & linting**: Built-in `flutter_test`, plus analyzer rules in `analysis_options.yaml` and project lints.
- **Native build tools**: Gradle (Android) and Xcode (iOS) for platform-specific builds and configuration.

Where to look for package versions: open [pubspec.yaml](pubspec.yaml) for the authoritative list of dependencies.

## Architecture — High Level

Mentorly uses a small, layered architecture optimized for clarity and ease of extension:

- **Presentation layer (UI)**: `lib/screens` and `lib/widgets` — compose UI, read from providers, and call actions.
- **State layer**: `lib/providers` — `ChangeNotifier` classes that hold state, business logic, and provide methods the UI calls.
- **Domain model**: `lib/models` — immutable data objects (like `OnlineClass`) describing business entities.
- **Support / Shared**: `lib/theme` and `lib/utils` — theme values, color maps, constants and small helpers.
- **Platform**: `android/` and `ios/` — native project files and platform configuration.

Design choices and rationale:

- Provider + ChangeNotifier keeps state logic simple and local to features; it is easy to replace with more advanced patterns (Bloc, Riverpod) later.
- The domain model is kept independent of UI code to make it straightforward to introduce serialization, persistence, or remote APIs.

### Runtime Flow (quick)

1. `lib/main.dart` bootstraps the app and wires top-level providers.
2. `HomeScreen` reads `ClassProvider` and requests lists for Live/Upcoming/Completed.
3. `ClassProvider` exposes lists derived from `OnlineClass` model instances.
4. `ClassListView` and `ClassCard` render model data; user actions call provider methods (e.g., join, refresh).

### Suggested Evolution Points

- Add a `services/` layer (e.g., `lib/services/class_service.dart`) that handles API/network calls.
- Add a `repositories/` layer to isolate data sources (local cache, remote API).
- Introduce routing (e.g., `go_router` or `flutter_modular`) for multi-screen navigation and deep links.

## Project Structure — Detailed

Below is a more detailed map of the codebase and the responsibilities of the common files and folders. Use this as a quick reference to find where to add or change features.

```
mentorly/
├── android/                        # Native Android project and Gradle config
├── ios/                            # Native iOS project and Xcode config
├── lib/                            # Flutter app source
│   ├── main.dart                   # App bootstrap: provider wiring, MaterialApp, top-level theme
│   ├── models/                      
│   │   └── online_class.dart       # Domain model: OnlineClass, ClassStatus enum, computed helpers
│   ├── providers/                   
│   │   └── class_provider.dart     # ChangeNotifier: list state, seed data, actions (refresh/join)
│   ├── screens/                     
│   │   └── home_screen.dart        # Main screen with tabs; reads provider and supplies lists to widgets
│   ├── widgets/                     
│   │   ├── class_card.dart         # Visual card for each OnlineClass
│   │   └── class_listview.dart     # Generic list + empty states for categories
│   ├── theme/                       
│   │   └── app_theme.dart          # ThemeData, color palettes, subject color mapping
│   ├── utils/                       
│   │   └── constants.dart          # Placeholders for Zego/API keys, app-wide constants
│   └── (optional folders you may add)
│       ├── services/               # Network or platform services (API clients, socket handlers)
│       ├── repositories/           # Data access abstraction (local DB, remote API)
│       └── routes/                 # Centralized route definitions (if using a router package)
├── assets/                         # Static assets: images, fonts, icons (if present)
├── build/                          # Generated build artifacts (ignore for code changes)
├── test/                           # Unit/widget tests
├── pubspec.yaml                    # Dependencies, assets, and SDK constraints
└── analysis_options.yaml           # Lint/analyzer rules
```

Notes on where files connect:

- `main.dart` constructs the provider(s) and injects them into the widget tree.
- `providers` create and own the domain objects from `models` (or request them from services/repositories).
- `screens` compose `widgets` and call provider methods for interactions.
- `theme` and `utils` are small, dependency-free helpers used by UI code.

## File Responsibilities and How They Relate

- `lib/main.dart` — single place to configure app-level dependencies (providers, theme, localization). Keep this file minimal: only composition and bootstrapping.
- `lib/models/online_class.dart` — the canonical class definition. Keep serialization, equality, and derived getters here. Avoid placing UI logic in the model.
- `lib/providers/class_provider.dart` — the app's business logic for class lists. It should transform raw data into view-ready lists and expose actions. If network calls are required later, this class should delegate those to a `service` or `repository`.
- `lib/screens/home_screen.dart` — orchestrates tabs and listens to provider changes via `context.watch`/`Consumer`.
- `lib/widgets/class_card.dart` — visual representation; reads only the data it needs and fires callbacks for interactions.

## Adding a New Feature — Quick Guide

1. Add or update a `model` in `lib/models/` for your domain data.
2. Add a `provider` in `lib/providers/` for state and business logic.
3. If the feature needs network I/O, add a `service` in `lib/services/` and consider a `repositories/` abstraction.
4. Add screens to `lib/screens/` and compose them from small widgets in `lib/widgets/`.
5. Update `main.dart` to register any new top-level providers or routes.
6. Add unit/widget tests in `test/` covering provider logic and widgets.

## Conventions & Best Practices

- File naming: use snake_case for file names (example: `class_provider.dart`).
- Keep widgets small and focused — favor composition over monolithic widgets.
- Providers should contain business logic; UI should be declarative and free of side effects.
- Keep theming and color palettes in `lib/theme/app_theme.dart` for consistency.
- Centralize constants (API keys, feature flags) in `lib/utils/constants.dart` and avoid scattering magic strings.

## Testing Strategy

- Unit test providers and model logic in `test/` (e.g., tests for status calculation in `OnlineClass`).
- Widget tests for `ClassCard` and `ClassListView` to verify UI states (empty, populated, loading).

## Where to Look Next

- Dependency versions and SDK constraints: [pubspec.yaml](pubspec.yaml)
- Linter rules and quick fixes: [analysis_options.yaml](analysis_options.yaml)
- Platform-specific settings: `android/` and `ios/` folders

---

If you want, I can also:

- Add a small mermaid diagram showing the runtime flow to `README.md`.
- Create placeholder files for `services/` and `repositories/` to demonstrate the recommended layered structure.

Tell me which of those you'd like next.
