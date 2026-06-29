# Mentorly

Mentorly is a Flutter mobile app for browsing and joining online learning classes. This repository is a UI-first prototype with mock class data, a tabbed home screen, class detail pages, and a Zego-powered video conference placeholder. The app is organized so a new developer can quickly understand the flow and extend it with real APIs, authentication, and live sessions.

## Overview

The app currently provides:

- A home screen with three tabs: Live, Upcoming, and Completed
- Card-based class listings for each category
- A detail screen for every class
- Live status detection using scheduled time and duration
- A Join button that opens the video conference screen
- State management using Provider and ChangeNotifier
- Centralized theme and constants for consistent UI

## Tech Stack

- Flutter + Dart
  - Flutter framework for cross-platform mobile UI
  - Dart SDK constraint: `^3.12.1`
- State management
  - `provider` with `ChangeNotifier`
- Styling and fonts
  - `google_fonts`
  - `cupertino_icons`
- Formatting
  - `intl` for date and time display
- Real-time / video integration
  - `zego_uikit_prebuilt_video_conference`
  - `zego_express_engine`
- Quality tooling
  - `flutter_test` for widget and unit tests
  - `flutter_lints` for static analysis

## Architecture

Mentorly uses a lightweight layered architecture with clear separation of responsibilities.

### Presentation Layer

Located in `lib/screens` and `lib/widgets`.

- `lib/screens/home_screen.dart`
  - Main tabbed interface
  - Renders Live, Upcoming, and Completed class views
  - Uses `RefreshIndicator` for pull-to-refresh behavior
- `lib/screens/class_details_screen.dart`
  - Shows class metadata, description, and live status
  - Provides navigation to the video call screen
- `lib/screens/video_call_screen.dart`
  - Wraps a Zego prebuilt video conference widget
  - Uses a conference ID derived from the selected class
- `lib/widgets/class_card.dart`
  - Displays summary data for each class
  - Navigates to details on tap
- `lib/widgets/class_listview.dart`
  - Renders a list of class cards or an empty state

### State Layer

Located in `lib/providers`.

- `lib/providers/class_provider.dart`
  - Owns the list of `OnlineClass` objects
  - Seeds mock data on initialization
  - Exposes category getters:
    - `liveClasses`
    - `upComingClasses`
    - `completedClasses`
  - Handles refresh behavior and state updates

### Domain Layer

Located in `lib/models`.

- `lib/models/online_class.dart`
  - Defines the `OnlineClass` model and `ClassStatus` enum
  - Contains helpers for `isLive`, `isUpcoming`, and `isCompleted`
  - Supports `copyWith` for immutable updates

### Shared / Support Layer

Located in `lib/theme` and `lib/utils`.

- `lib/theme/app_theme.dart`
  - Centralizes theme color values and subject accent mappings
- `lib/utils/constants.dart`
  - Stores shared constants and Zego configuration placeholders

### Platform Layer

- `android/` contains Android native project configuration
- `ios/` contains iOS native project configuration

## Runtime Flow

1. `lib/main.dart` boots the application, configures theme, and registers `ClassProvider`.
2. `HomeScreen` consumes the provider and displays tabbed content.
3. `ClassProvider` filters the seeded mock classes into Live, Upcoming, and Completed groups.
4. `ClassListview` renders the selected group of `OnlineClass` items.
5. `ClassCard` navigates to `ClassDetailsScreen` when a card is tapped.
6. `ClassDetailsScreen` allows users to join the class via `VideoCallScreen`.

## Project Structure

```text
mentorly/
├── android/                        # Android native project files and Gradle config
├── ios/                            # iOS native project files and Xcode config
├── lib/                            # Flutter app source files
│   ├── main.dart                   # App bootstrap, provider setup, theme, and home screen entry
│   ├── models/
│   │   └── online_class.dart       # Core class model and status helper methods
│   ├── providers/
│   │   └── class_provider.dart     # App state and class category logic
│   ├── screens/
│   │   ├── home_screen.dart        # Main tabbed home page
│   │   ├── class_details_screen.dart # Class details page and join-class flow
│   │   └── video_call_screen.dart  # Zego video conference screen
│   ├── widgets/
│   │   ├── class_card.dart         # Class card UI and navigation
│   │   └── class_listview.dart     # Category list container and empty states
│   ├── theme/
│   │   └── app_theme.dart          # Shared theme color definitions
│   └── utils/
│       └── constants.dart          # Global constants and Zego config values
├── test/                           # Widget and unit tests
├── pubspec.yaml                    # Dependencies and Flutter SDK constraint
└── analysis_options.yaml           # Lint rules and analyzer configuration
```

## File Responsibilities

- `lib/main.dart`
  - Registers the root provider
  - Applies theme configuration
  - Launches `HomeScreen`

- `lib/providers/class_provider.dart`
  - Seeds and manages the in-memory class collection
  - Exposes filtered lists for each tab
  - Contains refresh behavior

- `lib/screens/home_screen.dart`
  - Builds the tabbed home screen
  - Uses provider state to populate each category
  - Wraps content in a refresh indicator

- `lib/widgets/class_listview.dart`
  - Renders either a scrollable list or an empty state
  - Selects the correct text for empty categories

- `lib/widgets/class_card.dart`
  - Displays the class summary card
  - Shows subject, instructor, schedule, and participants
  - Navigates to details when tapped

- `lib/screens/class_details_screen.dart`
  - Displays selected class details
  - Shows if a class is live
  - Navigates to the Zego video call screen

- `lib/screens/video_call_screen.dart`
  - Creates the Zego video conference experience
  - Uses the class ID as the conference room identifier

- `lib/models/online_class.dart`
  - Defines the class domain model and status evaluation
  - Uses computed getters for live/upcoming/completed logic

- `lib/theme/app_theme.dart`
  - Stores shared color constants and subject-specific accents

- `lib/utils/constants.dart`
  - Stores Zego credentials placeholders and global constants

## Extension Points for Future Development

The current implementation is intentionally simple and built to grow:

- Add a service layer for API calls and remote class data
- Add a repository layer for data source abstraction
- Replace seeded mock data with backend or local persistence
- Add authentication and user profiles
- Introduce a routing layer for scalable navigation
- Expand live-class capabilities using the existing Zego integration

## Notes for the Next Developer

Best path to understand the codebase:

1. Review `lib/models/online_class.dart` for class shape and status rules.
2. Inspect `lib/providers/class_provider.dart` for state and category logic.
3. Open `lib/screens/home_screen.dart` to see how the tabs and lists are composed.
4. Read `lib/widgets/class_card.dart` and `lib/widgets/class_listview.dart` for reusable UI behavior.
5. Review `lib/screens/video_call_screen.dart` and `lib/utils/constants.dart` for the live-class integration path.
