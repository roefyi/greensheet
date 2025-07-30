//
//  HomeDashboardScreen.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

// Import dependencies for CourseModel and AppState

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
        .accentColor(GreensheetTheme.primaryGreen)
        .onAppear {
            // Set tab bar background color to match main view
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(GreensheetTheme.backgroundPrimary)
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

struct HomeTabView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: GreensheetTheme.spacingLarge) {
                    // Header
                    HStack {
                        Text("Greensheet")
                            .font(GreensheetTheme.titleFont)
                            .fontWeight(.bold)
                            .foregroundColor(GreensheetTheme.label)
                        
                        Spacer()
                        
                        Button(action: {
                            // Show settings
                        }) {
                            Image(systemName: "gearshape.fill")
                                .font(.title2)
                                .foregroundColor(GreensheetTheme.primaryGreen)
                        }
                    }
                    .padding(.horizontal, GreensheetTheme.spacingLarge)
                    
                    // Handicap Display
                    VStack(spacing: GreensheetTheme.spacingSmall) {
                        Text("Current Handicap")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                        Text("12.4")
                            .font(.custom("HostGrotesk-Regular", size: 48))
                            .fontWeight(.bold)
                            .foregroundColor(GreensheetTheme.primaryGreen)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, GreensheetTheme.spacingLarge)
                    
                    // Play Round Button
                    Button(action: {
                        appState.navigateTo(.courseSelection)
                    }) {
                        Text("Play a Round")
                            .font(GreensheetTheme.headlineFont)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(GreensheetTheme.primaryGreen)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                    }
                    .padding(.horizontal, GreensheetTheme.spacingLarge)
                    
                    // Recent Courses
                    RecentCoursesView()
                    
                    // Quick Stats
                    QuickStatsView()
                }
                .padding(.vertical, GreensheetTheme.spacingLarge)
            }
            .background(GreensheetTheme.backgroundPrimary)
        }
    }
}

struct RecentCoursesView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
            Text("Recent Courses")
                .font(GreensheetTheme.headlineFont)
                .fontWeight(.semibold)
                .foregroundColor(GreensheetTheme.label)
                .padding(.horizontal, GreensheetTheme.spacingLarge)
            
            VStack(spacing: 0) {
                ForEach(CourseModel.sampleCourses, id: \.id) { course in
                    RecentCourseRow(course: course) {
                        appState.navigateTo(.courseSelection)
                    }
                    .padding(.vertical, GreensheetTheme.spacingSmall)
                    
                    if course.id != CourseModel.sampleCourses.last?.id {
                        Divider()
                            .background(GreensheetTheme.separator)
                            .padding(.leading, GreensheetTheme.spacingLarge)
                    }
                }
            }
            .padding(.horizontal, GreensheetTheme.spacingLarge)
        }
    }
}

struct RecentCourseRow: View {
    let course: CourseModel
    let action: () -> Void
    @State private var isPressed = false
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: GreensheetTheme.spacingMedium) {
                VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                    Text(course.name)
                        .font(GreensheetTheme.bodyFont)
                        .fontWeight(.semibold)
                        .foregroundColor(GreensheetTheme.label)
                    
                    Text("Last played: \(formatLastPlayed(course.lastPlayed))")
                        .font(GreensheetTheme.captionFont)
                        .foregroundColor(GreensheetTheme.secondaryLabel)
                }
                
                Spacer()
                
                if let lastScore = course.lastScore {
                    Text("+\(lastScore - course.par)")
                        .font(GreensheetTheme.bodyFont)
                        .fontWeight(.semibold)
                        .foregroundColor(.scoreColor(for: lastScore, par: course.par))
                }
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
    
    private func formatLastPlayed(_ date: Date?) -> String {
        guard let date = date else { return "Never" }
        
        let days = Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0
        
        if days == 0 {
            return "Today"
        } else if days == 1 {
            return "Yesterday"
        } else if days < 7 {
            return "\(days) days ago"
        } else {
            return "\(days / 7) week\(days / 7 == 1 ? "" : "s") ago"
        }
    }
}

struct QuickStatsView: View {
    var body: some View {
        HStack(spacing: GreensheetTheme.spacingMedium) {
            StatCard(value: "78", label: "Last Round")
            StatCard(value: "8", label: "Rounds This Month")
        }
        .padding(.horizontal, GreensheetTheme.spacingLarge)
    }
}

struct StatCard: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingSmall) {
            Text(value)
                .font(.custom("HostGrotesk-Regular", size: 32))
                .foregroundColor(GreensheetTheme.primaryGreen)
            
            Text(label)
                .font(GreensheetTheme.captionFont)
                .foregroundColor(GreensheetTheme.primaryGreen)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(GreensheetTheme.lightGreen.opacity(0.1))
        .cornerRadius(GreensheetTheme.cornerRadiusMedium)
    }
}





// Placeholder views for other tabs
struct RoundHistoryView: View {
    var body: some View {
        Text("Round History")
            .font(GreensheetTheme.titleFont)
    }
}

struct HandicapDashboardView: View {
    var body: some View {
        Text("Handicap Dashboard")
            .font(GreensheetTheme.titleFont)
    }
}

struct CourseManagementView: View {
    var body: some View {
        Text("Course Management")
            .font(GreensheetTheme.titleFont)
    }
}

#Preview {
    HomeDashboardScreen()
        .environmentObject(AppState())
} 