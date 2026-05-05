# Ambient Assisted Living

iOS SwiftUI app for caregivers to monitor elderly people. Connects to an
ESP8266 device via Firebase (Firestore + Auth + Cloud Messaging).

- **Bundle ID**: `lasalle.Ambient-Assisted-Living`
- **Minimum iOS**: 17.0
- **Architecture**: SwiftUI app lifecycle, Firebase backend

## Setup

1. **Clone the repo** and open `Ambient Assisted Living.xcodeproj` in Xcode.
2. **Create a Firebase project** in the [Firebase Console](https://console.firebase.google.com):
   - Add an iOS app with bundle ID `lasalle.Ambient-Assisted-Living`.
   - Enable **Authentication**, **Cloud Firestore**, and **Cloud Messaging**.
3. **Download `GoogleService-Info.plist`** from the Firebase Console
   (Project settings → Your apps → iOS app → "Download GoogleService-Info.plist").
4. **Copy it into the project** at:
   ```
   Ambient Assisted Living/Ambient Assisted Living/GoogleService-Info.plist
   ```
   replacing the `GoogleService-Info.plist.example` placeholder. The real
   file is gitignored so it never lands in the repo.
5. **In Xcode**, add the file to the target if it isn't already
   (drag into the project navigator, check "Copy items if needed" and the
   `Ambient Assisted Living` target).
6. **Build & run** (`Cmd+R`).

### Firebase SPM packages

Already wired into the project via Swift Package Manager:

- `FirebaseAuth`
- `FirebaseCore`
- `FirebaseFirestore`
- `FirebaseMessaging`

If Xcode does not resolve them on first open: **File → Packages → Reset
Package Caches**.

### Capabilities

For push notifications via `FirebaseMessaging`, the target needs:

- **Push Notifications** capability
- **Background Modes** → *Remote notifications*

## Project structure

```
Ambient Assisted Living/
├── App/           # @main entry point
├── Models/        # Domain models
├── Services/      # Firebase, ESP8266 client, etc.
├── ViewModels/    # @Observable view models
├── Views/
│   ├── Auth/
│   ├── Onboarding/
│   ├── Dashboard/
│   ├── Monitoring/
│   ├── Control/
│   ├── Alerts/
│   ├── Settings/
│   └── Components/
└── Resources/     # Assets, localizations, fonts
```
