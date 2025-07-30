//
//  ContentView.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

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
                case .locationPermission:
                    LocationPermissionScreen()
                case .firstCourseSetup:
                    FirstCourseSetupScreen()
                case .nearbyCourses:
                    NearbyCoursesScreen()
                case .courseDetails:
                    CourseDetailsScreen()
                case .holeDetails:
                    HoleDetailsScreen()
                case .teeSetup:
                    TeeSetupScreen()
                case .homeDashboard:
                    HomeDashboardScreen()
                case .courseSelection:
                    CourseSelectionScreen()
                case .preRoundSetup:
                    PreRoundSetupScreen()
                case .scorecard:
                    ScorecardScreen()
                case .roundSummary:
                    RoundSummaryScreen()
                case .handicapDashboard:
                    HandicapDashboardScreen()
                case .roundHistory:
                    RoundHistoryScreen()
                case .roundDetails:
                    RoundDetailsScreen()
                case .holeByHole:
                    HoleByHoleScreen()
                case .courseManagement:
                    CourseManagementScreen()
                }
            }
        }
        .environmentObject(appState)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
