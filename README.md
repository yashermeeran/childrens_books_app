# Children's Books App

A Flutter application for children's books designed with a beautiful and interactive interface.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

1. **Flutter SDK** - The software development kit for Flutter
2. **Dart** - The programming language used by Flutter
3. **Git** - For cloning the repository
4. **Android Studio** or **VS Code** - IDE with Flutter plugins
5. **Android Emulator** or a physical device for testing

## Setup Instructions for Beginners

### 1. Install Flutter

#### On macOS:
```bash
# Download Flutter SDK from https://flutter.dev/docs/get-started/install/macos
# Extract the file to a desired location, for example:
cd ~/development
unzip ~/Downloads/flutter_macos_3.x.x-stable.zip
```

#### On Windows:
```bash
# Download Flutter SDK from https://flutter.dev/docs/get-started/install/windows
# Extract the zip file to a desired location (avoid spaces in the path)
```

#### On Linux:
```bash
# Download Flutter SDK from https://flutter.dev/docs/get-started/install/linux
# Extract it to your desired location
cd ~/development
tar xf ~/Downloads/flutter_linux_3.x.x-stable.tar.xz
```

### 2. Add Flutter to your path

#### On macOS/Linux:
```bash
# Add the following line to your .bashrc, .zshrc, or other shell configuration file
export PATH="$PATH:`pwd`/flutter/bin"
```

#### On Windows:
Add Flutter's bin directory to your PATH environment variable.

### 3. Verify Installation
```bash
flutter doctor
```
Follow any instructions provided by the `flutter doctor` command to complete setup.

### 4. Clone the Repository
```bash
git clone https://github.com/yourusername/childrens_books_app.git
cd childrens_books_app
```

### 5. Get Dependencies
```bash
flutter pub get
```

## Running the Application

### 1. Start an Emulator or Connect a Device
- Open Android Studio and start an emulator
- OR connect a physical device with USB debugging enabled

### 2. Check Available Devices
```bash
flutter devices
```

### 3. Run the App
```bash
flutter run
```

### 4. Clone the Repository
```bash
git clone https://github.com/yourusername/childrens_books_app.git
cd childrens_books_app 
```

This will build the app and install it on your connected device or emulator.

### 5. Hot Reload (during development)
When the app is running, you can use:
- Press `r` in the terminal to hot reload (update code while preserving state)
- Press `R` to perform a full restart

## Project Structure

- `lib/` - Contains all Dart code for the application
  - `main.dart` - Entry point of the application
  - `models/` - Data models
  - `screens/` - UI screens
  - `services/` - API and backend services
  - `widgets/` - Reusable UI components
- `assets/` - Contains images, fonts, and other static files
- `pubspec.yaml` - Project configuration and dependencies

## Troubleshooting

If you encounter issues:

1. Run `flutter doctor` for diagnostics
2. Ensure all dependencies are up to date with `flutter pub get`
3. Clean the project with `flutter clean` and then `flutter pub get`
4. Check if there's a newer Flutter version with `flutter upgrade`

## Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [Flutter YouTube Channel](https://www.youtube.com/c/flutterdev)
- [Flutter Community](https://flutter.dev/community)