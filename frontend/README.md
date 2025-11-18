# School Management System - Frontend

This is the frontend for the School Management System SaaS platform built with Flutter.

## Features

- Cross-platform support (Android, iOS, Web, Desktop)
- Role-based UI (Admin, Teacher, Student, Parent, Accountant)
- Responsive design
- Offline capabilities
- Real-time notifications
- PDF viewing and document handling

## Tech Stack

- Flutter 3.10+
- Dart 3.0+
- Riverpod for state management
- Dio for HTTP requests
- GoRouter for navigation
- flutter_secure_storage for secure data storage
- Firebase Messaging for push notifications
- Syncfusion for PDF viewing
- fl_chart for data visualization

## Project Structure

```
lib/
├── features/          # Feature-specific code
├── services/          # API and other services
├── models/            # Data models
├── providers/         # Riverpod providers
├── views/             # Screen widgets
├── widgets/           # Reusable UI components
├── utils/             # Utility functions and helpers
└── routes/            # App routing configuration
```

## Setup Instructions

1. Install Flutter SDK (3.10 or higher)

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run code generation (for Riverpod and Retrofit):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Building for Different Platforms

### Android
```bash
flutter build apk
```

### iOS
```bash
flutter build ios
```

### Web
```bash
flutter build web
```

### Windows
```bash
flutter build windows
```

## Environment Configuration

Create a `.env` file in the root directory with the following variables:

```
API_BASE_URL=http://localhost:8000/api
```

## Deployment

For production deployment:
- Web: Deploy to Netlify, Vercel, or similar
- Mobile: Publish to App Store and Google Play
- Desktop: Package and distribute as platform-specific installers