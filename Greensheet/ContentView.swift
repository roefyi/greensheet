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
                // Add safe area handling for initial load
                Color.clear
                    .frame(height: 0)
                    .onAppear {
                        // Force layout update to ensure proper safe area calculation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                            // Trigger layout update
                        }
                    }
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
                    HandicapDashboardView()
                case .roundHistory:
                    RoundHistoryView()
                case .roundDetails:
                    RoundDetailsView()
                case .holeByHole:
                    HoleByHoleView()
                case .courseManagement:
                    CourseManagementView()
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
