# 📱 WhatsApp Clone (Round 34)

![Flutter](https://img.shields.io/badge/Flutter-3.19-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0-0175C2?logo=dart)
![Architecture](https://img.shields.io/badge/Architecture-Clean%20Arch-green)
![State Management](https://img.shields.io/badge/State-BLoC-red)
![Firebase](https://img.shields.io/badge/Backend-Firebase-FFCA28?logo=firebase)

A full-featured WhatsApp clone application built with **Flutter**, designed to replicate the core functionalities of the original app using industry-standard practices including **Clean Architecture**, **BLoC Pattern**, and **Firebase**.

## 📸 Screenshots
| Chat List | Chat Room | Status | Calls |
|:---:|:---:|:---:|:---:|
| ![Chat List](assets/screenshots/chat_list.png) | ![Chat Room](assets/screenshots/chat_room.png) | ![Status](assets/screenshots/status.png) | ![Calls](assets/screenshots/calls.png) |
> *Note: Please add screenshots to `assets/screenshots` folder.*

## 🛠 Tech Stack & Libraries

- **Framework:** Flutter SDK
- **Architecture:** Clean Architecture (Data, Domain, Presentation)
- **State Management:** `flutter_bloc`
- **Dependency Injection:** `get_it`
- **Backend:** Firebase (Auth, Firestore, Storage)
- **UI & Responsive:** `flutter_screenutil`
- **Localization:** `flutter_localizations` & `intl` (Arabic & English Support)
- **Utils:** `dartz` (Functional Programming), `country_picker`.

## 📂 Project Structure

The project follows a strict **Clean Architecture** separation:

```text
clone_whatsapp_round34
├─ assets
│  ├─ fonts
│  └─ images
├─ lib
│  ├─ app.dart
│  ├─ generated
│  │  └─ l10n.dart
│  ├─ l10n
│  │  ├─ intl_ar.arb
│  │  └─ intl_en.arb
│  ├─ main.dart
│  └─ src
│     ├─ core
│     │  ├─ animation
│     │  │  ├─ animation.dart
│     │  ├─ api
│     │  │  └─ api.dart
│     │  ├─ config
│     │  │  ├─ config.dart
│     │  ├─ constants
│     │  │  ├─ constants.dart
│     │  ├─ error
│     │  │  ├─ error.dart
│     │  ├─ global
│     │  │  └─ global.dart
│     │  ├─ keys
│     │  │  └─ keys.dart
│     │  ├─ localization
│     │  │  └─ localization.dart
│     │  ├─ middleware
│     │  │  └─ middleware.dart
│     │  ├─ routes
│     │  │  └─ routes.dart
│     │  ├─ services
│     │  │  └─ services.dart
│     │  ├─ theme
│     │  │  └─ theme.dart
│     │  ├─ usecases
│     │  │  └─ usecases.dart
│     │  ├─ utils
│     │  │  └─ utils.dart
│     │  └─ widgets
│     │     └─ widgets.dart
│     └─ features
│        ├─ auth
│        │  ├─ data
│        │  ├─ domain
│        │  └─ presentation
│        ├─ calls
│        │  ├─ data
│        │  ├─ domain
│        │  └─ presentation
│        ├─ chat
│        │  ├─ data
│        │  ├─ domain
│        │  └─ presentation
│        ├─ home
│        │  ├─ data
│        │  ├─ domain
│        │  └─ presentation
│        ├─ profile
│        │  ├─ data
│        │  ├─ domain
│        │  └─ presentation
│        ├─ settings
│        │  ├─ data
│        │  ├─ domain
│        │  └─ presentation
│        ├─ status
│        │  ├─ data
│        │  ├─ domain
│        │  └─ presentation
│        └─ welcome
│           ├─ data
│           ├─ domain
│           └─ presentation
│             
```

## 🚀 Getting Started

### Prerequisites

1. Flutter SDK: Install the latest stable version.
2. Firebase Setup: Ensure you have the google-services.json (Android) and GoogleService-Info.plist (iOS) placed in their respective folders (Not included in repo for security).

### Installation

1. Clone the repository:

```bash
git clone [https://github.com/mo-adel-tronic/clone_whatsapp_round34.git](https://github.com/mo-adel-tronic/clone_whatsapp_round34.git)
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

## 🤝 Project Lead

Mohamed Abouzaid - Team Leader & Maintainer

