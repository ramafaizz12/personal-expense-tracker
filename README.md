# Personal Expense Tracker

A comprehensive Flutter application to track your personal expenses seamlessly.

## Tech Stack & Architecture

This project was built focusing on scalability, maintainability, and testing. It follows a **Feature-first Clean Architecture** pattern, splitting features into Domain, Data, and Presentation layers.

### Key Libraries Used:

- **State Management**: [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) for predictable, strictly typed state management.
- **Local Database**: [`hive`](https://pub.dev/packages/hive) & [`hive_flutter`](https://pub.dev/packages/hive_flutter) for fast, lightweight NoSQL local data persistence.
- **Dependency Injection**: [`get_it`](https://pub.dev/packages/get_it) as a service locator to decouple layers and manage instances.
- **Routing**: [`go_router`](https://pub.dev/packages/go_router) for declarative routing.
- **Clean Code**: [`flutter_hooks`](https://pub.dev/packages/flutter_hooks) to eliminate `StatefulWidget` boilerplate, resulting in significantly cleaner, more readable code when managing UI lifecycles (such as text controllers).
- **Security**: [`envied`](https://pub.dev/packages/envied) ready to be implemented for securely obfuscating and handling environment variables/API keys when interacting with external data sources.
- **Formatting**: [`intl`](https://pub.dev/packages/intl) for robust locale-aware date and currency formatting.

### Testing Ecosystem

The project implements a robust testing suite covering Unit Tests, Bloc Tests, and Widget Tests.

- [`bloc_test`](https://pub.dev/packages/bloc_test): For testing state transitions in the presentation layer.
- [`mockito`](https://pub.dev/packages/mockito): To generate mocks for repositories and usecases in the Domain and Data layers.
- [`mocktail`](https://pub.dev/packages/mocktail): Used alongside `bloc_test` for mocking `Bloc` instances effortlessly in Widget tests.

## Architecture Layers

- **Core**: Contains global configurations like DI setup (`injection_container.dart`) and Routing (`app_router.dart`).
- **Domain**: Pure Dart code holding the core entities (`Expense`) and business logic (`UseCases`). It knows nothing of the UI or outside frameworks.
- **Data**: Implements the Domain's repository interfaces. Handles local data sources (Hive) and defines models that extend entities.
- **Presentation**: Handles the UI layout (`Pages` and `Widgets`) and UI State management (`Bloc`, `Events`, `States`).

## Getting Started

1. Clone this repository.
2. Ensure you have the Flutter SDK installed.
3. Run `flutter pub get` to fetch dependencies.
4. Run `dart run build_runner build -d` to generate the Hive TypeAdapters and Mockito mocks.
5. Run the app using `flutter run` on an emulator or physical device.

## Running Tests

To run the full suite of unit, bloc, and widget tests:

```bash
flutter test
```
