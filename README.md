# ToDo

A Flutter task-management app with Firebase sign-in, real-time Firestore tasks, color-coded cards, and Arabic/English localization.

![Flutter](https://img.shields.io/badge/Flutter-172033?style=flat-square) ![Dart](https://img.shields.io/badge/Dart-172033?style=flat-square) ![Cubit](https://img.shields.io/badge/Cubit-172033?style=flat-square) ![Firebase](https://img.shields.io/badge/Firebase-172033?style=flat-square) ![Firestore](https://img.shields.io/badge/Firestore-172033?style=flat-square)

## Features

- Create an account and sign in with email and password.
- Add tasks with a title, description, date, and chosen card color.
- Read, edit, and delete tasks with real-time Firestore updates.
- View profile information, change a password, and request a password-reset email.
- Switch between English and Arabic in the profile screen.

## Screenshots

![ToDo task list, task form, color picker, and details](https://github.com/user-attachments/assets/5d5afaba-d57f-4f11-b813-bac38f18e54d)

## Tech stack

Flutter, Dart, Cubit, Firebase, Firestore. Localization uses easy_localization; task colors use flutter_colorpicker.

## Run locally

### Requirements

- Flutter SDK with Dart compatible with `^3.8.1` (the constraint in `pubspec.yaml`).
- A configured Android emulator or connected device.

### Get the project

```bash
git clone https://github.com/Mo123elsayed/ToDo_app.git
cd ToDo_app
flutter pub get
```

### Configuration

Android is the clearest starting point: the repository includes `android/app/google-services.json` and applies the Google Services plugin. For an independent instance:

1. Create your own Firebase project and register an Android app matching the application ID in `android/app/build.gradle.kts`.
2. Replace `android/app/google-services.json` with your own project configuration.
3. Enable Email/Password in Firebase Authentication and create a Cloud Firestore database. The code uses `users` and `ToDo-list` collections.
4. Configure appropriate Firestore rules before connecting the app. Never deploy unrestricted rules with real data.

`main.dart` currently calls `Firebase.initializeApp()` without explicit options. Although `lib/firebase_options.dart` exists, it is not passed into initialization. Other platforms require their own Firebase configuration and, where needed, initialization changes; they are not claimed as ready to run.

### Start the app

```bash
flutter run
```

## Project structure

- `lib/authentication/`: authentication data, repository contracts, Cubits, and screens
- `lib/home/`: task models, Firestore repository, Cubits, and screens
- `assets/translations/`: English and Arabic strings
- `lib/main.dart`: Firebase initialization, localization, and routes

## Project notes

This is a learning/demo implementation. The current task repository uses a shared `ToDo-list` collection and does not attach a user ID to tasks or filter reads by user. Do not treat it as private, per-user storage without adding ownership checks and matching Firestore rules.

This README describes the checked-in implementation. Device builds and third-party service responses are not guaranteed by the presence of source code.
