# Project Guidelines

## Code Style
- Follow `flutter_lints` defaults from `analysis_options.yaml`. Run `flutter analyze` after changes.
- Keep naming consistent with existing code: files in `snake_case`, classes in `PascalCase`, private members with a leading underscore.
- Use Riverpod for dependency wiring in `lib/providers.dart`; avoid ad-hoc global singletons outside the provider graph.
- Keep UI state in ViewModels under `lib/presentation/viewmodels/` and avoid moving business logic into widgets.
- Do not edit generated files such as `lib/data/database/app_database.g.dart` manually.

## Architecture
- Respect the layered structure:
  - `lib/presentation/`: screens, widgets, viewmodels (UI and interaction state)
  - `lib/data/`: repositories, services, database, models (data access and domain logic)
  - `lib/core/`: shared theme, constants, utilities
- For new features, keep data flow explicit:
  - service/repository updates in `lib/data/`
  - provider wiring in `lib/providers.dart`
  - UI/viewmodel integration in `lib/presentation/`
- Reuse existing patterns from `lib/data/repositories/stress_repository.dart`, `lib/presentation/viewmodels/typing_viewmodel.dart`, and `lib/presentation/views/home_screen.dart`.

## Build and Test
- Install dependencies: `flutter pub get`
- Regenerate code when Drift tables or generator-backed Riverpod code changes:
  - `flutter pub run build_runner build --delete-conflicting-outputs`
- Run static checks: `flutter analyze`
- Run tests: `flutter test`
- Run app locally: `flutter run`

## Conventions
- Database is Drift-based (`lib/data/database/`), with local SQLite opened in `lib/data/database/app_database.dart`.
- If schema changes are introduced, update `schemaVersion` and include migration logic; do not leave breaking schema changes without migration.
- Centralize visual styling in `lib/core/theme/app_theme.dart` rather than per-screen color/theme overrides.
- Preserve stress scoring behavior unless task explicitly requests changes; current weighting logic is in `lib/data/repositories/stress_repository.dart`.
- Do not commit transient/generated outputs under `build/`, `.dart_tool/`, or platform build output folders already listed in `.gitignore`.