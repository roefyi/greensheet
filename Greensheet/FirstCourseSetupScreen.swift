//
//  FirstCourseSetupScreen.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

struct FirstCourseSetupScreen: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingXLarge) {
            // Header
            NavigationHeader(
                title: "Add Your First Course",
                showBackButton: true,
                backAction: { appState.goBack() }
            )
            
            Spacer()
            
            // Setup Content
            VStack(spacing: GreensheetTheme.spacingLarge) {
                Text("Let's add your home course to get started")
                    .font(GreensheetTheme.bodyFont)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, GreensheetTheme.spacingLarge)
                
                // Course Options
                VStack(spacing: GreensheetTheme.spacingMedium) {
                    CourseOptionButton(
                        icon: "📍",
                        title: "Find nearby courses",
                        action: { appState.navigateTo(.nearbyCourses) }
                    )
                    
                    CourseOptionButton(
                        icon: "✏️",
                        title: "Add course manually",
                        action: { appState.navigateTo(.courseDetails) }
                    )
                }
            }
            
            Spacer()
        }
        .background(GreensheetTheme.backgroundPrimary)
    }
}

struct CourseOptionButton: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: GreensheetTheme.spacingMedium) {
                Text(icon)
                    .font(.title2)
                
                Text(title)
                    .font(GreensheetTheme.bodyFont)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .padding()
            .background(GreensheetTheme.backgroundSecondary)
            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    FirstCourseSetupScreen()
        .environmentObject(AppState())
} 