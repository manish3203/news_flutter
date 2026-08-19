<h1 align="center">
  📰 News18 — Flutter News App
</h1>

<p align="center">
  A clean, production-ready Flutter news application built with GetX state management,<br/>
  News API integration, Hive local storage, and a polished Material 3 UI.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white"/>
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white"/>
  <img src="https://img.shields.io/badge/GetX-State%20Management-8A2BE2?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Hive-Local%20DB-FF7043?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/NewsAPI-integrated-00B4D8?style=for-the-badge"/>
</p>

---

## ✨ Features

| Feature | Details |
|---------|---------|
| 🚀 **Splash Screen** | Animated bounce icon with sequential fade-in title |
| 🏠 **Home Screen** | Clean article feed with AppBar and bottom navigation |
| 🌐 **News API Integration** | Live news fetched via [NewsAPI.org](https://newsapi.org) using Dio |
| 🗂️ **Categories / Tabs** | Horizontally scrollable category chips (All, Business, Tech, Sports, Health, Science, Entertainment) |
| 📋 **Category-wise News** | Each category fetches dedicated top headlines |
| ⚙️ **GetX State Management** | Full reactive state with `Rx`, `Obx`, `GetxController`, and named routes |
| 📰 **Article List** | Card-based feed with thumbnail, source, headline, and publish time |
| 📄 **Article Details** | Hero image with gradient overlay, author avatar, formatted date, full content |
| 🧭 **Navigation** | Named routing (`Get.toNamed`) + `NavigationBar` for Home ↔ Bookmarks |
| ♾️ **Pagination** | Infinite scroll — loads next page when 200px from bottom |
| 🔄 **Pull-to-Refresh** | `RefreshIndicator` on both list and empty states |
| ⏳ **Loading States** | Full-screen shimmer loader, inline "load more" spinner, 6-state `NewsStatus` enum |
| ⚠️ **Error Handling** | Network-aware error screen with retry, custom `NetworkException` mapping |
| 🌗 **Light / Dark Theme** | Full Material 3 light & dark themes, follows system preference |
| 🔖 **Bookmark Articles** | Save/unsave articles persisted locally with Hive — survive app restarts |
| 📤 **Share Article** | Share article URL natively via `share_plus` |

---

## 🏗️ Architecture

The project follows a **feature-first clean architecture** with clear separation of concerns:

```
lib/
├── main.dart                        # App entry point — GetMaterialApp, Hive, dotenv
│
├── app/
│   ├── bindings/
│   │   └── initial_binding.dart     # Global dependency injection
│   └── routes/
│       ├── app_pages.dart           # Route definitions with bindings
│       └── app_routes.dart          # Route name constants
│
├── core/
│   ├── config/                      # EnvConfig — loads API key from .env
│   ├── constants/                   # API base URL, timeouts
│   ├── enums/
│   │   └── news_category.dart       # NewsCategory enum with labels
│   ├── network/
│   │   ├── api_client.dart          # Dio client with interceptors
│   │   ├── network_exceptions.dart  # Typed exception mapping
│   │   └── network_info.dart        # Connectivity check
│   ├── theme/
│   │   ├── app_colors.dart          # Design token colors
│   │   ├── app_text_style.dart      # Typography scale
│   │   └── app_theme.dart           # Light & dark ThemeData
│   └── utils/
│
├── data/
│   ├── local_db/
│   │   └── book_mark_local_db.dart  # Hive box read/write
│   ├── models/                      # Freezed + JSON serializable models
│   │   ├── article_model.dart
│   │   ├── news_response_model.dart
│   │   └── source_model.dart
│   └── repositories/
│       ├── news_repository.dart     # Remote news data source
│       └── book_mark_repository.dart # Bookmark CRUD
│
└── feature/
    ├── splash/                      # Splash screen (view + controller + binding)
    ├── home/                        # Home feed (view + controller + binding)
    │   └── widgets/
    │       ├── article_card.dart    # News card widget
    │       ├── category_tabs.dart   # Scrollable category chips
    │       ├── loading_view.dart    # Full-screen & inline loaders
    │       └── error_view.dart      # Error + retry widget
    ├── details/                     # Article detail page
    └── bookmark/                    # Saved articles screen
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter 3.x (Dart 3.x) |
| State Management | [GetX](https://pub.dev/packages/get) `^4.7.3` |
| HTTP Client | [Dio](https://pub.dev/packages/dio) `^5.11.0` |
| Local Storage | [Hive](https://pub.dev/packages/hive) `^2.2.3` + `hive_flutter` |
| Environment Variables | [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) `^6.0.1` |
| Code Generation | [Freezed](https://pub.dev/packages/freezed) + [json_serializable](https://pub.dev/packages/json_serializable) |
| Sharing | [share_plus](https://pub.dev/packages/share_plus) `^13.3.0` |
| Connectivity | [connectivity_plus](https://pub.dev/packages/connectivity_plus) `^7.3.1` |
| Web View | [webview_flutter](https://pub.dev/packages/webview_flutter) `^4.14.1` |
| Date Formatting | [intl](https://pub.dev/packages/intl) `^0.20.3` |
| Design System | Material 3 — custom light & dark themes |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.x`
- Dart SDK `>=3.x`
- A free API key from [https://newsapi.org](https://newsapi.org)

### 1. Clone the repository

```bash
git clone https://github.com/<your-username>/news_18.git
cd news_18
```

### 2. Set up the API key

Create a `.env` file in the project root:

```env
NEWS_API_KEY=your_api_key_here
```

> ⚠️ The `.env` file is listed in `.gitignore` — never commit your API key.

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Run code generation (if needed)

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 5. Run the app

```bash
flutter run
```

---

## 📱 Screens

| Screen | Description |
|--------|-------------|
| **Splash** | Animated logo → auto-navigates to Home |
| **Home** | Category tabs + scrollable article cards + pull-to-refresh |
| **Article Detail** | Full-screen hero image, author info, article body, bookmark & share |
| **Bookmarks** | Locally saved articles (persisted with Hive) |

---

## 🔑 Key Design Decisions

- **Feature-first structure** — each screen owns its view, controller, and binding, making the codebase easy to scale.
- **Repository pattern** — data sources are abstracted behind repository interfaces, decoupling UI from API/DB details.
- **Typed error handling** — `NetworkException` maps every Dio error type (timeout, 401, 404, 500, no-internet) to a user-friendly message.
- **6-state `NewsStatus` enum** — `loading`, `refreshing`, `loadingMore`, `success`, `empty`, `error` — ensures every UI state is explicitly handled.
- **Hive for bookmarks** — lightweight, no-SQL local persistence with zero setup overhead for the given use-case.
- **dotenv for secrets** — API key stored in `.env`, never hardcoded.

---

## 📄 License

This project is intended as a portfolio/assignment demonstration.

---

<p align="center">
  Built with ❤️ using Flutter &nbsp;•&nbsp; Manish
</p>
