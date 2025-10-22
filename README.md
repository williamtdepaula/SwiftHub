# SwiftHub

SwiftHub is an iOS app that allows you to explore the most popular Swift repositories on GitHub. By selecting a repository, you can view its Pull Requests (PRs), filter them by **Todos**, **Aberto**, **Fechado**, and **Mesclado**, and open each PR in a modal with a web view. The app leverages GitHub's APIs for this functionality.

---

## Light & Dark Mode Preview

The app supports theming for both light and dark modes:

![preview-light](preview-light.gif) ![preview-dark](preview-dark.gif)

---

## Features

- Browse the most popular Swift repositories.
- Infinite scrolling on the Home screen to load more repositories as you scroll.
- View Pull Requests for each repository.
- Infinite scrolling on the Pull Requests screen to load more PRs dynamically.
- Filter PRs by status: Todos (All), Aberto (Open), Fechado (Closed), Mesclado (Merged).
- Open PRs in a modal web view.
- Light and Dark mode support.
- Fully modular architecture with reusability in mind.
- Memory management validated using Debug Memory Graph.

---

## Architecture & Tech Stack

SwiftHub is built with **Swift**, using **MVVM**, **Coordinator Pattern**, **Clean Architecture**, and modularization via **Swift Package Manager (SPM)**.

**Key technologies:**

- **UIKit** – Core UI framework.
- **RxSwift** – Reactive programming for data binding and event handling.
- **Swinject** – Dependency injection for better decoupling and testability.
- **Swift Testing** – Unit tests with **100% coverage** for:
  - ViewModels
  - Mappers
  - Domains (UseCases)
  - Data layer (Repositories, DataSources, DTOs)

---

## CI/CD & Automation

- **Fastlane** – Automates tests.
- **GitHub Actions** – Runs automated unit tests on every Pull Request to ensure code quality.

## Modularization

SwiftHub is divided into the following modules for maximum reusability and separation of concerns:

### Core
- Shared logic and rules.
- Entities, models, and protocols for communication between layers.

### Infrastructure
- Clean Architecture layers:
  - **Domain**: UseCases.
  - **Data**: Repositories, DataSources, DTOs.
  - **Network**: API clients and remote data handling.

### Home
- Feature module for the main home screen.
- Supports infinite scrolling to load more repositories.
- Contains **ViewController**, **ViewModels**, UI components, and models.

### PullRequests
- Feature module for Pull Requests screen.
- Supports infinite scrolling to load more PRs.
- Contains **ViewController**, **ViewModels**, UI components, and models.

### UI
- Shared UI components, extensions, and utilities.

---

## Why this Architecture?

- **Highly decoupled**: Each module is independent, making maintenance and updates easier.
- **Reusability**: Modules can be reused in other apps without modification.
- **Testability**: MVVM + Clean Architecture allows unit tests for all layers.
- **Scalability**: Adding new features or screens is straightforward due to modular design.
- **Maintainability**: Clear separation between layers and reduces dependencies.

---

## Installation

1. Clone the repository:
```bash
git clone https://github.com/williamtdepaula/SwiftHub.git
```
2.	Open the project in Xcode and resolve Swift Packages.
3. Run the app on a simulator or device.