# LMS - Learning Management System

A comprehensive educational Flutter application built with Clean Architecture principles, providing a structured learning experience through multiple educational levels, subjects, lessons, and interactive quizzes.

## 🚀 Features

### Core Features
- **Authentication System** - Secure login with device information integration
- **Educational Hierarchy Navigation** - Systems → Stages → Classrooms → Terms → Paths
- **Subjects Management** - Complete subject display with all API data
- **Lessons & Units** - Organized lesson structure with progress tracking
- **Interactive Quizzes** - Comprehensive quiz system with validation and scoring
- **Splash Screen** - Animated logo with smooth transitions

### Technical Features
- **Clean Architecture** - Proper separation of concerns (Presentation, Domain, Data)
- **MVVM Pattern** - Model-View-ViewModel architecture
- **Dependency Injection** - Using `get_it` for service management
- **State Management** - Provider pattern throughout the app
- **API Integration** - Complete integration with all specified endpoints
- **Error Handling** - Comprehensive error management and user feedback
- **Loading States** - Skeleton screens and progress indicators
- **Offline Capability** - Local caching for better user experience
- **Responsive Design** - Support for multiple screen sizes
- **Accessibility** - Proper semantic labels and contrast ratios

## 🏗️ Architecture

The app follows Clean Architecture principles with the following structure:

```
lib/
├── core/                    # Core functionality
│   ├── constants/          # App constants and configuration
│   ├── error/              # Error handling and failure types
│   ├── network/            # API client and network configuration
│   ├── services/           # Core services (API testing, device info)
│   ├── splash/             # Splash screen implementation
│   ├── theme/              # App theme and styling
│   └── utils/              # Utility functions and services
├── features/               # Feature modules
│   ├── auth/               # Authentication feature
│   │   ├── data/           # Data layer (models, datasources, repositories)
│   │   ├── domain/         # Domain layer (entities, use cases, repositories)
│   │   └── presentation/   # Presentation layer (screens, widgets, providers)
│   ├── home/               # Home screen feature
│   ├── subjects/           # Subjects feature
│   ├── lessons/            # Lessons feature
│   └── quiz/               # Quiz feature
└── main.dart               # App entry point
```

## 🔧 Setup Instructions

### Prerequisites
- Flutter SDK (3.9.0 or higher)
- Dart SDK (3.9.0 or higher)
- Android Studio / VS Code
- Android/iOS development environment

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd lms
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Add app logo**
   - Place your `lmsLogo.png` file in `assets/images/` directory
   - The logo should be 512x512 pixels for best results

4. **Generate app icons and splash screen**
   ```bash
   flutter pub run flutter_launcher_icons:main
   flutter pub run flutter_native_splash:create
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 📱 API Integration

The app integrates with the following API endpoints:

### Authentication
- `POST /api/login` - User authentication with device info

### Data Endpoints
- `POST /api/public/systems` - Get education systems
- `POST /api/public/stages` - Get educational stages
- `POST /api/public/classrooms` - Get classrooms/grades
- `POST /api/public/terms` - Get academic terms
- `POST /api/public/paths` - Get educational tracks
- `POST /api/public/subjects` - Get subjects
- `POST /api/lessons` - Get lessons
- `POST /api/lessons/questions` - Get lesson questions
- `POST /api/add/lesson/question/answer` - Submit answer

### Base URL
```
https://taseese.org
```

## 🎨 UI/UX Design

- **Theme**: Black and white color scheme with Cairo font
- **Design**: Material Design 3 guidelines
- **Responsive**: Support for multiple screen sizes
- **Accessibility**: Proper semantic labels and contrast ratios
- **Animations**: Smooth transitions between screens
- **Loading States**: Skeleton screens and progress indicators

## 🧪 Testing

The app includes comprehensive testing:

### Unit Tests
- Core functionality testing
- Entity and model testing
- Utility function testing

### Widget Tests
- UI component testing
- User interaction testing
- Theme and styling testing

### Integration Tests
- End-to-end testing
- Navigation testing
- Performance testing

### Running Tests
```bash
# Run all tests
flutter test

# Run specific test files
flutter test test/unit_tests.dart
flutter test test/widget_tests.dart

# Run integration tests
flutter test integration_test/
```

## 📦 Build for Release

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 🔒 Security Features

- Secure token storage using SharedPreferences
- Device information integration for authentication
- Input validation and sanitization
- Error handling without exposing sensitive information

## 📊 Performance Optimizations

- Image caching with `cached_network_image`
- Lazy loading for lists and grids
- Memory management for large datasets
- Smooth animations and transitions
- Efficient state management

## 🚀 Deployment

The app is ready for production deployment with:

- Release mode optimization
- App icon and splash screen generation
- Proper error handling and logging
- Comprehensive testing coverage
- Clean architecture implementation

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📞 Support

For support and questions, please contact the development team or create an issue in the repository.

---

**Built with ❤️ using Flutter and Clean Architecture principles**