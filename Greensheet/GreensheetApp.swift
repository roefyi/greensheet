//
//  GreensheetApp.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI
import CoreText

@main
struct GreensheetApp: App {
    @StateObject private var appState = AppState()
    // @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                // .environment(\.managedObjectContext, dataController.container.viewContext)
                .onAppear {
                    // Register fonts programmatically
                    if let fontURLs = Bundle.main.urls(forResourcesWithExtension: "ttf", subdirectory: nil) {
                        for fontURL in fontURLs {
                            let error = UnsafeMutablePointer<Unmanaged<CFError>?>.allocate(capacity: 1)
                            defer { error.deallocate() }
                            CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, error)
                        }
                    }
                }
        }
    }
}

class AppState: ObservableObject {
    @Published var currentScreen: AppScreen = .welcome
    @Published var isFirstTimeUser: Bool = true
    @Published var navigationHistory: [AppScreen] = [.welcome]
    
    func navigateTo(_ screen: AppScreen) {
        if screen != currentScreen {
            navigationHistory.append(screen)
            currentScreen = screen
        }
    }
    
    func goBack() {
        if navigationHistory.count > 1 {
            navigationHistory.removeLast()
            currentScreen = navigationHistory.last ?? .welcome
        } else {
            currentScreen = .homeDashboard
        }
    }
}

enum AppScreen: String, CaseIterable {
    case welcome = "welcome"
    case featureOverview = "featureOverview"
    case accountSetup = "accountSetup"
    case locationPermission = "locationPermission"
    case firstCourseSetup = "firstCourseSetup"
    case nearbyCourses = "nearbyCourses"
    case courseDetails = "courseDetails"
    case holeDetails = "holeDetails"
    case teeSetup = "teeSetup"
    case homeDashboard = "homeDashboard"
    case courseSelection = "courseSelection"
    case preRoundSetup = "preRoundSetup"
    case scorecard = "scorecard"
    case roundSummary = "roundSummary"
    case handicapDashboard = "handicapDashboard"
    case roundHistory = "roundHistory"
    case roundDetails = "roundDetails"
    case holeByHole = "holeByHole"
    case courseManagement = "courseManagement"
}
