# 📚 Book Space

A full-featured Flutter bookstore application built as a graduation project. Book Space delivers a dual-role experience — admins can manage the catalog while users browse, discover, and build their personal library.

> UI design inspired by [this Behance concept](https://www.behance.net/gallery/204801367/Book-Store-App).

---

## ✨ Features

### 👤 User
- Browse and search the full book catalog
- View detailed book descriptions, ratings, and metadata
- Add books to **Favorites** or personal **Library**
- Smooth onboarding with animated carousel
- Localization support (multi-language ready)

### 🛠️ Admin
- Add new books to the store
- Edit existing book details
- Delete books from the catalog

### 🔐 Auth
- Email/password registration and login via Firebase Auth
- Google Sign-In support
- Persistent sessions with Hive local storage

### 🔔 Notifications
- Push notifications via Firebase Cloud Messaging (FCM)

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3.x / Dart |
| State Management | flutter_bloc ^8.1.6 |
| Backend / Database | Firebase Firestore |
| File Storage | Firebase Storage |
| Auth | Firebase Auth + Google Sign-In |
| Push Notifications | Firebase Messaging |
| Local Storage | Hive + Hive Flutter |
| Navigation | GetX (get ^4.6.6) |
| Networking | Dio ^5.6.0 |
| UI | Carousel Slider, Smooth Page Indicator, Percent Indicator |

---

## 📁 Project Structure

```
book_store/
├── android/                  # Android platform config
├── ios/                      # iOS platform config
├── assets/
│   └── images/               # App images and icons
├── lib/
│   ├── main.dart             # App entry point
│   ├── core/                 # Constants, themes, utilities
│   ├── data/                 # Models, repositories, Firebase services
│   ├── logic/                # BLoC cubits and state classes
│   └── presentation/         # Screens and widgets
├── test/                     # Unit and widget tests
├── pubspec.yaml
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `^3.5.3`
- Dart SDK `^3.5.3`
- Android Studio / VS Code
- A Firebase project (see setup below)

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/ISLAM2ADEL/book_store.git
cd book_store

# 2. Install dependencies
flutter pub get

# 3. Run code generation (Hive adapters)
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Run the app
flutter run
```

### Firebase Setup

1. Create a new project at [Firebase Console](https://console.firebase.google.com/).
2. Enable the following services:
   - **Authentication** (Email/Password + Google)
   - **Cloud Firestore**
   - **Firebase Storage**
   - **Firebase Messaging**
3. Download `google-services.json` and place it in `android/app/`.
4. Download `GoogleService-Info.plist` and place it in `ios/Runner/`.

---

## 📦 Key Dependencies

```yaml
flutter_bloc: ^8.1.6       # BLoC state management
firebase_core: ^3.5.0      # Firebase initialization
cloud_firestore: ^5.4.2    # NoSQL cloud database
firebase_auth: ^5.3.0      # Authentication
firebase_storage: ^12.3.1  # Image/file storage
firebase_messaging: ^15.1.2 # Push notifications
google_sign_in: ^6.2.1     # Google OAuth
hive: ^2.2.3               # Local key-value storage
dio: ^5.6.0                # HTTP client
get: ^4.6.6                # Navigation & utilities
carousel_slider: ^5.0.0    # Home page carousel
image_picker: ^1.1.2       # Book cover uploads
```

---

## 📱 Supported Platforms

| Platform | Status |
|---|---|
| Android | ✅ (min SDK 24) |
| iOS | ✅ |
| Web | 🔧 Configured |
| Linux | 🔧 Configured |
| macOS | 🔧 Configured |
| Windows | 🔧 Configured |

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'feat: add your feature'`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a Pull Request
