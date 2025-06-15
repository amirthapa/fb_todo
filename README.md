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
   ``` bash
   git clone https://github.com/amirthapa/fb_todo.git
   
2. **Get the dependencies:**
    ``` bash
    flutter pub get

3. **Run the project:** 
    ``` bash
    flutter run

### 🧱 Architecture & Design
This app uses the Stacked architecture, which is built on top of MVVM and service-based architecture.

###  📦 Folder Structure
 ```
lib/
├── app/
│   └── app.dart               # App setup (router, dependency injection)
 
├── services/                  # Services and APIs
├── ui/
    ├──  Basic View(Dialog,Boottom Sheet)
│   ├── views/ └── view_class/          # UI screens (View )
                └── ViewModel/       ViewModel (State Management and Business Logics )         
│               └── Widgets/     # Reusable widgets
                                 
└── main.dart                  # App entry point

      

