# Greensheet Implementation Guide

## Key Implementation Examples

### 1. MVVM Architecture with SwiftUI

**RoundViewModel.swift** demonstrates:
- ✅ `@MainActor` for UI updates
- ✅ `@Published` properties for reactive UI
- ✅ Proper error handling with `Result` types
- ✅ Async/await for asynchronous operations
- ✅ Combine for reactive programming

```swift
@MainActor
final class RoundViewModel: ObservableObject {
    @Published var currentRound: Round?
    @Published var holeScores: [HoleScore] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func startNewRound(for course: Course) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let round = dataController.createRound(course: course)
            currentRound = round
            // ... implementation
        } catch {
            errorMessage = "Failed to start round: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
```

### 2. SwiftUI Extensions for Reusability

**View+Extensions.swift** provides:
- ✅ Consistent styling across the app
- ✅ Golf-specific UI patterns
- ✅ Accessibility support
- ✅ Dark mode compatibility

```swift
extension View {
    func golfCardStyle() -> some View {
        self
            .background(GreensheetTheme.backgroundPrimary)
            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            .padding(.horizontal, GreensheetTheme.spacingMedium)
            .padding(.vertical, GreensheetTheme.spacingSmall)
    }
    
    func tappableWithHaptic() -> some View {
        self.onTapGesture {
            let impactFeedback = UIImpactFeedbackGenerator(style: .light)
            impactFeedback.impactOccurred()
        }
    }
}
```

### 3. Service Layer with Modern Swift

**LocationService.swift** showcases:
- ✅ Async/await for location operations
- ✅ Proper error handling with custom error types
- ✅ Security best practices
- ✅ Combine integration

```swift
@MainActor
final class LocationService: NSObject, ObservableObject {
    func requestLocationPermission() async -> Result<Void, LocationError> {
        guard CLLocationManager.locationServicesEnabled() else {
            return .failure(.locationServicesDisabled)
        }
        
        switch authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return await waitForAuthorization()
        case .denied, .restricted:
            return .failure(.permissionDenied)
        case .authorizedWhenInUse, .authorizedAlways:
            return .success(())
        @unknown default:
            return .failure(.unknownAuthorizationStatus)
        }
    }
}
```

### 4. Reusable UI Components

**CourseCard.swift** demonstrates:
- ✅ Clean, composable SwiftUI views
- ✅ Proper accessibility support
- ✅ Consistent theming
- ✅ Preview support for development

```swift
struct CourseCard: View {
    let course: Course
    let isFavorite: Bool
    let onTap: () -> Void
    let onFavoriteToggle: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                courseHeader
                courseDetails
                courseStatistics
            }
            .golfCardStyle()
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel("Course card for \(course.name ?? "Unknown Course")")
    }
}
```

### 5. Comprehensive Testing

**RoundViewModelTests.swift** shows:
- ✅ Unit tests for ViewModels
- ✅ In-memory Core Data for testing
- ✅ Async/await testing
- ✅ Performance testing

```swift
@MainActor
final class RoundViewModelTests: XCTestCase {
    func testStartNewRound() async throws {
        XCTAssertNil(viewModel.currentRound)
        
        await viewModel.startNewRound(for: testCourse)
        
        XCTAssertNotNil(viewModel.currentRound)
        XCTAssertEqual(viewModel.currentRound?.course, testCourse)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
}
```

## Best Practices Summary

### Performance
- Use lazy loading for large lists
- Efficient state management with `@StateObject` and `@ObservedObject`
- Proper memory management and cleanup

### Security
- Encrypt sensitive data
- Use Keychain for secure storage
- Validate all user inputs
- Implement App Transport Security

### Accessibility
- VoiceOver support with proper labels and hints
- Dynamic Type support
- Semantic colors for color contrast
- Proper accessibility traits

### Testing
- Unit tests for ViewModels and Services
- UI tests for critical user flows
- Performance testing for data operations
- Mock data for testing

Follow these patterns throughout the app to ensure consistency, maintainability, and a high-quality user experience. 