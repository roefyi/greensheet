//
//  CourseSelectionScreen.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

struct CourseSelectionScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var searchText = ""
    
    private let courses = CourseModel.sampleCourses + [
        CourseModel(
            name: "The Links at Spanish Bay",
            location: "Pebble Beach, CA",
            par: 72,
            totalYardage: 7050,
            holes: Array(1...18).map { CourseModel.HoleModel(number: $0, par: 4, yardage: 392, handicapRanking: $0) },
            teeOptions: [
                CourseModel.TeeOptionModel(name: "White Tees", color: .white, yardages: Array(repeating: 392, count: 18))
            ],
            lastPlayed: Date().addingTimeInterval(-1209600), // 2 weeks ago
            lastScore: 79,
            timesPlayed: 2
        )
    ]
    
    var filteredCourses: [CourseModel] {
        if searchText.isEmpty {
            return courses
        } else {
            return courses.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            NavigationHeader(
                title: "Select Course",
                showBackButton: true,
                backAction: { appState.goBack() }
            )
            
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                
                TextField("Search your courses...", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(GreensheetTheme.bodyFont)
            }
            .padding()
            .background(GreensheetTheme.backgroundSecondary)
            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
            .padding(.horizontal, GreensheetTheme.spacingLarge)
            .padding(.bottom, GreensheetTheme.spacingMedium)
            
            // Courses List
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(filteredCourses, id: \.id) { course in
                        CourseSelectionRow(course: course) {
                            appState.navigateTo(.preRoundSetup)
                        }
                        
                        if course.id != filteredCourses.last?.id {
                            Divider()
                                .padding(.leading, GreensheetTheme.spacingLarge)
                        }
                    }
                }
                .background(GreensheetTheme.backgroundSecondary)
                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                .padding(.horizontal, GreensheetTheme.spacingLarge)
            }
            
            // Add New Course Button
            Button(action: {
                appState.navigateTo(.firstCourseSetup)
            }) {
                HStack(spacing: GreensheetTheme.spacingMedium) {
                    Text("+")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Add New Course")
                        .font(GreensheetTheme.bodyFont)
                }
                .foregroundColor(GreensheetTheme.primaryGreen)
                .frame(maxWidth: .infinity)
                .padding()
                .background(GreensheetTheme.primaryGreen.opacity(0.1))
                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
            }
            .padding(.horizontal, GreensheetTheme.spacingLarge)
            .padding(.vertical, GreensheetTheme.spacingMedium)
        }
        .background(GreensheetTheme.backgroundPrimary)
    }
}

struct CourseSelectionRow: View {
    let course: CourseModel
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: GreensheetTheme.spacingMedium) {
                VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                    Text(course.name)
                        .font(GreensheetTheme.bodyFont)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text("Par \(course.par) • \(formatLastPlayed(course.lastPlayed))")
                        .font(GreensheetTheme.captionFont)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func formatLastPlayed(_ date: Date?) -> String {
        guard let date = date else { return "Never played" }
        
        let days = Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0
        
        if days == 0 {
            return "Last played: Today"
        } else if days == 1 {
            return "Last played: Yesterday"
        } else if days < 7 {
            return "Last played: \(days) days ago"
        } else {
            return "Last played: \(days / 7) week\(days / 7 == 1 ? "" : "s") ago"
        }
    }
}

#Preview {
    CourseSelectionScreen()
        .environmentObject(AppState())
} 