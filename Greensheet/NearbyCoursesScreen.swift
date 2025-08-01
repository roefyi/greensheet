//
//  NearbyCoursesScreen.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

struct NearbyCoursesScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var searchText = ""
    @State private var selectedFilter = "All"
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingLarge) {
            // Header
            NavigationHeader(
                title: "Nearby Courses",
                showBackButton: true,
                backAction: { appState.goBack() }
            )
            
            // Search and Filter
            VStack(spacing: GreensheetTheme.spacingMedium) {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(GreensheetTheme.secondaryLabel)
                    
                    TextField("Search courses...", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(GreensheetTheme.bodyFont)
                }
                .padding()
                .background(GreensheetTheme.backgroundSecondary)
                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                
                // Filter Buttons
                HStack(spacing: GreensheetTheme.spacingSmall) {
                    ForEach(["All", "Public", "Private", "Resort"], id: \.self) { filter in
                        Button(action: {
                            selectedFilter = filter
                        }) {
                            Text(filter)
                                .font(GreensheetTheme.captionFont)
                                .fontWeight(.semibold)
                                .foregroundColor(selectedFilter == filter ? .white : GreensheetTheme.primaryGreen)
                                .padding(.horizontal, GreensheetTheme.spacingMedium)
                                .padding(.vertical, GreensheetTheme.spacingSmall)
                                .background(selectedFilter == filter ? GreensheetTheme.primaryGreen : GreensheetTheme.backgroundSecondary)
                                .cornerRadius(GreensheetTheme.cornerRadiusSmall)
                        }
                    }
                }
            }
            .padding(.horizontal, GreensheetTheme.spacingLarge)
            
            // Location Info
            VStack(spacing: GreensheetTheme.spacingSmall) {
                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(GreensheetTheme.primaryGreen)
                    
                    Text("Monterey, CA")
                        .font(GreensheetTheme.bodyFont)
                        .fontWeight(.semibold)
                        .foregroundColor(GreensheetTheme.label)
                    
                    Spacer()
                    
                    Text("25 courses found")
                        .font(GreensheetTheme.captionFont)
                        .foregroundColor(GreensheetTheme.secondaryLabel)
                }
                
                Text("Showing courses within 50 miles")
                    .font(GreensheetTheme.smallFont)
                    .foregroundColor(GreensheetTheme.secondaryLabel)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, GreensheetTheme.spacingLarge)
            
            // Courses List
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(filteredCourses, id: \.id) { course in
                        NearbyCourseRow(course: course) {
                            appState.navigateTo(.courseDetails)
                        }
                        .padding(.vertical, GreensheetTheme.spacingSmall)
                        
                        if course.id != filteredCourses.last?.id {
                            Divider()
                                .background(GreensheetTheme.separator)
                                .padding(.leading, GreensheetTheme.spacingLarge)
                        }
                    }
                }
                .padding(.horizontal, GreensheetTheme.spacingLarge)
            }
        }
        .background(GreensheetTheme.backgroundPrimary)
    }
    
    private var filteredCourses: [NearbyCourse] {
        var courses = sampleNearbyCourses
        
        if selectedFilter != "All" {
            courses = courses.filter { $0.type == selectedFilter }
        }
        
        if !searchText.isEmpty {
            courses = courses.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        
        return courses
    }
    
    private let sampleNearbyCourses = [
        NearbyCourse(
            name: "Pebble Beach Golf Links",
            type: "Resort",
            distance: 0.5,
            rating: 4.9,
            par: 72,
            yardage: "7075",
            isFavorite: true
        ),
        NearbyCourse(
            name: "Spyglass Hill Golf Course",
            type: "Resort",
            distance: 1.2,
            rating: 4.8,
            par: 72,
            yardage: "6960",
            isFavorite: true
        ),
        NearbyCourse(
            name: "Spanish Bay Golf Links",
            type: "Resort",
            distance: 2.1,
            rating: 4.7,
            par: 72,
            yardage: "6844",
            isFavorite: false
        ),
        NearbyCourse(
            name: "Del Monte Golf Course",
            type: "Public",
            distance: 3.5,
            rating: 4.2,
            par: 72,
            yardage: "6200",
            isFavorite: false
        ),
        NearbyCourse(
            name: "Pacific Grove Golf Links",
            type: "Public",
            distance: 4.8,
            rating: 4.1,
            par: 72,
            yardage: "5800",
            isFavorite: false
        ),
        NearbyCourse(
            name: "Monterey Peninsula Country Club",
            type: "Private",
            distance: 5.2,
            rating: 4.9,
            par: 72,
            yardage: "7100",
            isFavorite: false
        ),
        NearbyCourse(
            name: "Cypress Point Club",
            type: "Private",
            distance: 6.1,
            rating: 5.0,
            par: 72,
            yardage: "6500",
            isFavorite: false
        ),
        NearbyCourse(
            name: "Bayonet and Black Horse Golf Course",
            type: "Public",
            distance: 8.3,
            rating: 4.3,
            par: 72,
            yardage: "7100",
            isFavorite: false
        )
    ]
}

struct NearbyCourse: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let distance: Double
    let rating: Double
    let par: Int
    let yardage: String
    let isFavorite: Bool
}

struct NearbyCourseRow: View {
    let course: NearbyCourse
    let action: () -> Void
    @State private var isPressed = false
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: GreensheetTheme.spacingMedium) {
                // Course Image Placeholder
                VStack(spacing: GreensheetTheme.spacingSmall) {
                    Image(systemName: "photo")
                        .font(.title2)
                        .foregroundColor(GreensheetTheme.primaryGreen)
                    
                    Text("Photo")
                        .font(GreensheetTheme.smallFont)
                        .foregroundColor(GreensheetTheme.secondaryLabel)
                }
                .frame(width: 60, height: 60)
                .background(GreensheetTheme.backgroundSecondary)
                .cornerRadius(GreensheetTheme.cornerRadiusSmall)
                
                // Course Info
                VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                    HStack {
                        Text(course.name)
                            .font(GreensheetTheme.bodyFont)
                            .fontWeight(.semibold)
                            .foregroundColor(GreensheetTheme.label)
                        
                        if course.isFavorite {
                            Image(systemName: "heart.fill")
                                .font(.caption)
                                .foregroundColor(GreensheetTheme.bogey)
                        }
                    }
                    
                    HStack(spacing: GreensheetTheme.spacingMedium) {
                        Text(course.type)
                            .font(GreensheetTheme.smallFont)
                            .foregroundColor(GreensheetTheme.primaryGreen)
                            .padding(.horizontal, GreensheetTheme.spacingSmall)
                            .padding(.vertical, 2)
                            .background(GreensheetTheme.primaryGreen.opacity(0.1))
                            .cornerRadius(GreensheetTheme.cornerRadiusSmall)
                        
                        Text("\(course.distance, specifier: "%.1f") mi")
                            .font(GreensheetTheme.smallFont)
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                    }
                    
                    HStack(spacing: GreensheetTheme.spacingMedium) {
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.caption)
                                .foregroundColor(GreensheetTheme.eagle)
                            
                            Text("\(course.rating, specifier: "%.1f")")
                                .font(GreensheetTheme.smallFont)
                                .foregroundColor(GreensheetTheme.label)
                        }
                        
                        Text("Par \(course.par)")
                            .font(GreensheetTheme.smallFont)
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                        
                        Text("\(course.yardage)y")
                            .font(GreensheetTheme.smallFont)
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                    }
                }
                
                Spacer()
            }
            .padding()
            .background(isPressed ? GreensheetTheme.backgroundSecondary : Color.clear)
            .cornerRadius(GreensheetTheme.cornerRadiusSmall)
        }
        .buttonStyle(PlainButtonStyle())
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = pressing
            }
        }, perform: {})
    }
}

#Preview {
    NearbyCoursesScreen()
        .environmentObject(AppState())
} 