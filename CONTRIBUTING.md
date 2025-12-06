# 👷 Contributing Guidelines

Welcome to the team! To ensure a smooth workflow for our 10-member squad, please follow these strict guidelines. Chaos is not an option here!

## 🌳 Git Workflow Strategy

We use a **Feature Branch Workflow**.
- **`main`**: Production-ready code. DO NOT PUSH HERE DIRECTLY.

- **`develop`**: The integration branch. All features merge here first.

### 1. Starting a Task
Always pull the latest changes from `develop` before starting:
```bash
git checkout develop
git pull origin develop
git checkout -b feature/your-feature-name
```

_Branch Naming Convention:_

- Features: feature/auth-login, feature/chat-ui

- Bug Fixes: fix/message-delivery, fix/login-crash

### 2. Committing Changes

We follow Conventional Commits. Your commit message must be clear:

- feat: add otp verification screen

- fix: resolve overflow in chat bubble

- style: format code in auth repository

- enhance: optimize image loading logic

### 3. Pull Requests (PR)

When your task is done:

1. Push your branch to GitHub.

2. Open a Pull Request to the `develop` branch (NOT main).

3. No Merge is allowed without approval.

## 🏗 Coding Standards & Architecture

### Clean Architecture Rules

1. Dependency Rule: Domain layer must NOT depend on Data or Presentation.

2. Logic: All business logic goes into UseCases (Domain) or Bloc/Cubit (Presentation). NO logic in UI Widgets.

3. UI: Use ScreenUtil for all dimensions (e.g., 20.w, 15.sp) to ensure responsiveness.

### File Structure

- Place widgets specific to a page inside presentation/widgets.

- Place shared widgets in core/widgets.

- Use Colors And TextStyles from `theme`.

### Localization

- Do not hardcode strings. Always use S.of(context).yourString.

- Add new strings to lib/l10n/intl_en.arb and intl_ar.arb.

## ⚠️ Important Notes

- Assets: Add images to assets/images and run flutter pub get.

- Packages: Do not add new packages without Team Leader approval.