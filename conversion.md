# HTML to SwiftUI Conversion Rules for Greensheet Golf App

## Overview
This document provides comprehensive conversion rules for transforming the HTML-based Greensheet golf score tracking app into a native SwiftUI iOS application. The conversion maintains the same functionality, user experience, and design patterns while leveraging iOS native capabilities.

## 1. App Structure & Navigation

### 1.1 Main App Entry Point
**HTML Pattern:**
```html
<div id="app">
    <div id="welcome-screen" class="screen active">
```

**SwiftUI Conversion:**
```swift
@main
struct GreensheetApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}

class AppState: ObservableObject {
    @Published var currentScreen: AppScreen = .welcome
    @Published var isFirstTimeUser: Bool = true
}

enum AppScreen {
    case welcome, featureOverview, accountSetup, locationPermission
    case homeDashboard, courseSelection, preRoundSetup, scorecard
    case roundHistory, handicapDashboard, courseManagement
}
```

### 1.2 Screen Navigation System
**HTML Pattern:**
```html
<div id="welcome-screen" class="screen active">
<div id="feature-overview" class="screen">
```

**SwiftUI Conversion:**
```swift
struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationStack {
            Group {
                switch appState.currentScreen {
                case .welcome:
                    WelcomeScreen()
                case .featureOverview:
                    FeatureOverviewScreen()
                case .accountSetup:
                    AccountSetupScreen()
                case .homeDashboard:
                    HomeDashboardScreen()
                case .courseSelection:
                    CourseSelectionScreen()
                case .preRoundSetup:
                    PreRoundSetupScreen()
                case .scorecard:
                    ScorecardScreen()
                default:
                    EmptyView()
                }
            }
        }
    }
}
```

## 2. UI Components Conversion

### 2.1 Buttons
**HTML Pattern:**
```html
<button class="btn-primary" onclick="showFeatureOverview()">Get Started</button>
<button class="btn-secondary" onclick="showReturningUser()">I'm returning</button>
```

**SwiftUI Conversion:**
```swift
struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(12)
        }
    }
}

struct SecondaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
        }
    }
}
```

### 2.2 Form Inputs
**HTML Pattern:**
```html
<div class="form-group">
    <label for="player-name">Name</label>
    <input type="text" id="player-name" placeholder="Enter your name">
</div>
```

**SwiftUI Conversion:**
```swift
struct FormTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            TextField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
        }
    }
}
```

### 2.3 Headers with Back Buttons
**HTML Pattern:**
```html
<div class="header">
    <button class="back-btn" onclick="goBack()">←</button>
    <h2>Create Your Profile</h2>
</div>
```

**SwiftUI Conversion:**
```swift
struct NavigationHeader: View {
    let title: String
    let showBackButton: Bool
    let backAction: (() -> Void)?
    
    var body: some View {
        HStack {
            if showBackButton {
                Button(action: { backAction?() }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
            }
            
            Spacer()
            
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
            
            Spacer()
            
            if showBackButton {
                Color.clear
                    .frame(width: 24, height: 24)
            }
        }
        .padding()
    }
}
```

## 3. Data Models

### 3.1 Player Model
**HTML Pattern:**
```html
<input type="text" id="player-name" placeholder="Enter your name">
<select id="handicap">
    <option value="0-5">0-5</option>
    <option value="6-10">6-10</option>
</select>
```

**SwiftUI Conversion:**
```swift
struct Player: Identifiable, Codable {
    let id = UUID()
    var name: String
    var handicap: Double?
    var handicapRange: HandicapRange?
    
    enum HandicapRange: String, CaseIterable, Codable {
        case unknown = "I don't know"
        case zeroToFive = "0-5"
        case sixToTen = "6-10"
        case elevenToFifteen = "11-15"
        case sixteenToTwenty = "16-20"
        case twentyOnePlus = "21+"
    }
}
```

### 3.2 Course Model
**HTML Pattern:**
```html
<div class="course-item" onclick="selectCourseForRound('Pebble Beach Golf Links')">
    <div class="course-info">
        <h3>Pebble Beach Golf Links</h3>
        <p>Par 72 • Last played: 2 days ago</p>
    </div>
</div>
```

**SwiftUI Conversion:**
```swift
struct Course: Identifiable, Codable {
    let id = UUID()
    var name: String
    var par: Int
    var holes: [Hole]
    var teeOptions: [TeeOption]
    var lastPlayed: Date?
    var lastScore: Int?
    
    struct Hole: Identifiable, Codable {
        let id = UUID()
        var number: Int
        var par: Int
        var yardage: Int
        var handicapRanking: Int?
    }
    
    struct TeeOption: Identifiable, Codable {
        let id = UUID()
        var name: String
        var color: TeeColor
        var yardages: [Int] // 18 holes
        
        enum TeeColor: String, Codable, CaseIterable {
            case white, blue, red, gold, black
        }
    }
}
```

### 3.3 Round Model
**HTML Pattern:**
```html
<div class="scorecard-content">
    <div class="hole-info-compact">
        <div class="hole-number-compact">1</div>
        <div class="hole-par-compact">PAR 4</div>
    </div>
</div>
```

**SwiftUI Conversion:**
```swift
struct Round: Identifiable, Codable {
    let id = UUID()
    var course: Course
    var date: Date
    var players: [Player]
    var holes: [HoleScore]
    var selectedTee: Course.TeeOption
    var startingHole: Int
    var totalHoles: Int // 9 or 18
    
    struct HoleScore: Identifiable, Codable {
        let id = UUID()
        var holeNumber: Int
        var strokes: Int
        var putts: Int
        var fairwayHit: FairwayResult
        var greenInRegulation: Bool
        var hazards: [Hazard]
        
        enum FairwayResult: String, Codable {
            case hit, left, right
        }
        
        enum Hazard: String, Codable, CaseIterable {
            case penalty, sand, water
        }
    }
}
```

## 4. Screen-Specific Conversions

### 4.1 Welcome Screen
**HTML Pattern:**
```html
<div id="welcome-screen" class="screen active">
    <div class="welcome-content">
        <div class="logo">
            <img src="Assets.xcassets/Frame 5.imageset/Frame 5.png" alt="Greensheet App Icon">
            <h1>Greensheet</h1>
            <p>Track your golf journey</p>
        </div>
        <div class="welcome-buttons">
            <button class="btn-primary" onclick="showFeatureOverview()">Get Started</button>
            <button class="btn-secondary" onclick="showReturningUser()">I'm returning</button>
        </div>
    </div>
</div>
```

**SwiftUI Conversion:**
```swift
struct WelcomeScreen: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            VStack(spacing: 20) {
                Image("AppIcon") // Use Asset Catalog
                    .resizable()
                    .frame(width: 80, height: 80)
                    .cornerRadius(16)
                
                Text("Greensheet")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Track your golf journey")
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                PrimaryButton(title: "Get Started") {
                    appState.currentScreen = .featureOverview
                }
                
                SecondaryButton(title: "I'm returning") {
                    appState.currentScreen = .homeDashboard
                }
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
```

### 4.2 Home Dashboard
**HTML Pattern:**
```html
<div id="home-dashboard" class="screen">
    <div class="header">
        <h2>Greensheet</h2>
        <button class="settings-btn" onclick="showSettings()">SETTINGS</button>
    </div>
    <div class="dashboard-content">
        <div class="handicap-display">
            <span class="handicap-label">Current Handicap</span>
            <span class="handicap-value">12.4</span>
        </div>
        <button class="start-round-btn" onclick="showCourseSelection()">
            <span class="btn-icon">START</span>
            <span>Play a Round</span>
        </button>
    </div>
    <div class="tab-bar">
        <button class="tab-item active" onclick="showHomeDashboard()">
            <span class="tab-icon">HOME</span>
            <span class="tab-label">Home</span>
        </button>
    </div>
</div>
```

**SwiftUI Conversion:**
```swift
struct HomeDashboardScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeTabView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            RoundHistoryView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Rounds")
                }
                .tag(1)
            
            HandicapDashboardView()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Handicap")
                }
                .tag(2)
            
            CourseManagementView()
                .tabItem {
                    Image(systemName: "flag.fill")
                    Text("Courses")
                }
                .tag(3)
        }
    }
}

struct HomeTabView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Header
                HStack {
                    Text("Greensheet")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button("SETTINGS") {
                        // Show settings
                    }
                    .font(.caption)
                    .foregroundColor(.blue)
                }
                .padding()
                
                // Handicap Display
                VStack(spacing: 8) {
                    Text("Current Handicap")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("12.4")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
                
                // Play Round Button
                Button(action: {
                    appState.currentScreen = .courseSelection
                }) {
                    VStack(spacing: 8) {
                        Text("START")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("Play a Round")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                }
                
                // Recent Courses
                RecentCoursesView()
                
                // Quick Stats
                QuickStatsView()
                
                Spacer()
            }
            .padding()
        }
    }
}
```

### 4.3 Scorecard Interface
**HTML Pattern:**
```html
<div id="scorecard" class="screen">
    <div class="header">
        <button class="back-btn" onclick="goBack()">←</button>
        <h2>Score</h2>
        <button class="menu-btn" onclick="showScorecardMenu()">MENU</button>
    </div>
    <div class="scorecard-content">
        <div class="hole-input-card">
            <div class="input-section">
                <div class="input-label">Strokes</div>
                <div class="input-controls">
                    <button class="control-btn" onclick="decreaseStrokes()">-</button>
                    <span class="input-value">4</span>
                    <button class="control-btn" onclick="increaseStrokes()">+</button>
                </div>
            </div>
        </div>
    </div>
</div>
```

**SwiftUI Conversion:**
```swift
struct ScorecardScreen: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = ScorecardViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Hole Info
                HoleInfoView(currentHole: viewModel.currentHole)
                
                // Score Input Card
                ScoreInputCard(
                    strokes: $viewModel.currentStrokes,
                    putts: $viewModel.currentPutts,
                    fairwayHit: $viewModel.currentFairwayHit,
                    greenInRegulation: $viewModel.currentGreenInRegulation,
                    hazards: $viewModel.currentHazards
                )
                
                // Running Totals
                RunningTotalsView(totals: viewModel.runningTotals)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Score")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("←") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("MENU") {
                        viewModel.showMenu()
                    }
                }
            }
        }
    }
}

struct ScoreInputCard: View {
    @Binding var strokes: Int
    @Binding var putts: Int
    @Binding var fairwayHit: Round.HoleScore.FairwayResult
    @Binding var greenInRegulation: Bool
    @Binding var hazards: [Round.HoleScore.Hazard]
    
    var body: some View {
        VStack(spacing: 16) {
            // Strokes
            ScoreInputSection(
                label: "Strokes",
                value: $strokes,
                range: 1...10
            )
            
            Divider()
            
            // Putts
            ScoreInputSection(
                label: "Putts",
                value: $putts,
                range: 0...10
            )
            
            Divider()
            
            // Fairways
            FairwayInputSection(fairwayHit: $fairwayHit)
            
            Divider()
            
            // GIR
            GIRInputSection(greenInRegulation: $greenInRegulation)
            
            Divider()
            
            // Hazards
            HazardsInputSection(hazards: $hazards)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 2)
    }
}

struct ScoreInputSection: View {
    let label: String
    @Binding var value: Int
    let range: ClosedRange<Int>
    
    var body: some View {
        HStack {
            Text(label)
                .font(.headline)
            
            Spacer()
            
            HStack(spacing: 20) {
                Button("-") {
                    if value > range.lowerBound {
                        value -= 1
                    }
                }
                .font(.title2)
                .foregroundColor(.blue)
                
                Text("\(value)")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(minWidth: 40)
                
                Button("+") {
                    if value < range.upperBound {
                        value += 1
                    }
                }
                .font(.title2)
                .foregroundColor(.blue)
            }
        }
    }
}
```

## 5. Data Persistence

### 5.1 UserDefaults for Simple Data
```swift
class UserPreferences: ObservableObject {
    @Published var playerName: String {
        didSet {
            UserDefaults.standard.set(playerName, forKey: "playerName")
        }
    }
    
    @Published var handicap: Double? {
        didSet {
            UserDefaults.standard.set(handicap, forKey: "handicap")
        }
    }
    
    init() {
        self.playerName = UserDefaults.standard.string(forKey: "playerName") ?? ""
        self.handicap = UserDefaults.standard.double(forKey: "handicap")
    }
}
```

### 5.2 Core Data for Complex Data
```swift
// Core Data Model
extension Course {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var par: Int16
    @NSManaged public var holes: Set<Hole>
    @NSManaged public var rounds: Set<Round>
}

class DataController: ObservableObject {
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Greensheet")
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
```

## 6. Location Services

### 6.1 Location Permission
**HTML Pattern:**
```html
<div id="location-permission" class="screen">
    <div class="permission-content">
        <div class="permission-icon">LOCATION</div>
        <p>Allow Greensheet to access your location to find golf courses in your area</p>
    </div>
</div>
```

**SwiftUI Conversion:**
```swift
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
    }
}

struct LocationPermissionScreen: View {
    @StateObject private var locationManager = LocationManager()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            VStack(spacing: 20) {
                Image(systemName: "location.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                Text("Find Courses Near You")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Allow Greensheet to access your location to find golf courses in your area")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            PrimaryButton(title: "Allow Location Access") {
                locationManager.requestLocationPermission()
            }
        }
        .padding()
    }
}
```

## 7. State Management

### 7.1 ViewModels
```swift
class HomeViewModel: ObservableObject {
    @Published var currentHandicap: Double = 12.4
    @Published var recentCourses: [Course] = []
    @Published var quickStats: QuickStats = QuickStats()
    
    struct QuickStats {
        var lastRoundScore: Int = 78
        var roundsThisMonth: Int = 8
    }
    
    func loadData() {
        // Load from Core Data or API
    }
}

class ScorecardViewModel: ObservableObject {
    @Published var currentHole: Int = 1
    @Published var currentStrokes: Int = 4
    @Published var currentPutts: Int = 2
    @Published var currentFairwayHit: Round.HoleScore.FairwayResult = .hit
    @Published var currentGreenInRegulation: Bool = true
    @Published var currentHazards: [Round.HoleScore.Hazard] = []
    @Published var runningTotals: RunningTotals = RunningTotals()
    
    struct RunningTotals {
        var frontNine: Int = 36
        var backNine: Int = 42
        var total: Int = 78
    }
    
    func nextHole() {
        if currentHole < 18 {
            currentHole += 1
            resetCurrentHole()
        }
    }
    
    func previousHole() {
        if currentHole > 1 {
            currentHole -= 1
            loadCurrentHole()
        }
    }
    
    private func resetCurrentHole() {
        currentStrokes = 4
        currentPutts = 2
        currentFairwayHit = .hit
        currentGreenInRegulation = true
        currentHazards = []
    }
    
    private func loadCurrentHole() {
        // Load saved data for current hole
    }
}
```

## 8. Styling & Theming

### 8.1 Color Scheme
```swift
extension Color {
    static let golfGreen = Color(red: 0.2, green: 0.6, blue: 0.3)
    static let golfBlue = Color(red: 0.1, green: 0.4, blue: 0.8)
    static let golfSand = Color(red: 0.9, green: 0.8, blue: 0.6)
}

struct GreensheetTheme {
    static let primaryColor = Color.golfGreen
    static let secondaryColor = Color.golfBlue
    static let accentColor = Color.golfSand
    static let backgroundColor = Color(.systemBackground)
    static let cardBackground = Color(.secondarySystemBackground)
}
```

### 8.2 Custom Button Styles
```swift
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(GreensheetTheme.primaryColor)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(GreensheetTheme.primaryColor)
            .frame(maxWidth: .infinity)
            .padding()
            .background(GreensheetTheme.primaryColor.opacity(0.1))
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
```

## 9. Accessibility

### 9.1 Accessibility Labels
```swift
struct AccessibleScoreInput: View {
    @Binding var strokes: Int
    
    var body: some View {
        HStack {
            Button("-") {
                if strokes > 1 { strokes -= 1 }
            }
            .accessibilityLabel("Decrease strokes")
            
            Text("\(strokes)")
                .accessibilityLabel("Current strokes: \(strokes)")
            
            Button("+") {
                if strokes < 10 { strokes += 1 }
            }
            .accessibilityLabel("Increase strokes")
        }
    }
}
```

## 10. Testing

### 10.1 Unit Tests
```swift
import XCTest
@testable import Greensheet

class ScorecardViewModelTests: XCTestCase {
    var viewModel: ScorecardViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ScorecardViewModel()
    }
    
    func testNextHole() {
        let initialHole = viewModel.currentHole
        viewModel.nextHole()
        XCTAssertEqual(viewModel.currentHole, initialHole + 1)
    }
    
    func testPreviousHole() {
        viewModel.currentHole = 5
        viewModel.previousHole()
        XCTAssertEqual(viewModel.currentHole, 4)
    }
}
```

### 10.2 UI Tests
```swift
import XCTest

class GreensheetUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }
    
    func testWelcomeFlow() {
        app.buttons["Get Started"].tap()
        XCTAssertTrue(app.staticTexts["Track Every Round"].exists)
    }
    
    func testScoreInput() {
        // Navigate to scorecard
        app.buttons["Play a Round"].tap()
        // ... navigate through course selection
        
        // Test score input
        app.buttons["Increase strokes"].tap()
        XCTAssertEqual(app.staticTexts["5"].exists, true)
    }
}
```

## 11. Performance Considerations

### 11.1 Lazy Loading
```swift
struct CourseListView: View {
    @StateObject private var viewModel = CourseListViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.courses) { course in
                LazyVStack {
                    CourseRowView(course: course)
                }
            }
        }
        .onAppear {
            viewModel.loadCourses()
        }
    }
}
```

### 11.2 Image Caching
```swift
class ImageCache: ObservableObject {
    private var cache = NSCache<NSString, UIImage>()
    
    func getImage(for url: URL) -> UIImage? {
        return cache.object(forKey: url.absoluteString as NSString)
    }
    
    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url.absoluteString as NSString)
    }
}
```

## 12. Deployment Considerations

### 12.1 App Store Assets
- Create App Icon in various sizes (1024x1024, 180x180, etc.)
- Screenshots for different device sizes
- App Store description and keywords
- Privacy policy for location services

### 12.2 Configuration
```swift
struct AppConfig {
    static let appName = "Greensheet"
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    static let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    
    // API endpoints
    static let baseURL = "https://api.greensheet.com"
    
    // Feature flags
    static let enableLocationServices = true
    static let enableCloudSync = true
}
```

This conversion guide provides a comprehensive framework for transforming the HTML golf app into a native SwiftUI iOS application while maintaining all functionality and improving the user experience with native iOS capabilities.
