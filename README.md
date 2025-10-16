# Ethos – Purposeful Trips (Phase 1)

This repository hosts a Flutter prototype for the Ethos purposeful travel platform. The build follows the unified engineering prompt focusing on offline-first behaviour with local seed data.

## Structure

```
lib/
  core/        # Theme, localization, services, and mock data access
  features/    # UI flows split by feature domains (onboarding, home, profile, etc.)
  models/      # Strongly-typed domain models
  widgets/     # Reusable presentation widgets
assets/
  branding/    # Placeholder branding assets
  mock/        # Local seed data and mock images
```

## Getting Started

1. Install Flutter 3.24+ and Dart 3.5+.
2. Run `flutter pub get` to install dependencies.
3. Launch with `flutter run` (no backend required).

The app supports Arabic (RTL) and English (LTR), light/dark themes, onboarding flows, and local data-driven home/profile experiences.

## Testing

Execute unit tests with:

```bash
flutter test
```
