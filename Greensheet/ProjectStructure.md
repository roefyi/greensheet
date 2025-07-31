# Greensheet Project Structure

## Recommended Folder Organization

```
Greensheet/
├── App/
│   ├── GreensheetApp.swift
│   └── ContentView.swift
├── Features/
│   ├── Welcome/
│   ├── Onboarding/
│   ├── Course/
│   ├── Round/
│   ├── Dashboard/
│   └── Hole/
├── Core/
│   ├── Data/
│   ├── Services/
│   ├── Networking/
│   └── Utils/
├── UI/
│   ├── Components/
│   ├── Theme/
│   └── Modifiers/
├── Resources/
└── Tests/
```

## Architecture Principles

### MVVM Implementation
- **Models**: Core Data entities and business logic models
- **Views**: SwiftUI views with minimal logic
- **ViewModels**: Handle business logic, data transformation, and state management

### Dependency Injection
- Use `@EnvironmentObject` for app-wide dependencies
- Use `@StateObject` for view-specific state
- Use `@ObservedObject` for injected dependencies

### Data Flow
- Single source of truth for app state
- Unidirectional data flow
- Proper error handling with Result types

### Testing Strategy
- Unit tests for ViewModels and Services
- UI tests for critical user flows
- Mock data for testing
- Performance testing for data operations 