# AI Forensic Mobile Application - Complete Documentation

## 📱 Project Overview

**AI Forensic** is a Flutter-based security monitoring and incident response application designed for real-time threat detection, forensic analysis, and security event tracking. The application provides a comprehensive dashboard for security teams to monitor system security metrics, manage incidents, receive alerts, and track security events across distributed systems.

### Project Goals
- 🎯 Real-time security event monitoring
- 🔐 Incident management and tracking
- 📊 Security metrics visualization
- 🚨 Smart alert notifications
- 🌍 Multi-language support (Arabic & English)
- 🎨 Responsive UI design with dark/light themes

---

## 🏗️ Architecture & Technology Stack

### Core Technologies
| Technology | Version | Purpose |
|-----------|---------|---------|
| **Flutter** | 3.3.0+ | Cross-platform mobile framework |
| **Dart** | Latest | Programming language |
| **Riverpod** | 2.5.1 | State management |
| **GoRouter** | 14.2.0 | Navigation & routing |
| **Dio** | 5.5.0 | HTTP client & networking |
| **Freezed** | Latest | Code generation for immutable models |
| **JSON Serializable** | Latest | JSON serialization |
| **Shared Preferences** | 2.2.2 | Local data persistence |

### Project Structure

```
lib/
├── main.dart                          # Application entry point
├── app/
│   ├── app.dart                      # App configuration
│   └── router.dart                   # GoRouter setup
├── models/                            # Freezed data models
│   ├── user.dart
│   ├── incident.dart
│   ├── alert.dart
│   ├── severity.dart
│   └── security_metric.dart
├── services/                          # Business logic layer
│   ├── api_service.dart              # API communication
│   └── local_storage_service.dart    # Data persistence
├── providers/                         # Riverpod providers
│   ├── auth_provider.dart
│   ├── incidents_provider.dart
│   ├── alerts_provider.dart
│   └── settings_provider.dart
├── core/                              # Shared resources
│   ├── theme/                        # Theme & styling
│   ├── widgets/                      # Reusable components
│   ├── validators/                   # Input validation
│   └── assets/                       # Static assets
└── features/                          # Feature modules
    ├── splash/                       # App splash & logout
    ├── onboarding/                   # Welcome flow
    ├── auth/                         # Login & signup
    ├── home/                         # Security dashboard
    ├── incidents/                    # Incident management
    ├── alerts/                       # Alert notifications
    ├── notifications/                # Notification center
    ├── profile/                      # User profile
    ├── settings/                     # App preferences
    └── info/                         # Help & documentation
```

---

## 🔐 Core Data Models

### User Model
```dart
User {
  - id: String (unique identifier)
  - name: String
  - email: String
  - role: String (admin, analyst, viewer)
  - timezone: String
  - notifications: bool
  - avatar: String? (optional)
  - createdAt: DateTime
}
```

### Incident Model
```dart
Incident {
  - id: String
  - title: String
  - description: String
  - severity: Severity (low, medium, high, critical)
  - sourceIp: String
  - status: String (open, in_progress, resolved)
  - eventCount: int
  - timestamp: DateTime
  - detailedData: Map<String, dynamic>?
}
```

### Alert Model
```dart
Alert {
  - id: String
  - title: String
  - message: String
  - severity: Severity
  - alertType: String
  - sourceIp: String
  - isRead: bool
  - timestamp: DateTime
}
```

### SecurityMetric Model
```dart
SecurityMetric {
  - cpu: double (0.0 - 100.0)
  - memory: double (0.0 - 100.0)
  - diskUsage: double (0.0 - 100.0)
  - networkActivity: double
  - timestamp: DateTime
}
```

---

## 🎮 Features Overview

### 1. Splash Screen
- **Location:** `lib/features/splash/`
- **Purpose:** App initialization, session validation, logout flow
- **Key Components:** Logo animation, loading states

### 2. Onboarding
- **Location:** `lib/features/onboarding/`
- **Purpose:** 4-screen welcome flow for new users
- **Screens:** Welcome, Features, Permissions, Get Started
- **Flow:** Only shown on first app launch

### 3. Authentication
- **Location:** `lib/features/auth/`
- **Screens:**
  - Login with email/password
  - Sign up for new accounts
  - Forgot password recovery
  - OTP verification (if applicable)
- **Security:** JWT token management, secure token storage

### 4. Security Dashboard (Home)
- **Location:** `lib/features/home/`
- **Purpose:** Main monitoring dashboard
- **Features:**
  - Real-time security metrics display
  - Quick stats cards (incidents, alerts)
  - Recent incidents widget
  - System health indicators
- **Components:** BottomNavigationBar for feature navigation

### 5. Incidents Management
- **Location:** `lib/features/incidents/`
- **Purpose:** Complete incident lifecycle management
- **Features:**
  - Tabbed incident filtering (All / Open / In Progress / Resolved)
  - Incident list with search & sort
  - Incident details with full event data
  - Status update functionality
  - Severity-based color coding

### 6. Security Alerts
- **Location:** `lib/features/alerts/`
- **Purpose:** Real-time security alert management
- **Features:**
  - Alert list with severity filtering
  - Unread alert counter
  - Mark as read/unread
  - Severity-based categorization
  - Alert dismissal

### 7. Notifications
- **Location:** `lib/features/notifications/`
- **Purpose:** User notification center
- **Features:**
  - Push notification history
  - Notification read status
  - Notification filtering
  - Clear notifications

### 8. User Profile
- **Location:** `lib/features/profile/`
- **Purpose:** User information & profile management
- **Features:**
  - Display user information
  - Profile picture management
  - Edit profile details
  - Logout functionality

### 9. Settings
- **Location:** `lib/features/settings/`
- **Purpose:** Application preferences
- **Features:**
  - Theme selection (Light/Dark)
  - Language selection (Arabic/English)
  - Notification preferences
  - Privacy settings

### 10. Information
- **Location:** `lib/features/info/`
- **Purpose:** Help & documentation
- **Features:**
  - About app
  - FAQ
  - Contact support
  - Terms & Privacy

---

## 🔌 Services Architecture

### ApiService
**Purpose:** Centralized HTTP communication with backend API

**Features:**
- Dio client configuration
- Authentication interceptor
- Error handling & response parsing
- Request/response logging
- Timeout configuration

**Methods:**
```dart
- get(endpoint, queryParameters?)
- post(endpoint, data?)
- put(endpoint, data?)
- delete(endpoint)
- upload(file, endpoint)
```

### LocalStorageService
**Purpose:** Persistent local data storage

**Features:**
- Auth token persistence
- User data caching
- App settings storage
- Session management

**Methods:**
```dart
- saveToken(token)
- getToken() -> String?
- saveUserData(user)
- getUserData() -> User?
- saveSetting(key, value)
- getSetting(key) -> dynamic?
- clearAll()
```

---

## 🎨 Core UI Components

### AppButton
Multiple button styles for different contexts:
- **Primary:** Main action buttons (blue background)
- **Secondary:** Alternative actions (light background)
- **Outline:** Bordered buttons
- **Danger:** Destructive actions (red)
- **Success:** Positive actions (green)

### AppTextField
Text input component with:
- Input validation
- Error message display
- Password visibility toggle
- Customizable keyboard types
- Icon support

### AppScaffold
Base scaffold widget with:
- Gradient background support
- Safe area handling
- Custom app bar
- Floating action button support

### LoadingView
Shimmer skeleton loaders for:
- List items
- Cards
- Custom layouts

### ErrorView
Error handling UI:
- Full-screen error states
- Error dialogs
- Retry functionality

### AppToast
Toast notifications with:
- Success/Error/Warning/Info types
- Custom duration
- Auto-dismiss

### AppBarWidget
Custom app header with:
- Title configuration
- Back button
- Action buttons
- Search functionality

### BlurredDialog
Modal dialogs with:
- Background blur effect
- Animation
- Custom content

---

## 📊 State Management (Riverpod)

### Provider Architecture

**AuthProvider**
- Manages authentication state
- Handles login/logout/signup
- Token management
- User session tracking

**IncidentsProvider**
- Incidents list management
- Filtering & sorting
- Incident details
- Status updates
- Search functionality

**AlertsProvider**
- Alerts list management
- Unread count tracking
- Severity filtering
- Mark read/unread operations

**DashboardProvider**
- Real-time metrics
- Statistics calculation
- Quick stats

**SettingsProvider**
- Theme preference
- Language selection
- Notification settings
- User preferences

---

## 🌐 Localization Support

### Supported Languages
- **Arabic (ar)** - RTL (Right-to-Left) text direction
- **English (en)** - LTR (Left-to-Right) text direction

### Implementation
```dart
// Access localized strings
AppStrings.get('key_name', locale);

// Supported keys include all UI text across the app
```

### Language Switching
- Available in Settings feature
- Persisted via LocalStorageService
- Real-time UI update after selection

---

## 🎨 Theme System

### Color Scheme
Both dark and light modes with:
- Primary colors
- Secondary colors
- Error colors
- Background & surface colors
- Text colors

### Theme Configuration
- Defined in `core/theme/app_theme.dart`
- Material Design principles
- Accessibility compliance

### Dynamic Theme Switching
- Toggle in Settings
- Persisted preference
- System-wide UI update

---

## 🛣️ Navigation Flow

### GoRouter Setup (`app/router.dart`)

**Main Routes:**
```
/ → Splash Screen
/onboarding → Onboarding Flow
/login → Authentication
/home → Main Dashboard
  /incidents → Incidents List
    /incidents/:id → Incident Details
  /alerts → Alerts List
  /notifications → Notifications
  /profile → User Profile
  /settings → App Settings
  /info → Information
/logout → Splash Screen
```

### Deep Linking
- Supports URL-based navigation
- Dynamic segment parameters
- Named routes for easy reference

---

## 🔒 Security Features

### Authentication
- Secure token storage
- JWT-based authentication
- Login session management
- Automatic token refresh

### Data Protection
- Encrypted local storage
- Secure API communication (HTTPS)
- Token-based authorization headers

### Best Practices
- Avoid storing sensitive data in logs
- Use secure storage for tokens
- Implement request signing
- Validate all inputs

---

## 🧪 Testing Strategy

### Unit Tests
- Model serialization/deserialization
- Service logic
- Provider state management
- Validator functions

### Widget Tests
- UI component rendering
- User interactions
- State changes reflection

### Integration Tests
- Full user flows
- API integration
- Navigation paths

**Test Location:** `test/` directory

---

## 📦 Building & Deployment

### Prerequisites
```bash
- Flutter SDK (3.3.0+)
- Android SDK & Android Studio
- Xcode (macOS)
- CocoaPods (iOS)
```

### Build Commands

**Development Build**
```bash
flutter pub get
flutter run
```

**Production Build - Android**
```bash
flutter build apk --release
# or for App Bundle
flutter build appbundle --release
```

**Production Build - iOS**
```bash
flutter build ios --release
```

### Environment Configuration
- API Base URL
- API Keys
- Firebase configuration (if applicable)
- Analytics settings

---

## 📝 Code Style & Conventions

### Naming Conventions
- **Files:** snake_case (e.g., `app_theme.dart`)
- **Classes:** PascalCase (e.g., `MyWidget`)
- **Variables/Functions:** camelCase (e.g., `myVariable`)
- **Constants:** camelCase with `final` (e.g., `final apiBaseUrl`)

### Dart Style Guide
- Follow official Dart conventions
- Use `final` by default
- Avoid `var` for complex types
- Proper null safety with `?` and `!`

### Widget Patterns
- Stateless widgets for UI without state
- StatefulWidget for local state
- ConsumerWidget for Riverpod providers
- Proper build method structure

---

## 🤝 Contributing Guidelines

### Code Review Process
1. Create feature branch from `develop`
2. Implement features with tests
3. Create pull request
4. Address review comments
5. Merge after approval

### Commit Messages
- Clear, descriptive messages
- Reference issue numbers if applicable
- Use conventional commit format

### Before Submitting PR
- Run tests: `flutter test`
- Format code: `dart format .`
- Analyze code: `flutter analyze`
- No breaking changes without discussion

---

## 🚀 Common Tasks

### Adding a New Feature
1. Create feature folder in `lib/features/`
2. Add pages, widgets, models
3. Create Riverpod providers if needed
4. Add routes to `app/router.dart`
5. Add navigation in BottomNavigationBar or menu
6. Add localization strings
7. Write tests

### Adding a New Screen
1. Create new file in feature folder
2. Extend `ConsumerWidget` or `ConsumerStatefulWidget`
3. Build UI using core widgets
4. Connect state management with providers
5. Add route in router configuration

### Adding New Localization
1. Update `AppStrings` class
2. Add translations for both Arabic & English
3. Use `AppStrings.get(key, locale)` in widgets
4. Test RTL layout for Arabic

### Handling API Errors
1. Use `ApiService` for requests
2. Catch exceptions in providers
3. Display appropriate error UI
4. Provide retry mechanisms
5. Log errors for debugging

---

## 📋 Troubleshooting

### Common Issues

**Build Errors**
```bash
flutter clean
flutter pub get
flutter pub upgrade
flutter run
```

**Dependency Issues**
```bash
flutter pub get
flutter pub upgrade
flutter pub global activate dev_dependencies
```

**Emulator/Device Issues**
```bash
flutter devices
flutter clean
flutter run -v  # Verbose output for debugging
```

---

## 📚 Additional Resources

### Documentation
- [Flutter Official Docs](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Dio Documentation](https://pub.dev/packages/dio)

### Related Files
- `QUICK_START.md` - Quick setup guide
- `DEVELOPMENT_GUIDE.md` - Development workflow
- `TESTING_GUIDE.md` - Testing instructions
- `README.md` - Project overview

---

## 📞 Support & Contact

For questions or issues:
1. Check existing documentation
2. Review code comments
3. Consult team members
4. Check GitHub issues

---

**Last Updated:** May 2026
**Version:** 1.0
**Status:** Active Development
