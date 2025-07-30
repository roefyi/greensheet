//
//  NearbyCoursesScreen.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

struct NearbyCoursesScreen: View {
    @EnvironmentObject var appState: AppState
    
    private let nearbyCourses = [
        NearbyCourse(name: "Pebble Beach Golf Links", location: "Pebble Beach, CA", distance: "2.3 mi"),
        NearbyCourse(name: "Spyglass Hill Golf Course", location: "Pebble Beach, CA", distance: "3.1 mi"),
        NearbyCourse(name: "The Links at Spanish Bay", location: "Pebble Beach, CA", distance: "4.2 mi")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            NavigationHeader(
                title: "Nearby Courses",
                showBackButton: true,
                backAction: { appState.goBack() }
            )
            
            // Courses List
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(nearbyCourses, id: \.name) { course in
                        CourseRow(course: course) {
                            // Handle course selection
                            appState.navigateTo(.courseDetails)
                        }
                        
                        Divider()
                            .padding(.leading, GreensheetTheme.spacingLarge)
                    }
                }
            }
        }
        .background(GreensheetTheme.backgroundPrimary)
    }
}

struct CourseRow: View {
    let course: NearbyCourse
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: GreensheetTheme.spacingMedium) {
                VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                    Text(course.name)
                        .font(GreensheetTheme.bodyFont)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text(course.location)
                        .font(GreensheetTheme.captionFont)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(course.distance)
                    .font(GreensheetTheme.captionFont)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct NearbyCourse {
    let name: String
    let location: String
    let distance: String
}

#Preview {
    NearbyCoursesScreen()
        .environmentObject(AppState())
} 