# Medipills 💊

> A clean and simple medication tracker — built with SwiftUI, soon available on the App Store.

![Swift](https://img.shields.io/badge/Swift-5.9-orange?logo=swift)
![iOS](https://img.shields.io/badge/iOS-16%2B-blue?logo=apple)
![Xcode](https://img.shields.io/badge/Xcode-26-blue?logo=xcode)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-purple)

---

## Screenshots

<p align="center">
  <img width="220" alt="Home" src="https://github.com/user-attachments/assets/e3143326-8b00-4545-9395-26b9deb354d2" />
  &nbsp;&nbsp;&nbsp;
  <img width="220" alt="Add medication" src="https://github.com/user-attachments/assets/7dca25c5-4bc2-41a7-8678-0c740ed040ff" />
  &nbsp;&nbsp;&nbsp;
  <img width="220" alt="Settings" src="https://github.com/user-attachments/assets/c38464b3-1c2b-4fd4-bc5b-e96212a9a315" />
</p>



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

**Richard Mazid** — iOS Developer  
[LinkedIn](https://www.linkedin.com/in/richard-mazid)
