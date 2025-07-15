# algoocean

# 📰 Newsly — Flutter News App

**Newsly** is a sleek and responsive Flutter application that delivers real-time news powered by [NewsAPI.org](https://newsapi.org). Built using **Clean Architecture**, it supports **theme switching**, **shimmer loading**, **pull-to-refresh**, **cached images**, and configuration via `.env`.

---

## 🚀 Features

- 🔥 **Top Headlines**: Displays the latest news via `/top-headlines`.
- 🗂️ **News by Category**: Filter articles by categories like business, tech, sports, etc.  via `/everything`.
- 📃 **News Details Page**: Read full articles with formatted HTML.
- 📑 **Bookmarks**: Save articles locally using Shared Preferences.
- 🎨 **Theme Switcher**: Toggle between light and dark mode dynamically.
- 👤 **Profile Screen**: Simple profile UI with access to settings/bookmarks.
- 🔁 **Pull-to-Refresh**: Refresh data with a simple swipe.
- 💫 **Shimmer Loading**: Better UX with animated loading placeholders.
- 📦 **Clean Architecture**: Organized folder structure and separation of concerns.
- 🔐 **Environment Variables**: Secure API key using `.env` file.

---

## 📂 Project Structure

```
lib/
├── main.dart
├── core/
│   ├── constants/          # API endpoints and keys
│   ├── network/            # Dio configuration
│   ├── routes/             # App navigation
│   ├── services/           # Common services
│   └── utils/              # Helpers (e.g., date formatting)
│
├── features/
│   ├── splash/             # Splash screen
│   ├── home/               # Home screen, widgets, controllers
│   ├── categories/         # Category chips & news list
│   ├── search/             # News search functionality
│   ├── newsdetail/         # Article detail view
│   ├── explore/            # Explore screen
│   ├── bookmark/           # Bookmarked news
│   └── profile/            # User profile section
│
└── themes/
    ├── app_theme.dart      # Light/Dark theme configs
    └── controller/         # ThemeController using GetX
```

---

## 🛠️ Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/opranjan/algoocean-assignment.git
cd algoocean-assignment
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Set Up Environment Variables

Create your `.env` file based on the included `.env.example`:

```bash
cp .env.example .env
```

Edit `.env` and add your [NewsAPI](https://newsapi.org) key:

```env
NEWS_API_KEY=your_api_key_here
```

> You can sign up for a free API key at [newsapi.org](https://newsapi.org).

### 4. Run the App

```bash
flutter run
```

---

## 📱 Android Configuration

Ensure internet permission is added to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

---

## 🧩 Dependencies Used

```yaml
dependencies:
  dio: ^5.8.0+1
  get: ^4.7.2
  cached_network_image:
  intl:
  flutter_html: ^3.0.0
  shared_preferences: ^2.5.3
  shimmer: ^3.0.0
  flutter_dotenv: ^5.1.0
```


## 👨‍💻 Author

Made with ❤️ by [Omprakash Ranjan](https://github.com/opranjan)
