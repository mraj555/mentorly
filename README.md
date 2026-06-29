# Mentorly

Mentorly is a Flutter-based mobile application for browsing and managing online learning classes. The codebase is intentionally structured as a lightweight starter app with a clear separation between presentation, state, domain models, shared styling, and platform-specific configuration.

This document is written for the next developer who needs to understand the architecture quickly and know where the important pieces live.

## Overview

The app currently focuses on a single experience: a home screen that shows classes in three categories:

- Live classes
- Upcoming classes
- Completed classes

The user experience is driven by a Provider-based state layer, and the UI is composed from screen-level widgets and reusable list/card components.

## Tech Stack

Mentorly uses the following core technologies and packages:

- Flutter + Dart for cross-platform mobile development
- Material 3 UI components and Flutter widgets for the app shell and screens
- Provider + ChangeNotifier for state management
- Google Fonts for typography
- Intl for date and time formatting
- Cupertino Icons for iOS-style visual elements
- Zego prebuilt video conference UI and Zego Express Engine for future live-class/video features
- Flutter test and Flutter lints for validation and quality checks

## Architecture

The project follows a simple layered architecture that keeps responsibilities easy to understand:

- Presentation layer: screens and widgets render the experience
- State layer: providers expose app state and actions to the UI
- Domain layer: models describe business objects such as classes and sessions
- Shared support layer: theme and constants provide reusable styling and configuration
- Platform layer: Android and iOS folders contain native build configuration

### Runtime Flow

1. The app starts in lib/main.dart.
2. Main wires up a ChangeNotifierProvider with ClassProvider.
3. HomeScreen reads the provider and renders the tabbed class experience.
4. ClassProvider prepares sample OnlineClass data and exposes derived lists for live, upcoming, and completed sessions.
5. The UI components consume that state and render cards and lists for each class category.

### Architectural Pattern

The current implementation uses a straightforward provider-driven architecture:

- The provider owns the app state and business logic for classes.
- The screen consumes that provider and reacts to updates.
- The model defines the shape of each class object.
- The widgets are responsible only for rendering and layout.

This structure makes it easy to grow the app into a larger feature-based architecture later.

## Project Structure

```text
mentorly/
├── android/                          # Native Android project and Gradle config
├── ios/                              # Native iOS project and Xcode config
├── lib/                              # Main Flutter source code
│   ├── main.dart                     # App bootstrap and root provider setup
│   ├── models/                       # Domain models
│   │   └── online_class.dart         # OnlineClass model, computed status flags, and copyWith
│   ├── providers/                    # State management layer
│   │   └── class_provider.dart       # ChangeNotifier for class data and class actions
│   ├── screens/                      # Screen-level UI components
│   │   └── home_screen.dart          # Main home screen with tabs for live/upcoming/completed
│   ├── theme/                        # Shared theme values
│   │   └── app_theme.dart            # Brand colors and subject-based color mapping
│   ├── utils/                        # Shared helpers and config placeholders
│   │   └── constants.dart            # Zego configuration placeholders
│   └── widgets/                      # Reusable presentational widgets
│       ├── class_card.dart           # Individual class card UI
│       └── class_listview.dart       # List container for a class category
├── test/                             # Automated tests
├── pubspec.yaml                      # App dependencies and package metadata
├── analysis_options.yaml             # Analyzer and lint configuration
└── README.md                         # Project documentation
```

## Key Files and Their Responsibilities

### lib/main.dart

This is the application entry point.

Responsibilities:

- Starts the app with runApp()
- Creates the root ChangeNotifierProvider
- Configures the MaterialApp theme
- Points the app to HomeScreen as the initial screen

### lib/screens/home_screen.dart

This is the main screen for the current app experience.

Responsibilities:

- Renders the app bar and tabbed interface
- Displays three sections: Live, Upcoming, and Completed
- Reads data from ClassProvider using context.watch
- Passes the relevant class list to the list widget for each tab

### lib/providers/class_provider.dart

This is the central state container for the app.

Responsibilities:

- Holds the list of OnlineClass objects
- Seeds sample class data for the current UI
- Exposes derived lists such as liveClasses, upComingClasses, and completedClasses
- Provides actions such as onRefreshClasses() and onJoinClass()
- Emits notifications when data changes so the UI updates

### lib/models/online_class.dart

This file defines the core domain model.

Responsibilities:

- Represents a class session with fields such as title, instructor, subject, schedule, duration, and description
- Calculates whether the class is currently live, upcoming, or completed
- Supports immutable-style updates through copyWith()
- Defines the ClassStatus enum used by the app

### lib/widgets/class_card.dart

This is the reusable card UI for a single class.

Responsibilities:

- Renders the visual summary of a class item
- Applies subject-based color styling
- Prepares the UI for future interactions such as navigation to class details

### lib/widgets/class_listview.dart

This is a reusable list container for a class category.

Responsibilities:

- Displays either a list of classes or an empty state message
- Accepts a list of OnlineClass values and a type label
- Delegates each item to ClassCard

### lib/theme/app_theme.dart

This file centralizes the shared visual design values.

Responsibilities:

- Stores brand colors and app-level palette values
- Supplies subject-specific color mappings for cards and icons
- Keeps styling consistent across the app

### lib/utils/constants.dart

This file contains configuration placeholders for future integrations.

Responsibilities:

- Stores Zego configuration values for video/conference features
- Acts as a central place for future API keys, environment values, or feature flags

## How the Main Files Connect

The app is wired together in a simple way:

- lib/main.dart is the bootstrap point.
- lib/main.dart creates ClassProvider and injects it into the widget tree.
- HomeScreen reads the provider and builds the visible UI.
- ClassProvider supplies the data model instances from lib/models/online_class.dart.
- The screen renders those models through the widget layer in lib/widgets/.
- Shared styling comes from lib/theme/app_theme.dart, while configuration values come from lib/utils/constants.dart.

## Current Data Flow

A typical user interaction follows this path:

1. HomeScreen asks the provider for the current class lists.
2. ClassProvider returns the filtered data based on class timing and status.
3. ClassListview renders the appropriate list for each tab.
4. Each item is displayed through ClassCard.
5. If the class list is refreshed, the provider updates state and the UI re-renders.

## Extension Points

The current structure is intentionally simple, but it is already prepared for future growth.

Good next areas to extend:

- Add dedicated feature screens under lib/screens/
- Introduce a services layer for API or backend integration
- Create more reusable widgets for richer class details and navigation
- Add routing for class detail screens and user flows
- Replace placeholder Zego constants with real production configuration when live sessions are implemented
- Expand the provider layer as the app evolves into a larger multi-feature product
