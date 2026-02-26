# Mneme

A lightweight note-taking app for iOS inspired by [TickTick](https://ticktick.com), built entirely in SwiftUI.

> *Mneme (Μνήμη) — Greek goddess of memory.*

## Overview

Mneme lets you capture quick notes and organize them into folders with a clean, minimal interface. It features a sidebar for folder navigation, a calendar view for browsing notes by date, and full-screen search across all your notes.

## Features

- **Quick Capture** — Floating action button with a compact add-note sheet for fast entry
- **Folder Organization** — Sidebar navigation with customizable folders (Inbox, Work, Personal, etc.)
- **Calendar View** — Month grid that smoothly collapses into a pinned week strip as you scroll
- **Full-Screen Search** — Search across all notes and folders with highlighted results
- **Custom Tab Bar** — Capsule-shaped tab bar with a live calendar date icon
- **Completion Tracking** — Mark notes as completed with a collapsible "Completed" section

## Architecture

| Layer | Purpose |
|-------|---------|
| `App/` | Entry point and centralized `AppState` (ObservableObject) |
| `Models/` | `Note` and `Folder` data models with sample data |
| `Utils/` | Design system — colors, typography, spacing, Date extensions |
| `Components/` | Reusable UI — `RoundButton`, `WhiteCard`, `FloatingFAB`, dropdown menus |
| `Views/` | All screens — Root, Sidebar, Notes, Calendar, Search, Settings |

**State management:** Single `AppState` class passed via `@EnvironmentObject`. No external dependencies.

**Navigation:** Fully custom — manual sidebar with spring animation, custom tab bar, and tab switching via index.

## Requirements

- iOS 17.0+
- Xcode 16+
- Swift 6

## Getting Started

```bash
git clone https://github.com/idanmos/Mneme.git
cd Mneme
open Mneme.xcodeproj
```

Build and run on the iOS Simulator or a physical device.

## Screenshots

| Notes List | Calendar | Compact Calendar | Settings |
|:---:|:---:|:---:|:---:|
| Folder-based notes with completion tracking | Month grid with task list per day | Week strip pinned on scroll | Grouped settings with profile card |

## License

This project is available under the MIT License.
