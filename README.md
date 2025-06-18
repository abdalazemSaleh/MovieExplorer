# Mini Movie Explorer

A simple iOS app to browse and favorite movies, built with UIKit, Clean Architecture, and MVVM.

## Features

- Browse popular movies in a grid layout.
- Mark movies as favorites (persisted locally).
- View detailed information for each movie.
- Robust error, loading, and empty state handling.
- Modern UIKit layout and navigation.
- Clean, scalable architecture.

## Architecture

- **UIKit**: All UI is built with UIKit.
- **MVVM + Clean Architecture**: 
  - **Presentation Layer**: ViewControllers, Views, and ViewModels.
  - **Domain Layer**: UseCases, Entities, and Repositories.
  - **Data Layer**: Remote and Local DataSources, API integration.
- **Dependency Injection**: All dependencies are injected via a Dependency Container, making the app modular and testable.
- **Networking**: Uses URLSession, self created SPM for API calls.
- **Image Loading**: Uses UIImageView extension for async image loading, and caching.
- **State Management**: Custom reusable StateView and Snackbar for loading, error, and empty states.
- **SPM**: All third-party dependencies are managed via Swift Package Manager.

## Trade-offs & Decisions

- **Networking Technology**: The app is designed so that the underlying networking technology (URLSession, Alamofire, or anything else) can be swapped out with minimal effort. The architecture is agnostic to the specific implementation.
- **Persistence**: Favorites are stored using UserDefaults for simplicity, but the architecture allows swapping to CoreData or another solution if needed.
- **Error Handling**: Centralized via a general `ScreenState` and reusable UI components for consistency and maintainability.

- **Demo Scope & Overengineering**: This app is a demo and intentionally overengineered in some areas to showcase scalable architecture. In a production app, some patterns might be simplified or further optimized. There is a lot more that could be added or handled in a more robust way for a real-world product.
