# Mentorly

Mentorly is a Flutter-based mobile app for discovering and joining online learning sessions. The current implementation is a UI-first prototype that uses mock class data, a tabbed home experience, detail pages, and a placeholder video-conference flow powered by Zego.

## Product overview

The app is organized around a simple learning experience:

- A home screen with three tabs: Live, Upcoming, and Completed
- Class cards that summarize title, instructor, timing, subject, and participant count
- A detail page for each course/session
- Live-status logic based on the session schedule and duration
- A join action that navigates into the video call screen
- State management through Provider and ChangeNotifier
- Shared theme and constant values for consistent UI behavior

## Tech stack

### Core

- Flutter + Dart
  - Cross-platform UI framework for mobile applications
  - Current SDK constraint: ^3.12.1

### State and architecture

- Provider
  - Used for app-wide state exposure and change notifications
  - Keeps the UI reactive without introducing a heavier state stack

### UI and styling

- Material 3
  - The app uses Flutter Material design components and theming
- Google Fonts
  - Typography is configured through Google Fonts for a more polished visual system
- Cupertino Icons
  - Shared icon set used throughout the screens

### Data and formatting

- Intl
  - Used for formatting dates and times on the class cards and detail screen

### Real-time / video experience

- Zego UIKit Prebuilt Video Conference
  - Provides the video-conference UI shell for joining a class
- Zego Express Engine
  - Powers the underlying real-time communication layer

### Quality and validation

- flutter_test
  - Supports widget and unit testing
- flutter_lints
  - Enforces consistent Dart analyzer and lint rules

## Architecture

Mentorly follows a lightweight layered architecture with a clear separation between UI, state, domain models, and shared support code.

### 1. Presentation layer

This layer is responsible for rendering what the user sees.

- [lib/screens/home_screen.dart](lib/screens/home_screen.dart)
  - Builds the main tabbed experience
  - Watches the provider and passes the appropriate class lists to the list widget
  - Wraps the content in a refreshable view
- [lib/screens/class_details_screen.dart](lib/screens/class_details_screen.dart)
  - Displays detailed session information for the selected class
  - Determines whether the class is live and controls the join-state UI
- [lib/screens/video_call_screen.dart](lib/screens/video_call_screen.dart)
  - Opens the video-conference experience for the selected class
  - Uses the class ID to define the conferencing room context
- [lib/widgets/class_card.dart](lib/widgets/class_card.dart)
  - Renders the session summary card
  - Handles navigation to the details screen on tap
- [lib/widgets/class_listview.dart](lib/widgets/class_listview.dart)
  - Renders a list of session cards or an empty-state message depending on data availability

### 2. State layer

This layer owns app data and user-driven state transitions.

- [lib/providers/class_provider.dart](lib/providers/class_provider.dart)
  - Holds the in-memory list of sessions
  - Seeds mock data on initialization
  - Exposes filtered lists for live, upcoming, and completed classes
  - Provides refresh behavior and participant join handling

### 3. Domain layer

This layer contains the core business model for a class/session.

- [lib/models/online_class.dart](lib/models/online_class.dart)
  - Defines the OnlineClass model
  - Stores metadata such as title, instructor, subject, schedule, duration, participants, and description
  - Includes computed helpers for determining whether a class is live, upcoming, or completed
  - Provides copyWith for value updates in a controlled way

### 4. Shared / support layer

These files hold cross-cutting configuration and visual constants.

- [lib/theme/app_theme.dart](lib/theme/app_theme.dart)
  - Centralizes app colors and subject-specific accent values
- [lib/utils/constants.dart](lib/utils/constants.dart)
  - Stores the Zego configuration placeholders used by the video-call screen

### 5. App bootstrap

The root application entry point wires the app together.

- [lib/main.dart](lib/main.dart)
  - Registers the ClassProvider at the root
  - Configures the app theme and typography
  - Launches the home screen as the app entry

## Runtime flow

1. [lib/main.dart](lib/main.dart) boots the application and creates the root provider.
2. [lib/screens/home_screen.dart](lib/screens/home_screen.dart) reads provider state and renders the three tabs.
3. [lib/providers/class_provider.dart](lib/providers/class_provider.dart) filters the mock session list into live, upcoming, and completed groups.
4. [lib/widgets/class_listview.dart](lib/widgets/class_listview.dart) renders the selected session list.
5. [lib/widgets/class_card.dart](lib/widgets/class_card.dart) navigates to the detail page when a card is selected.
6. [lib/screens/class_details_screen.dart](lib/screens/class_details_screen.dart) shows the session details and initiates the join action.
7. [lib/screens/video_call_screen.dart](lib/screens/video_call_screen.dart) opens the Zego-based conference experience.

## Project structure

```text
mentorly/
├── android/                  # Native Android project files
├── ios/                      # Native iOS project files
├── lib/
│   ├── main.dart             # App bootstrap and provider/theme setup
│   ├── models/
│   │   └── online_class.dart # Core session model and status helpers
│   ├── providers/
│   │   └── class_provider.dart # Mock data source, filtering, and refresh logic
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── class_details_screen.dart
│   │   └── video_call_screen.dart
│   ├── theme/
│   │   └── app_theme.dart    # Shared color and theme constants
│   ├── utils/
│   │   └── constants.dart    # Shared configuration values
│   └── widgets/
│       ├── class_card.dart
│       └── class_listview.dart
├── test/                     # Automated tests
├── pubspec.yaml              # App dependencies and Flutter SDK constraint
└── analysis_options.yaml     # Linting and analyzer configuration
```

## File connection map

The easiest way to understand the project is to follow the data flow through these files:

- [lib/main.dart](lib/main.dart)
  - Creates the app and injects [lib/providers/class_provider.dart](lib/providers/class_provider.dart)
- [lib/providers/class_provider.dart](lib/providers/class_provider.dart)
  - Owns the collection of [lib/models/online_class.dart](lib/models/online_class.dart) records
  - Supplies filtered data to [lib/screens/home_screen.dart](lib/screens/home_screen.dart)
- [lib/screens/home_screen.dart](lib/screens/home_screen.dart)
  - Consumes provider state and renders [lib/widgets/class_listview.dart](lib/widgets/class_listview.dart)
- [lib/widgets/class_card.dart](lib/widgets/class_card.dart)
  - Displays one session and routes to [lib/screens/class_details_screen.dart](lib/screens/class_details_screen.dart)
- [lib/screens/class_details_screen.dart](lib/screens/class_details_screen.dart)
  - Uses the selected model instance and launches [lib/screens/video_call_screen.dart](lib/screens/video_call_screen.dart)
- [lib/theme/app_theme.dart](lib/theme/app_theme.dart) and [lib/utils/constants.dart](lib/utils/constants.dart)
  - Supply shared styling and configuration to the screens and widgets

## Extension points

The app is intentionally structured so it can grow without a large rewrite:

- Replace mock data with a real API or service layer
- Add repositories for remote persistence and caching
- Introduce authentication and user profiles
- Add a navigation/router layer for scalable screen management
- Expand the live-session experience using the existing Zego integration

## Recommended reading order for a new developer

1. Start with [lib/main.dart](lib/main.dart) to understand bootstrapping and provider setup.
2. Review [lib/models/online_class.dart](lib/models/online_class.dart) to understand the core domain model.
3. Read [lib/providers/class_provider.dart](lib/providers/class_provider.dart) to see how mock data is prepared and filtered.
4. Open [lib/screens/home_screen.dart](lib/screens/home_screen.dart) to understand the tab-based UI composition.
5. Follow [lib/widgets/class_card.dart](lib/widgets/class_card.dart) and [lib/screens/class_details_screen.dart](lib/screens/class_details_screen.dart) to see how navigation works.
6. Inspect [lib/screens/video_call_screen.dart](lib/screens/video_call_screen.dart) for the live-session integration path.
