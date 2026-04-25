# Medipills 💊

> A clean and simple medication tracker — built with SwiftUI, available on the App Store.

![Swift](https://img.shields.io/badge/Swift-5.9-orange?logo=swift)
![iOS](https://img.shields.io/badge/iOS-16%2B-blue?logo=apple)
![Xcode](https://img.shields.io/badge/Xcode-15-blue?logo=xcode)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-purple)

---

## Screenshots

<!-- Add your screenshots here -->
<!-- Example:
<p align="center">
  <img src="Screenshots/home.png" width="200"/>
  <img src="Screenshots/add_medication.png" width="200"/>
  <img src="Screenshots/settings.png" width="200"/>
</p>
-->

---

## Features

- 💊 Add and manage your medications with custom schedules
- 🔔 Local notifications & snooze reminders
- 📋 Track your intake history
- 🌙 Light & Dark mode support (Comming soon)

---

## Tech Stack

| | |
|---|---|
| **UI** | SwiftUI |
| **Architecture** | MVVM |
| **Persistence** | SwiftData |
| **Notifications** | UserNotifications |

---

## Architecture

Medipills follows the **MVVM** pattern to keep a clear separation between UI and business logic.

```
MediPills/
├── Models/          # Data models (Medication, IntakeRecord...)
├── ViewModels/      # Business logic & state management
├── Views/           # SwiftUI views
└── Services/        # Notifications, persistence, export
```

---

## Getting Started

```bash
git clone https://github.com/RichardMzd/Medipills.git
cd Medipills
open Medipills.xcodeproj
```

> Requires Xcode 15+ and iOS 16+. No external dependencies.

---

## Author

**Richard Mazid** — Junior iOS Developer  
[LinkedIn](https://www.linkedin.com/in/richard-mazid) · [GitHub](https://github.com/RichardMzd)
