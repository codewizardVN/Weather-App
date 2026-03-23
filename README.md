# Weather-App

Accurate weather information for any location in the world in lightweight

Skeleton project for practicing Clean Architecture with SwiftUI.

## Target structure

```text
Weather-App/
├── Domain/
│   ├── Entities/
│   ├── RepositoryInterfaces/
│   └── UseCases/
├── Data/
│   ├── Repositories/
│   ├── DataSources/
│   │   ├── Remote/
│   │   └── Local/
│   └── Models/
├── Presentation/
│   ├── ViewModels/
│   └── Views/
│       └── Components/
└── Core/
    ├── Network/
    └── Utils/
```

## Layer notes

- `Domain`: business rules, pure models, repository protocols, and use cases.
- `Data`: DTOs, remote/local data sources, and repository implementations.
- `Presentation`: SwiftUI views and view models.
- `Core`: shared infrastructure such as networking and utilities.

## Suggested build order

1. Domain: `Entities -> RepositoryInterfaces -> UseCases`
2. Data: `Models -> DataSources -> Repositories`
3. Core: `Network -> Utils`
4. Presentation: `ViewModels -> Views`

## Current status

- Default Xcode template files were removed.
- The app still builds with a small placeholder flow so you can replace each layer step by step.
- Empty folders keep a small placeholder file so the structure stays visible in Git.
- In this Xcode setup, identical `.gitkeep` filenames can cause duplicate bundle resource outputs, so the placeholder filenames are unique per folder.

## Secrets setup

1. Copy `Configurations/Secrets.xcconfig.example` to `Configurations/Secrets.xcconfig`.
2. Fill in `WEATHERSTACK_API_KEY`.
3. The generated app `Info.plist` will expose `WEATHERSTACK_API_KEY` to the app at runtime.
4. Read it from [`AppConfig.swift`](/Users/kobe/Projects/Weather-App/Weather-App/Core/Utils/AppConfig.swift).
