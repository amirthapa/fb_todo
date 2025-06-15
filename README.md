# fb_todo


A Flutter application built using the [Stacked](https://pub.dev/packages/stacked) architecture for maintainable and scalable app development.

---

## 🚀 Getting Started

These instructions will help you install and run the project on your local machine for development and testing purposes.

### ✅ Prerequisites

- Flutter (latest stable version)
- Dart SDK (comes with Flutter)
- Android Studio or VS Code
- Android/iOS Emulator or Physical Device

### 🔧 Installation

1. **Clone the repository:**
   ```bash
  git clone https://github.com/amirthapa/fb_todo.git
bash
2. **Get the dependencies:**
   ```bash
flutter pub get
bash
3. **Run the project:** 
 ```bash
flutter run
bash
### 🧱 Architecture & Design
This app uses the Stacked architecture, which is built on top of MVVM and service-based architecture.

###  📦 Folder Structure
 ```bash
lib/
├── app/
│   └── app.dart               # App setup (router, dependency injection)
├── models/                    # Model classes
├── services/                  # Business logic and APIs
├── ui/
│   ├── views/                 # UI screens (View + ViewModel)
│   └── widgets/               # Reusable widgets
└── main.dart                  # App entry point
bash
      

