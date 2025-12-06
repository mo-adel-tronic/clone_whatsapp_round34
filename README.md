# clone_whatsapp_round34

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

*Figma Design*

https://www.figma.com/design/BYzPXj6s2OOgUJktOVPANI/WhatsApp-Clone-Redesign--Community-?node-id=9-706&t=bBvSVd2D8N7ZE3ce-1


العناوين في الـ AppBar: استخدم Theme.of(context).textTheme.headlineMedium.

أسماء الأشخاص في قائمة الشات: استخدم Theme.of(context).textTheme.titleMedium.

نص الرسالة نفسها: استخدم Theme.of(context).textTheme.bodyLarge.

وقت الرسالة (الساعة): استخدم Theme.of(context).textTheme.labelSmall.

الأوصاف الرمادية (Bio): استخدم Theme.of(context).textTheme.bodyMedium.

# Project Tree

```
clone_whatsapp_round34
├─ .metadata
├─ analysis_options.yaml
├─ assets
│  ├─ fonts
│  │  ├─ ar
│  │  │  ├─ NotoSansArabic-Bold.ttf
│  │  │  ├─ NotoSansArabic-Medium.ttf
│  │  │  └─ NotoSansArabic-Regular.ttf
│  │  └─ en
│  │     ├─ Roboto-Bold.ttf
│  │     ├─ Roboto-Medium.ttf
│  │     └─ Roboto-Regular.ttf
│  └─ images
│     ├─ circle.png
│     ├─ doodle_bg.png
│     └─ splash
│        ├─ whatsapp_dark.png
│        └─ whatsapp_light.png
├─ lib
│  ├─ app.dart
│  ├─ generated
│  │  ├─ intl
│  │  │  ├─ messages_all.dart
│  │  │  ├─ messages_ar.dart
│  │  │  └─ messages_en.dart
│  │  └─ l10n.dart
│  ├─ l10n
│  │  ├─ intl_ar.arb
│  │  └─ intl_en.arb
│  ├─ main.dart
│  └─ src
│     ├─ core
│     │  ├─ animation
│     │  │  ├─ animation.dart
│     │  │  ├─ custom_page_route.dart
│     │  │  ├─ enums.dart
│     │  │  └─ page_transition.dart
│     │  ├─ api
│     │  │  └─ api.dart
│     │  ├─ config
│     │  │  ├─ config.dart
│     │  │  ├─ container.dart
│     │  │  ├─ injection.dart
│     │  │  └─ keyboard.dart
│     │  ├─ constants
│     │  │  ├─ constants.dart
│     │  │  ├─ durations.dart
│     │  │  ├─ images.dart
│     │  │  └─ pref_keys.dart
│     │  ├─ error
│     │  │  ├─ error.dart
│     │  │  └─ failure.dart
│     │  ├─ global
│     │  │  └─ global.dart
│     │  ├─ keys
│     │  │  └─ keys.dart
│     │  ├─ localization
│     │  │  ├─ language_cubit.dart
│     │  │  ├─ language_data_source.dart
│     │  │  └─ localization.dart
│     │  ├─ middleware
│     │  │  └─ middleware.dart
│     │  ├─ routes
│     │  │  ├─ names.dart
│     │  │  ├─ pages.dart
│     │  │  └─ routes.dart
│     │  ├─ services
│     │  │  └─ services.dart
│     │  ├─ theme
│     │  │  ├─ app_color.dart
│     │  │  ├─ app_text.dart
│     │  │  ├─ app_theme.dart
│     │  │  └─ theme.dart
│     │  ├─ usecases
│     │  │  └─ usecases.dart
│     │  ├─ utils
│     │  │  ├─ country_code_picker.dart
│     │  │  └─ utils.dart
│     │  └─ widgets
│     │     ├─ custom_elevated_button.dart
│     │     └─ widgets.dart
│     └─ features
│        ├─ auth
│        │  ├─ data
│        │  │  ├─ implements
│        │  │  │  └─ implements.dart
│        │  │  ├─ models
│        │  │  │  └─ models.dart
│        │  │  └─ sources
│        │  │     └─ sources.dart
│        │  ├─ domain
│        │  │  ├─ entities
│        │  │  │  └─ entities.dart
│        │  │  ├─ repositories
│        │  │  │  └─ repositories.dart
│        │  │  └─ usecases
│        │  │     └─ usecases.dart
│        │  └─ presentation
│        │     ├─ pages
│        │     │  ├─ finger_print_page.dart
│        │     │  ├─ login_page.dart
│        │     │  └─ otp_page.dart
│        │     └─ widgets
│        │        └─ widgets.dart
│        ├─ calls
│        │  ├─ data
│        │  │  ├─ implements
│        │  │  │  └─ implements.dart
│        │  │  ├─ models
│        │  │  │  └─ models.dart
│        │  │  └─ sources
│        │  │     └─ sources.dart
│        │  ├─ domain
│        │  │  ├─ entities
│        │  │  │  └─ entities.dart
│        │  │  ├─ repositories
│        │  │  │  └─ repositories.dart
│        │  │  └─ usecases
│        │  │     └─ usecases.dart
│        │  └─ presentation
│        │     ├─ pages
│        │     │  ├─ calls_page.dart
│        │     │  ├─ video_call_page.dart
│        │     │  └─ voice_call_page.dart
│        │     └─ widgets
│        │        └─ widgets.dart
│        ├─ chat
│        │  ├─ data
│        │  │  ├─ implements
│        │  │  │  └─ implements.dart
│        │  │  ├─ models
│        │  │  │  └─ models.dart
│        │  │  └─ sources
│        │  │     └─ sources.dart
│        │  ├─ domain
│        │  │  ├─ entities
│        │  │  │  └─ entities.dart
│        │  │  ├─ repositories
│        │  │  │  └─ repositories.dart
│        │  │  └─ usecases
│        │  │     └─ usecases.dart
│        │  └─ presentation
│        │     ├─ pages
│        │     │  ├─ camera_page.dart
│        │     │  └─ chat_page.dart
│        │     └─ widgets
│        │        └─ widgets.dart
│        ├─ home
│        │  ├─ data
│        │  │  ├─ implements
│        │  │  │  └─ implements.dart
│        │  │  ├─ models
│        │  │  │  └─ models.dart
│        │  │  └─ sources
│        │  │     └─ sources.dart
│        │  ├─ domain
│        │  │  ├─ entities
│        │  │  │  └─ entities.dart
│        │  │  ├─ repositories
│        │  │  │  └─ repositories.dart
│        │  │  └─ usecases
│        │  │     └─ usecases.dart
│        │  └─ presentation
│        │     ├─ pages
│        │     │  ├─ home_page.dart
│        │     │  └─ starred_messages_page.dart
│        │     └─ widgets
│        │        └─ widgets.dart
│        ├─ profile
│        │  ├─ data
│        │  │  ├─ implements
│        │  │  │  └─ implements.dart
│        │  │  ├─ models
│        │  │  │  └─ models.dart
│        │  │  └─ sources
│        │  │     └─ sources.dart
│        │  ├─ domain
│        │  │  ├─ entities
│        │  │  │  └─ entities.dart
│        │  │  ├─ repositories
│        │  │  │  └─ repositories.dart
│        │  │  └─ usecases
│        │  │     └─ usecases.dart
│        │  └─ presentation
│        │     ├─ pages
│        │     │  └─ profile_page.dart
│        │     └─ widgets
│        │        └─ widgets.dart
│        ├─ settings
│        │  ├─ data
│        │  │  ├─ implements
│        │  │  │  └─ implements.dart
│        │  │  ├─ models
│        │  │  │  └─ models.dart
│        │  │  └─ sources
│        │  │     └─ sources.dart
│        │  ├─ domain
│        │  │  ├─ entities
│        │  │  │  └─ entities.dart
│        │  │  ├─ repositories
│        │  │  │  └─ repositories.dart
│        │  │  └─ usecases
│        │  │     └─ usecases.dart
│        │  └─ presentation
│        │     ├─ pages
│        │     │  ├─ linked_devices_page.dart
│        │     │  └─ setting_page.dart
│        │     └─ widgets
│        │        └─ widgets.dart
│        ├─ status
│        │  ├─ data
│        │  │  ├─ implements
│        │  │  │  └─ implements.dart
│        │  │  ├─ models
│        │  │  │  └─ models.dart
│        │  │  └─ sources
│        │  │     └─ sources.dart
│        │  ├─ domain
│        │  │  ├─ entities
│        │  │  │  └─ entities.dart
│        │  │  ├─ repositories
│        │  │  │  └─ repositories.dart
│        │  │  └─ usecases
│        │  │     └─ usecases.dart
│        │  └─ presentation
│        │     ├─ pages
│        │     │  ├─ status_create_page.dart
│        │     │  ├─ status_page.dart
│        │     │  └─ status_view_page.dart
│        │     └─ widgets
│        │        └─ widgets.dart
│        └─ welcome
│           ├─ data
│           │  ├─ implements
│           │  │  └─ implements.dart
│           │  ├─ models
│           │  │  └─ models.dart
│           │  └─ sources
│           │     └─ sources.dart
│           ├─ domain
│           │  ├─ entities
│           │  │  └─ entities.dart
│           │  ├─ repositories
│           │  │  └─ repositories.dart
│           │  └─ usecases
│           │     └─ usecases.dart
│           └─ presentation
│              ├─ pages
│              │  └─ welcome_page.dart
│              └─ widgets
│                 └─ widgets.dart
├─ pubspec.lock
├─ pubspec.yaml
├─ README.md
├─ test
│  └─ widget_test.dart
```