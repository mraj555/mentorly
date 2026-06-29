# Mentorly

Mentorly is a Flutter-based mobile app for discovering and joining online learning sessions. The current version is a UI-first prototype that uses mock class data, a tabbed home experience, detail pages, and a placeholder video-conference flow powered by Zego. The goal of this project is to keep the codebase simple, readable, and easy to extend for future real API integration, authentication, and richer live-session features.

## Product overview

The app is structured around a lightweight learning experience:

- A home screen with three tabs: Live, Upcoming, and Completed
- Session cards that display title, instructor, timing, subject, and participant count
- A detail page for each class or session
- Live-status logic calculated from the scheduled time and duration
- A join action that navigates into the video-conference screen
- State management through Provider and ChangeNotifier
- Centralized theme and constants to keep the UI consistent

## Tech stack

### Application stack

- Flutter + Dart
  - Cross-platform UI framework for building the mobile app
  - Current SDK constraint: ^3.12.1
- Provider
  - Used for app-wide state exposure and reactive updates
  - Keeps the app lightweight without introducing a larger architecture stack
- Material 3
  - Main UI foundation for components, layout, and theming
- Google Fonts
  - Typography styling for a polished visual experience
- Cupertino Icons
  - Shared icon set across screens and widgets
- Intl
  - Used for date and time formatting in the session UI

### Real-time / video layer

- Zego UIKit Prebuilt Video Conference
  - Provides the video-conference UI shell used by the join flow
- Zego Express Engine
  - Powers the lower-level real-time communication layer

### Quality and validation

- flutter_test
  - Supports widget and unit test coverage
- flutter_lints
  - Enforces consistent Dart analysis and lint conventions

## Architecture overview

Mentorly follows a simple layered architecture with clear separation between UI, state, domain logic, and shared support code.

### 1. Presentation layer

This layer is responsible for rendering what the user sees and handling screen-level navigation.

- lib/screens/home_screen.dart
  - Builds the main app shell and tabbed experience
  - Watches the provider and passes the relevant class lists into the list widget
  - Uses a refreshable body to support future data reload behavior
- lib/screens/class_details_screen.dart
  - Displays the selected session's details and status information
  - Decides how the join action should be represented based on whether the class is live
- lib/screens/video_call_screen.dart
  - Opens the video-conference experience for the selected session
  - Uses the class ID to define the room context for the conference UI
- lib/widgets/class_card.dart
  - Renders one session summary card
  - Handles navigation to the details screen when the card is tapped
- lib/widgets/class_listview.dart
  - Renders a list of cards or an empty state based on the data currently available

### 2. State layer

This layer owns the app's runtime data and derived lists.

- lib/providers/class_provider.dart
  - Holds the in-memory collection of sessions
  - Seeds mock data during initialization
  - Exposes filtered lists for live, upcoming, and completed classes
  - Supplies simple refresh behavior for the UI layer

### 3. Domain layer

This layer contains the core business model used throughout the app.

- lib/models/online_class.dart
  - Defines the OnlineClass model used across the app
  - Stores metadata such as title, instructor, subject, schedule, duration, participants, and description
  - Contains computed helpers for determining whether a class is live, upcoming, or completed
  - Provides copyWith so the model can be updated in a controlled way

### 4. Shared / support layer

These files contain cross-cutting constants and styling rules that different screens can reuse.

- lib/theme/app_theme.dart
  - Centralizes app colors and subject-specific accent values
- lib/utils/constants.dart
  - Stores the placeholder Zego configuration values used by the video-call screen

### 5. App bootstrap

The root application entry point wires the app together.

- lib/main.dart
  - Creates the root Provider state
  - Configures the app theme and typography
  - Launches the home screen as the initial route

## Runtime flow

The current app flow is intentionally simple and easy to trace:

1. lib/main.dart boots the app and creates the root provider.
2. HomeScreen reads provider state and renders the three tabs.
3. ClassProvider prepares and filters the mock session list into live, upcoming, and completed groups.
4. ClassListview renders the selected list of sessions.
5. ClassCard routes the user to the detail screen when a session is tapped.
6. ClassDetailsScreen shows the session details and exposes the join action.
7. VideoCallScreen opens the Zego-based conference experience for the selected session.

## Project structure

```text
mentorly/
├── android/                     # Native Android project files
├── ios/                         # Native iOS project files
├── lib/
│   ├── main.dart                # App entry point and provider/theme setup
│   ├── models/
│   │   └── online_class.dart    # Core session model and status helpers
│   ├── providers/
│   │   └── class_provider.dart  # Mock data source, filtering, and refresh logic
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── class_details_screen.dart
│   │   └── video_call_screen.dart
│   ├── theme/
│   │   └── app_theme.dart       # Shared colors and subject-based styling
│   ├── utils/
│   │   └── constants.dart       # Shared configuration values
│   └── widgets/
│       ├── class_card.dart
│       └── class_listview.dart
├── test/                        # Automated tests
├── pubspec.yaml                 # App dependencies and Flutter SDK constraint
└── analysis_options.yaml        # Linting and analyzer configuration
```

## File connection map

The simplest way to understand the app is to follow the flow of data and navigation from the root down to the video experience.

- lib/main.dart
  - Creates the app and injects ClassProvider into the widget tree
- lib/providers/class_provider.dart
  - Owns the collection of OnlineClass records
  - Supplies filtered data to HomeScreen
- lib/screens/home_screen.dart
  - Consumes provider state and renders the tab-based UI
- lib/widgets/class_listview.dart
  - Renders the selected list of classes for each tab
- lib/widgets/class_card.dart
  - Displays one session and routes to the detail screen
- lib/screens/class_details_screen.dart
  - Uses the selected model instance and launches the video call experience
- lib/screens/video_call_screen.dart
  - Connects the app to Zego's video-conference UI
- lib/theme/app_theme.dart and lib/utils/constants.dart
  - Provide shared styling and configuration to the screens and widgets

## Current implementation notes

These details are important for the next developer working in this codebase:

- The app currently uses mock data stored directly inside the provider rather than a repository or API service.
- Session state such as live, upcoming, and completed is derived dynamically from the current time and the class duration.
- The join flow is currently wired as a placeholder experience and depends on Zego configuration values in the constants file.
- Styling is centralized in the theme layer to keep screen code simpler and more consistent.

## Suggested reading order for a new developer

1. Start with lib/main.dart to understand app bootstrapping and provider setup.
2. Review lib/models/online_class.dart to understand the core domain model.
3. Read lib/providers/class_provider.dart to see how mock data is prepared and filtered.
4. Open lib/screens/home_screen.dart to understand the tab-based UI composition.
5. Follow lib/widgets/class_card.dart and lib/screens/class_details_screen.dart to see how navigation works.
6. Inspect lib/screens/video_call_screen.dart for the live-session integration path.
