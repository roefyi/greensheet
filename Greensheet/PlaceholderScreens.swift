//
//  PlaceholderScreens.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

// MARK: - Hole Details Screen
struct HoleDetailsScreen: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingLarge) {
            NavigationHeader(
                title: "Hole Details",
                showBackButton: true,
                backAction: { appState.goBack() }
            )
            
            Spacer()
            
            Text("Hole Details Screen")
                .font(GreensheetTheme.titleFont)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .background(GreensheetTheme.backgroundPrimary)
    }
}

// MARK: - Tee Setup Screen
struct TeeSetupScreen: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingLarge) {
            NavigationHeader(
                title: "Tee Options",
                showBackButton: true,
                backAction: { appState.goBack() }
            )
            
            Spacer()
            
            Text("Tee Setup Screen")
                .font(GreensheetTheme.titleFont)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .background(GreensheetTheme.backgroundPrimary)
    }
}

// MARK: - Round Summary Screen
struct RoundSummaryScreen: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingLarge) {
            NavigationHeader(
                title: "Round Complete!",
                showBackButton: false,
                backAction: nil
            )
            
            Spacer()
            
            VStack(spacing: GreensheetTheme.spacingLarge) {
                // Final Score
                VStack(spacing: GreensheetTheme.spacingSmall) {
                    Text("Final Score")
                        .font(GreensheetTheme.captionFont)
                        .foregroundColor(.secondary)
                    
                    Text("78")
                        .font(.system(size: 64, weight: .bold))
                        .foregroundColor(GreensheetTheme.primaryGreen)
                    
                    Text("+6")
                        .font(GreensheetTheme.headlineFont)
                        .foregroundColor(.scoreColor(for: 78, par: 72))
                }
                
                // Score Breakdown
                HStack(spacing: GreensheetTheme.spacingLarge) {
                    VStack(spacing: GreensheetTheme.spacingSmall) {
                        Text("Front 9")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(.secondary)
                        Text("36 (+0)")
                            .font(GreensheetTheme.bodyFont)
                            .fontWeight(.semibold)
                    }
                    
                    VStack(spacing: GreensheetTheme.spacingSmall) {
                        Text("Back 9")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(.secondary)
                        Text("42 (+6)")
                            .font(GreensheetTheme.bodyFont)
                            .fontWeight(.semibold)
                    }
                }
                
                // Round Stats
                VStack(spacing: GreensheetTheme.spacingMedium) {
                    Text("Round Stats")
                        .font(GreensheetTheme.headlineFont)
                        .fontWeight(.semibold)
                    
                    HStack(spacing: GreensheetTheme.spacingLarge) {
                        StatItem(value: "12", label: "Pars")
                        StatItem(value: "2", label: "Birdies")
                        StatItem(value: "4", label: "Bogeys")
                        StatItem(value: "0", label: "Others")
                    }
                }
            }
            
            Spacer()
            
            // Action Buttons
            HStack(spacing: GreensheetTheme.spacingMedium) {
                Button("Share") {
                    // Share round
                }
                .buttonStyle(GreensheetTheme.secondaryButtonStyle)
                
                Button("Save Round") {
                    appState.navigateTo(.homeDashboard)
                }
                .buttonStyle(GreensheetTheme.primaryButtonStyle)
            }
            .padding(.horizontal, GreensheetTheme.spacingLarge)
        }
        .background(GreensheetTheme.backgroundPrimary)
    }
}

struct StatItem: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingSmall) {
            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(GreensheetTheme.primaryGreen)
            
            Text(label)
                .font(GreensheetTheme.captionFont)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Handicap Dashboard Screen
struct HandicapDashboardScreen: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingLarge) {
            NavigationHeader(
                title: "Handicap",
                showBackButton: false,
                backAction: nil
            )
            
            ScrollView {
                VStack(spacing: GreensheetTheme.spacingLarge) {
                    // Handicap Display
                    VStack(spacing: GreensheetTheme.spacingSmall) {
                        Text("12.4")
                            .font(.system(size: 64, weight: .bold))
                            .foregroundColor(GreensheetTheme.primaryGreen)
                        
                        Text("IMPROVING")
                            .font(GreensheetTheme.captionFont)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(GreensheetTheme.lightGreen.opacity(0.1))
                    .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                    
                    // Handicap Info
                    VStack(spacing: GreensheetTheme.spacingSmall) {
                        Text("Based on your best 8 of last 20 rounds")
                            .font(GreensheetTheme.bodyFont)
                            .foregroundColor(.secondary)
                        
                        Text("You need 12 more rounds for an official handicap")
                            .font(GreensheetTheme.bodyFont)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(GreensheetTheme.backgroundSecondary)
                    .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                    
                    // Recent Rounds
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                        Text("Recent Rounds Used")
                            .font(GreensheetTheme.headlineFont)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 0) {
                            RoundItem(date: "Today", course: "Pebble Beach", score: "78 (+6)")
                            Divider()
                            RoundItem(date: "2 days ago", course: "Pebble Beach", score: "82 (+10)")
                            Divider()
                            RoundItem(date: "1 week ago", course: "Spyglass Hill", score: "79 (+7)")
                        }
                        .background(GreensheetTheme.backgroundSecondary)
                        .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                    }
                }
                .padding(.horizontal, GreensheetTheme.spacingLarge)
            }
        }
        .background(GreensheetTheme.backgroundPrimary)
    }
}

struct RoundItem: View {
    let date: String
    let course: String
    let score: String
    
    var body: some View {
        HStack(spacing: GreensheetTheme.spacingMedium) {
            Text(date)
                .font(GreensheetTheme.captionFont)
                .foregroundColor(.secondary)
                .frame(width: 80, alignment: .leading)
            
            Text(course)
                .font(GreensheetTheme.bodyFont)
                .foregroundColor(.primary)
            
            Spacer()
            
            Text(score)
                .font(GreensheetTheme.bodyFont)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
        }
        .padding()
    }
}

// MARK: - Round History Screen
struct RoundHistoryScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var searchText = ""
    
    private let rounds = [
        RoundHistoryItem(course: "Pebble Beach Golf Links", date: "Today", type: "Casual Round", score: 78, vsPar: 6),
        RoundHistoryItem(course: "Pebble Beach Golf Links", date: "2 days ago", type: "Practice Round", score: 82, vsPar: 10),
        RoundHistoryItem(course: "Spyglass Hill Golf Course", date: "1 week ago", type: "Casual Round", score: 79, vsPar: 7)
    ]
    
    var filteredRounds: [RoundHistoryItem] {
        if searchText.isEmpty {
            return rounds
        } else {
            return rounds.filter { $0.course.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationHeader(
                title: "My Rounds",
                showBackButton: false,
                backAction: nil
            )
            
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                
                TextField("Search rounds...", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(GreensheetTheme.bodyFont)
            }
            .padding()
            .background(GreensheetTheme.backgroundSecondary)
            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
            .padding(.horizontal, GreensheetTheme.spacingLarge)
            .padding(.bottom, GreensheetTheme.spacingMedium)
            
            // Rounds List
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(filteredRounds, id: \.id) { round in
                        RoundHistoryRow(round: round) {
                            appState.navigateTo(.roundDetails)
                        }
                        
                        if round.id != filteredRounds.last?.id {
                            Divider()
                                .padding(.leading, GreensheetTheme.spacingLarge)
                        }
                    }
                }
                .background(GreensheetTheme.backgroundSecondary)
                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                .padding(.horizontal, GreensheetTheme.spacingLarge)
            }
        }
        .background(GreensheetTheme.backgroundPrimary)
    }
}

struct RoundHistoryItem: Identifiable {
    let id = UUID()
    let course: String
    let date: String
    let type: String
    let score: Int
    let vsPar: Int
}

struct RoundHistoryRow: View {
    let round: RoundHistoryItem
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: GreensheetTheme.spacingMedium) {
                VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                    Text(round.course)
                        .font(GreensheetTheme.bodyFont)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text("\(round.date) • \(round.type)")
                        .font(GreensheetTheme.captionFont)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: GreensheetTheme.spacingSmall) {
                    Text("\(round.score)")
                        .font(GreensheetTheme.bodyFont)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text("+\(round.vsPar)")
                        .font(GreensheetTheme.captionFont)
                        .foregroundColor(.scoreColor(for: round.score, par: round.score - round.vsPar))
                }
            }
            .padding()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Round Details Screen
struct RoundDetailsScreen: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingLarge) {
            NavigationHeader(
                title: "Round Details",
                showBackButton: true,
                backAction: { appState.goBack() }
            )
            
            ScrollView {
                VStack(spacing: GreensheetTheme.spacingLarge) {
                    Text("Round Details Screen")
                        .font(GreensheetTheme.titleFont)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, GreensheetTheme.spacingLarge)
            }
        }
        .background(GreensheetTheme.backgroundPrimary)
    }
}

// MARK: - Hole by Hole Screen
struct HoleByHoleScreen: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingLarge) {
            NavigationHeader(
                title: "Hole by Hole",
                showBackButton: true,
                backAction: { appState.goBack() }
            )
            
            ScrollView {
                VStack(spacing: GreensheetTheme.spacingLarge) {
                    Text("Hole by Hole Screen")
                        .font(GreensheetTheme.titleFont)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, GreensheetTheme.spacingLarge)
            }
        }
        .background(GreensheetTheme.backgroundPrimary)
    }
}

// MARK: - Course Management Screen
struct CourseManagementScreen: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationHeader(
                title: "My Courses",
                showBackButton: false,
                backAction: nil
            )
            
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(CourseModel.sampleCourses, id: \.id) { course in
                        CourseManagementRow(course: course)
                        
                        if course.id != CourseModel.sampleCourses.last?.id {
                            Divider()
                                .padding(.leading, GreensheetTheme.spacingLarge)
                        }
                    }
                }
                .background(GreensheetTheme.backgroundSecondary)
                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                .padding(.horizontal, GreensheetTheme.spacingLarge)
            }
        }
        .background(GreensheetTheme.backgroundPrimary)
    }
}

struct CourseManagementRow: View {
    let course: CourseModel
    
    var body: some View {
        HStack(spacing: GreensheetTheme.spacingMedium) {
            VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                Text(course.name)
                    .font(GreensheetTheme.bodyFont)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Text("\(course.location) • Par \(course.par) • \(course.timesPlayed) times played")
                    .font(GreensheetTheme.captionFont)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            HStack(spacing: GreensheetTheme.spacingSmall) {
                Button("FAV") {
                    // Toggle favorite
                }
                .font(GreensheetTheme.smallFont)
                .foregroundColor(course.isFavorite ? .white : GreensheetTheme.primaryGreen)
                .padding(.horizontal, GreensheetTheme.spacingSmall)
                .padding(.vertical, 4)
                .background(course.isFavorite ? GreensheetTheme.primaryGreen : GreensheetTheme.primaryGreen.opacity(0.1))
                .cornerRadius(GreensheetTheme.cornerRadiusSmall)
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}

 