//
//  HomeDashboardScreen.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

struct HomeDashboardScreen: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Greensheet")
                        .font(GreensheetTheme.titleFont)
                        .fontWeight(.bold)
                        .foregroundColor(GreensheetTheme.label)
                    
                    Spacer()
                    
                    Button("SETTINGS") {
                        // Show settings
                    }
                    .font(GreensheetTheme.captionFont)
                    .fontWeight(.medium)
                    .foregroundColor(GreensheetTheme.primaryGreen)
                }
                .padding(.horizontal, GreensheetTheme.spacingLarge)
                .padding(.top, GreensheetTheme.spacingLarge)
                
                ScrollView {
                    VStack(spacing: GreensheetTheme.spacingLarge) {
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
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        // Start Round Button
                        Button(action: {
                            appState.currentScreen = .courseSelection
                        }) {
                            HStack(spacing: GreensheetTheme.spacingMedium) {
                                Text("START")
                                    .font(GreensheetTheme.captionFont)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Text("Play a Round")
                                    .font(GreensheetTheme.bodyFont)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(GreensheetTheme.primaryGreen)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                        }
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        // Recent Courses
                        VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                            Text("Recent Courses")
                                .font(GreensheetTheme.headlineFont)
                                .fontWeight(.semibold)
                                .foregroundColor(GreensheetTheme.label)
                                .padding(.horizontal, GreensheetTheme.spacingLarge)
                            
                            VStack(spacing: 0) {
                                // Pebble Beach
                                Button(action: {
                                    appState.currentScreen = .preRoundSetup
                                }) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                                            Text("Pebble Beach Golf Links")
                                                .font(GreensheetTheme.bodyFont)
                                                .fontWeight(.semibold)
                                                .foregroundColor(GreensheetTheme.label)
                                            Text("Last played: 2 days ago")
                                                .font(GreensheetTheme.captionFont)
                                                .foregroundColor(GreensheetTheme.secondaryLabel)
                                        }
                                        Spacer()
                                        Text("+8")
                                            .font(GreensheetTheme.bodyFont)
                                            .fontWeight(.semibold)
                                            .foregroundColor(GreensheetTheme.bogey)
                                    }
                                    .padding()
                                    .background(GreensheetTheme.backgroundSecondary)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                Divider()
                                    .background(GreensheetTheme.separator)
                                    .padding(.leading, GreensheetTheme.spacingLarge)
                                
                                // Spyglass Hill
                                Button(action: {
                                    appState.currentScreen = .preRoundSetup
                                }) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                                            Text("Spyglass Hill Golf Course")
                                                .font(GreensheetTheme.bodyFont)
                                                .fontWeight(.semibold)
                                                .foregroundColor(GreensheetTheme.label)
                                            Text("Last played: 1 week ago")
                                                .font(GreensheetTheme.captionFont)
                                                .foregroundColor(GreensheetTheme.secondaryLabel)
                                        }
                                        Spacer()
                                        Text("+12")
                                            .font(GreensheetTheme.bodyFont)
                                            .fontWeight(.semibold)
                                            .foregroundColor(GreensheetTheme.bogey)
                                    }
                                    .padding()
                                    .background(GreensheetTheme.backgroundSecondary)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .background(GreensheetTheme.backgroundSecondary)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                            .padding(.horizontal, GreensheetTheme.spacingLarge)
                        }
                        
                        // Quick Stats
                        HStack(spacing: GreensheetTheme.spacingMedium) {
                            VStack(spacing: GreensheetTheme.spacingSmall) {
                                Text("78")
                                    .font(.custom("HostGrotesk-Regular", size: 32))
                                    .fontWeight(.bold)
                                    .foregroundColor(GreensheetTheme.primaryGreen)
                                Text("Last Round")
                                    .font(GreensheetTheme.captionFont)
                                    .foregroundColor(GreensheetTheme.secondaryLabel)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                            
                            VStack(spacing: GreensheetTheme.spacingSmall) {
                                Text("8")
                                    .font(.custom("HostGrotesk-Regular", size: 32))
                                    .fontWeight(.bold)
                                    .foregroundColor(GreensheetTheme.primaryGreen)
                                Text("Rounds This Month")
                                    .font(GreensheetTheme.captionFont)
                                    .foregroundColor(GreensheetTheme.secondaryLabel)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                        }
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                    }
                    .padding(.vertical, GreensheetTheme.spacingLarge)
                }
                
                // Tab Bar
                HStack(spacing: 0) {
                    TabButton(
                        icon: "HOME",
                        label: "Home",
                        isActive: true,
                        action: { }
                    )
                    
                    TabButton(
                        icon: "ROUNDS",
                        label: "Rounds",
                        isActive: false,
                        action: { appState.currentScreen = .roundHistory }
                    )
                    
                    TabButton(
                        icon: "HANDICAP",
                        label: "Handicap",
                        isActive: false,
                        action: { appState.currentScreen = .handicapDashboard }
                    )
                    
                    TabButton(
                        icon: "COURSES",
                        label: "Courses",
                        isActive: false,
                        action: { appState.currentScreen = .courseManagement }
                    )
                }
                .background(GreensheetTheme.backgroundSecondary)
                .overlay(
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(GreensheetTheme.separator),
                    alignment: .top
                )
            }
            .background(GreensheetTheme.backgroundPrimary)
        }
    }
}

struct TabButton: View {
    let icon: String
    let label: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: GreensheetTheme.spacingSmall) {
                Text(icon)
                    .font(GreensheetTheme.smallFont)
                    .fontWeight(.medium)
                    .foregroundColor(isActive ? GreensheetTheme.primaryGreen : GreensheetTheme.secondaryLabel)
                
                Text(label)
                    .font(GreensheetTheme.smallFont)
                    .fontWeight(.medium)
                    .foregroundColor(isActive ? GreensheetTheme.primaryGreen : GreensheetTheme.secondaryLabel)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, GreensheetTheme.spacingMedium)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Round History View (matching HTML)
struct RoundHistoryView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("My Rounds")
                        .font(GreensheetTheme.titleFont)
                        .fontWeight(.bold)
                        .foregroundColor(GreensheetTheme.label)
                    
                    Spacer()
                    
                    Button("+") {
                        // Add round
                    }
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(GreensheetTheme.primaryGreen)
                }
                .padding(.horizontal, GreensheetTheme.spacingLarge)
                .padding(.top, GreensheetTheme.spacingLarge)
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(GreensheetTheme.secondaryLabel)
                    TextField("Search rounds...", text: .constant(""))
                        .font(GreensheetTheme.bodyFont)
                }
                .padding()
                .background(GreensheetTheme.backgroundSecondary)
                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                .padding(.horizontal, GreensheetTheme.spacingLarge)
                .padding(.top, GreensheetTheme.spacingMedium)
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Round 1
                        Button(action: {
                            appState.currentScreen = .roundDetails
                        }) {
                            HStack {
                                VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                                    Text("Pebble Beach Golf Links")
                                        .font(GreensheetTheme.bodyFont)
                                        .fontWeight(.semibold)
                                        .foregroundColor(GreensheetTheme.label)
                                    Text("Today • Casual Round")
                                        .font(GreensheetTheme.captionFont)
                                        .foregroundColor(GreensheetTheme.secondaryLabel)
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: GreensheetTheme.spacingSmall) {
                                    Text("78")
                                        .font(GreensheetTheme.bodyFont)
                                        .fontWeight(.semibold)
                                        .foregroundColor(GreensheetTheme.primaryGreen)
                                    Text("+6")
                                        .font(GreensheetTheme.captionFont)
                                        .foregroundColor(GreensheetTheme.bogey)
                                }
                            }
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Divider()
                            .background(GreensheetTheme.separator)
                            .padding(.leading, GreensheetTheme.spacingLarge)
                        
                        // Round 2
                        Button(action: {
                            appState.currentScreen = .roundDetails
                        }) {
                            HStack {
                                VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                                    Text("Pebble Beach Golf Links")
                                        .font(GreensheetTheme.bodyFont)
                                        .fontWeight(.semibold)
                                        .foregroundColor(GreensheetTheme.label)
                                    Text("2 days ago • Practice Round")
                                        .font(GreensheetTheme.captionFont)
                                        .foregroundColor(GreensheetTheme.secondaryLabel)
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: GreensheetTheme.spacingSmall) {
                                    Text("82")
                                        .font(GreensheetTheme.bodyFont)
                                        .fontWeight(.semibold)
                                        .foregroundColor(GreensheetTheme.primaryGreen)
                                    Text("+10")
                                        .font(GreensheetTheme.captionFont)
                                        .foregroundColor(GreensheetTheme.bogey)
                                }
                            }
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Divider()
                            .background(GreensheetTheme.separator)
                            .padding(.leading, GreensheetTheme.spacingLarge)
                        
                        // Round 3
                        Button(action: {
                            appState.currentScreen = .roundDetails
                        }) {
                            HStack {
                                VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                                    Text("Spyglass Hill Golf Course")
                                        .font(GreensheetTheme.bodyFont)
                                        .fontWeight(.semibold)
                                        .foregroundColor(GreensheetTheme.label)
                                    Text("1 week ago • Casual Round")
                                        .font(GreensheetTheme.captionFont)
                                        .foregroundColor(GreensheetTheme.secondaryLabel)
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: GreensheetTheme.spacingSmall) {
                                    Text("79")
                                        .font(GreensheetTheme.bodyFont)
                                        .fontWeight(.semibold)
                                        .foregroundColor(GreensheetTheme.primaryGreen)
                                    Text("+7")
                                        .font(GreensheetTheme.captionFont)
                                        .foregroundColor(GreensheetTheme.bogey)
                                }
                            }
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .background(GreensheetTheme.backgroundSecondary)
                    .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                    .padding(.horizontal, GreensheetTheme.spacingLarge)
                    .padding(.top, GreensheetTheme.spacingMedium)
                }
                
                // Tab Bar
                HStack(spacing: 0) {
                    TabButton(
                        icon: "HOME",
                        label: "Home",
                        isActive: false,
                        action: { appState.currentScreen = .homeDashboard }
                    )
                    
                    TabButton(
                        icon: "ROUNDS",
                        label: "Rounds",
                        isActive: true,
                        action: { }
                    )
                    
                    TabButton(
                        icon: "HANDICAP",
                        label: "Handicap",
                        isActive: false,
                        action: { appState.currentScreen = .handicapDashboard }
                    )
                    
                    TabButton(
                        icon: "COURSES",
                        label: "Courses",
                        isActive: false,
                        action: { appState.currentScreen = .courseManagement }
                    )
                }
                .background(GreensheetTheme.backgroundSecondary)
                .overlay(
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(GreensheetTheme.separator),
                    alignment: .top
                )
            }
            .background(GreensheetTheme.backgroundPrimary)
        }
    }
}

// MARK: - Handicap Dashboard View (matching HTML)
struct HandicapDashboardView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Handicap")
                        .font(GreensheetTheme.titleFont)
                        .fontWeight(.bold)
                        .foregroundColor(GreensheetTheme.label)
                    
                    Spacer()
                    
                    Button("INFO") {
                        // Show handicap info
                    }
                    .font(GreensheetTheme.captionFont)
                    .fontWeight(.medium)
                    .foregroundColor(GreensheetTheme.primaryGreen)
                }
                .padding(.horizontal, GreensheetTheme.spacingLarge)
                .padding(.top, GreensheetTheme.spacingLarge)
                
                ScrollView {
                    VStack(spacing: GreensheetTheme.spacingLarge) {
                        // Handicap Display Large
                        VStack(spacing: GreensheetTheme.spacingMedium) {
                            Text("12.4")
                                .font(.custom("HostGrotesk-Regular", size: 64))
                                .fontWeight(.bold)
                                .foregroundColor(GreensheetTheme.primaryGreen)
                            
                            Text("IMPROVING")
                                .font(GreensheetTheme.captionFont)
                                .fontWeight(.semibold)
                                .foregroundColor(GreensheetTheme.birdie)
                        }
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        // Handicap Info
                        VStack(spacing: GreensheetTheme.spacingSmall) {
                            Text("Based on your best 8 of last 20 rounds")
                                .font(GreensheetTheme.bodyFont)
                                .foregroundColor(GreensheetTheme.secondaryLabel)
                            Text("You need 12 more rounds for an official handicap")
                                .font(GreensheetTheme.bodyFont)
                                .foregroundColor(GreensheetTheme.secondaryLabel)
                        }
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        // Recent Rounds Used
                        VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                            Text("Recent Rounds Used")
                                .font(GreensheetTheme.headlineFont)
                                .fontWeight(.semibold)
                                .foregroundColor(GreensheetTheme.label)
                                .padding(.horizontal, GreensheetTheme.spacingLarge)
                            
                            VStack(spacing: 0) {
                                // Round 1
                                HStack {
                                    Text("Today")
                                        .font(GreensheetTheme.bodyFont)
                                        .foregroundColor(GreensheetTheme.secondaryLabel)
                                    Text("Pebble Beach")
                                        .font(GreensheetTheme.bodyFont)
                                        .foregroundColor(GreensheetTheme.label)
                                    Spacer()
                                    Text("78 (+6)")
                                        .font(GreensheetTheme.bodyFont)
                                        .foregroundColor(GreensheetTheme.primaryGreen)
                                }
                                .padding()
                                .background(GreensheetTheme.backgroundSecondary)
                                
                                Divider()
                                    .background(GreensheetTheme.separator)
                                    .padding(.leading, GreensheetTheme.spacingLarge)
                                
                                // Round 2
                                HStack {
                                    Text("2 days ago")
                                        .font(GreensheetTheme.bodyFont)
                                        .foregroundColor(GreensheetTheme.secondaryLabel)
                                    Text("Pebble Beach")
                                        .font(GreensheetTheme.bodyFont)
                                        .foregroundColor(GreensheetTheme.label)
                                    Spacer()
                                    Text("82 (+10)")
                                        .font(GreensheetTheme.bodyFont)
                                        .foregroundColor(GreensheetTheme.primaryGreen)
                                }
                                .padding()
                                .background(GreensheetTheme.backgroundSecondary)
                                
                                Divider()
                                    .background(GreensheetTheme.separator)
                                    .padding(.leading, GreensheetTheme.spacingLarge)
                                
                                // Round 3
                                HStack {
                                    Text("1 week ago")
                                        .font(GreensheetTheme.bodyFont)
                                        .foregroundColor(GreensheetTheme.secondaryLabel)
                                    Text("Spyglass Hill")
                                        .font(GreensheetTheme.bodyFont)
                                        .foregroundColor(GreensheetTheme.label)
                                    Spacer()
                                    Text("79 (+7)")
                                        .font(GreensheetTheme.bodyFont)
                                        .foregroundColor(GreensheetTheme.primaryGreen)
                                }
                                .padding()
                                .background(GreensheetTheme.backgroundSecondary)
                            }
                            .background(GreensheetTheme.backgroundSecondary)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                            .padding(.horizontal, GreensheetTheme.spacingLarge)
                        }
                    }
                    .padding(.vertical, GreensheetTheme.spacingLarge)
                }
                
                // Tab Bar
                HStack(spacing: 0) {
                    TabButton(
                        icon: "HOME",
                        label: "Home",
                        isActive: false,
                        action: { appState.currentScreen = .homeDashboard }
                    )
                    
                    TabButton(
                        icon: "ROUNDS",
                        label: "Rounds",
                        isActive: false,
                        action: { appState.currentScreen = .roundHistory }
                    )
                    
                    TabButton(
                        icon: "HANDICAP",
                        label: "Handicap",
                        isActive: true,
                        action: { }
                    )
                    
                    TabButton(
                        icon: "COURSES",
                        label: "Courses",
                        isActive: false,
                        action: { appState.currentScreen = .courseManagement }
                    )
                }
                .background(GreensheetTheme.backgroundSecondary)
                .overlay(
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(GreensheetTheme.separator),
                    alignment: .top
                )
            }
            .background(GreensheetTheme.backgroundPrimary)
        }
    }
}

// MARK: - Course Management View (matching HTML)
struct CourseManagementView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("My Courses")
                        .font(GreensheetTheme.titleFont)
                        .fontWeight(.bold)
                        .foregroundColor(GreensheetTheme.label)
                    
                    Spacer()
                    
                    Button("+") {
                        appState.currentScreen = .firstCourseSetup
                    }
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(GreensheetTheme.primaryGreen)
                }
                .padding(.horizontal, GreensheetTheme.spacingLarge)
                .padding(.top, GreensheetTheme.spacingLarge)
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Course 1
                        Button(action: {
                            appState.currentScreen = .courseDetails
                        }) {
                            HStack {
                                VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                                    Text("Pebble Beach Golf Links")
                                        .font(GreensheetTheme.bodyFont)
                                        .fontWeight(.semibold)
                                        .foregroundColor(GreensheetTheme.label)
                                    Text("Pebble Beach, CA • Par 72 • 8 times played")
                                        .font(GreensheetTheme.captionFont)
                                        .foregroundColor(GreensheetTheme.secondaryLabel)
                                }
                                Spacer()
                                HStack(spacing: GreensheetTheme.spacingMedium) {
                                    Button("FAV") {
                                        // Toggle favorite
                                    }
                                    .font(GreensheetTheme.smallFont)
                                    .fontWeight(.medium)
                                    .foregroundColor(GreensheetTheme.primaryGreen)
                                    .padding(.horizontal, GreensheetTheme.spacingMedium)
                                    .padding(.vertical, GreensheetTheme.spacingSmall)
                                    .background(GreensheetTheme.backgroundTertiary)
                                    .cornerRadius(GreensheetTheme.cornerRadiusSmall)
                                    
                                    Text("→")
                                        .font(GreensheetTheme.bodyFont)
                                        .foregroundColor(GreensheetTheme.secondaryLabel)
                                }
                            }
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Divider()
                            .background(GreensheetTheme.separator)
                            .padding(.leading, GreensheetTheme.spacingLarge)
                        
                        // Course 2
                        Button(action: {
                            appState.currentScreen = .courseDetails
                        }) {
                            HStack {
                                VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                                    Text("Spyglass Hill Golf Course")
                                        .font(GreensheetTheme.bodyFont)
                                        .fontWeight(.semibold)
                                        .foregroundColor(GreensheetTheme.label)
                                    Text("Pebble Beach, CA • Par 72 • 3 times played")
                                        .font(GreensheetTheme.captionFont)
                                        .foregroundColor(GreensheetTheme.secondaryLabel)
                                }
                                Spacer()
                                HStack(spacing: GreensheetTheme.spacingMedium) {
                                    Button("FAV") {
                                        // Toggle favorite
                                    }
                                    .font(GreensheetTheme.smallFont)
                                    .fontWeight(.medium)
                                    .foregroundColor(GreensheetTheme.primaryGreen)
                                    .padding(.horizontal, GreensheetTheme.spacingMedium)
                                    .padding(.vertical, GreensheetTheme.spacingSmall)
                                    .background(GreensheetTheme.backgroundTertiary)
                                    .cornerRadius(GreensheetTheme.cornerRadiusSmall)
                                    
                                    Text("→")
                                        .font(GreensheetTheme.bodyFont)
                                        .foregroundColor(GreensheetTheme.secondaryLabel)
                                }
                            }
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .background(GreensheetTheme.backgroundSecondary)
                    .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                    .padding(.horizontal, GreensheetTheme.spacingLarge)
                    .padding(.top, GreensheetTheme.spacingLarge)
                }
                
                // Tab Bar
                HStack(spacing: 0) {
                    TabButton(
                        icon: "HOME",
                        label: "Home",
                        isActive: false,
                        action: { appState.currentScreen = .homeDashboard }
                    )
                    
                    TabButton(
                        icon: "ROUNDS",
                        label: "Rounds",
                        isActive: false,
                        action: { appState.currentScreen = .roundHistory }
                    )
                    
                    TabButton(
                        icon: "HANDICAP",
                        label: "Handicap",
                        isActive: false,
                        action: { appState.currentScreen = .handicapDashboard }
                    )
                    
                    TabButton(
                        icon: "COURSES",
                        label: "Courses",
                        isActive: true,
                        action: { }
                    )
                }
                .background(GreensheetTheme.backgroundSecondary)
                .overlay(
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(GreensheetTheme.separator),
                    alignment: .top
                )
            }
            .background(GreensheetTheme.backgroundPrimary)
        }
    }
}

// MARK: - Missing Views for ContentView
struct RoundDetailsView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button("←") {
                        appState.currentScreen = .roundHistory
                    }
                    .font(.title2)
                    .foregroundColor(GreensheetTheme.primaryGreen)
                    
                    Text("Round Details")
                        .font(GreensheetTheme.titleFont)
                        .fontWeight(.bold)
                        .foregroundColor(GreensheetTheme.label)
                    
                    Spacer()
                    
                    Button("SHARE") {
                        // Share round
                    }
                    .font(GreensheetTheme.captionFont)
                    .fontWeight(.medium)
                    .foregroundColor(GreensheetTheme.primaryGreen)
                }
                .padding(.horizontal, GreensheetTheme.spacingLarge)
                .padding(.top, GreensheetTheme.spacingLarge)
                
                ScrollView {
                    VStack(spacing: GreensheetTheme.spacingLarge) {
                        // Round Header
                        VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                            Text("Pebble Beach Golf Links")
                                .font(GreensheetTheme.headlineFont)
                                .fontWeight(.semibold)
                                .foregroundColor(GreensheetTheme.label)
                            Text("Today • White Tees • Casual Round")
                                .font(GreensheetTheme.bodyFont)
                                .foregroundColor(GreensheetTheme.secondaryLabel)
                            Text("Playing with: John, Mike")
                                .font(GreensheetTheme.bodyFont)
                                .foregroundColor(GreensheetTheme.secondaryLabel)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        // Round Stats
                        VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                            HStack {
                                Text("Round Stats")
                                    .font(GreensheetTheme.headlineFont)
                                    .fontWeight(.semibold)
                                    .foregroundColor(GreensheetTheme.label)
                                
                                Spacer()
                                
                                Button(action: {
                                    appState.currentScreen = .holeByHole
                                }) {
                                    HStack(spacing: GreensheetTheme.spacingSmall) {
                                        Text("See Hole By Hole")
                                            .font(GreensheetTheme.captionFont)
                                            .foregroundColor(GreensheetTheme.primaryGreen)
                                        Text("→")
                                            .font(GreensheetTheme.captionFont)
                                            .foregroundColor(GreensheetTheme.primaryGreen)
                                    }
                                }
                            }
                            .padding(.horizontal, GreensheetTheme.spacingLarge)
                            
                            // Stats Cards
                            VStack(spacing: 0) {
                                // Fairways
                                HStack {
                                    Circle()
                                        .fill(GreensheetTheme.primaryGreen)
                                        .frame(width: 40, height: 40)
                                        .overlay(
                                            Text("FW")
                                                .font(GreensheetTheme.smallFont)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                        )
                                    
                                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                                        Text("FAIRWAYS")
                                            .font(GreensheetTheme.smallFont)
                                            .fontWeight(.semibold)
                                            .foregroundColor(GreensheetTheme.secondaryLabel)
                                        Text("10 • From 14")
                                            .font(GreensheetTheme.captionFont)
                                            .foregroundColor(GreensheetTheme.secondaryLabel)
                                    }
                                    
                                    Spacer()
                                    
                                    Text("10")
                                        .font(GreensheetTheme.bodyFont)
                                        .fontWeight(.semibold)
                                        .foregroundColor(GreensheetTheme.primaryGreen)
                                }
                                .padding()
                                .background(GreensheetTheme.backgroundSecondary)
                                
                                Divider()
                                    .background(GreensheetTheme.separator)
                                    .padding(.leading, GreensheetTheme.spacingLarge)
                                
                                // Putts
                                HStack {
                                    Circle()
                                        .fill(GreensheetTheme.birdie)
                                        .frame(width: 40, height: 40)
                                        .overlay(
                                            Text("P")
                                                .font(GreensheetTheme.smallFont)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                        )
                                    
                                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                                        Text("PUTTS / HOLE")
                                            .font(GreensheetTheme.smallFont)
                                            .fontWeight(.semibold)
                                            .foregroundColor(GreensheetTheme.secondaryLabel)
                                        Text("+1.8 • From 18")
                                            .font(GreensheetTheme.captionFont)
                                            .foregroundColor(GreensheetTheme.secondaryLabel)
                                    }
                                    
                                    Spacer()
                                    
                                    Text("+1.8")
                                        .font(GreensheetTheme.bodyFont)
                                        .fontWeight(.semibold)
                                        .foregroundColor(GreensheetTheme.birdie)
                                }
                                .padding()
                                .background(GreensheetTheme.backgroundSecondary)
                                
                                Divider()
                                    .background(GreensheetTheme.separator)
                                    .padding(.leading, GreensheetTheme.spacingLarge)
                                
                                // GIR
                                HStack {
                                    Circle()
                                        .fill(GreensheetTheme.primaryGreen)
                                        .frame(width: 40, height: 40)
                                        .overlay(
                                            Text("G")
                                                .font(GreensheetTheme.smallFont)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                        )
                                    
                                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                                        Text("GIR")
                                            .font(GreensheetTheme.smallFont)
                                            .fontWeight(.semibold)
                                            .foregroundColor(GreensheetTheme.secondaryLabel)
                                        Text("8 • From 18")
                                            .font(GreensheetTheme.captionFont)
                                            .foregroundColor(GreensheetTheme.secondaryLabel)
                                    }
                                    
                                    Spacer()
                                    
                                    Text("8")
                                        .font(GreensheetTheme.bodyFont)
                                        .fontWeight(.semibold)
                                        .foregroundColor(GreensheetTheme.primaryGreen)
                                }
                                .padding()
                                .background(GreensheetTheme.backgroundSecondary)
                            }
                            .background(GreensheetTheme.backgroundSecondary)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                            .padding(.horizontal, GreensheetTheme.spacingLarge)
                        }
                    }
                    .padding(.vertical, GreensheetTheme.spacingLarge)
                }
            }
            .background(GreensheetTheme.backgroundPrimary)
        }
    }
}

struct HoleByHoleView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button("←") {
                        appState.currentScreen = .roundDetails
                    }
                    .font(.title2)
                    .foregroundColor(GreensheetTheme.primaryGreen)
                    
                    Text("Hole by Hole")
                        .font(GreensheetTheme.titleFont)
                        .fontWeight(.bold)
                        .foregroundColor(GreensheetTheme.label)
                    
                    Spacer()
                }
                .padding(.horizontal, GreensheetTheme.spacingLarge)
                .padding(.top, GreensheetTheme.spacingLarge)
                
                ScrollView {
                    VStack(spacing: GreensheetTheme.spacingLarge) {
                        // Round Header
                        VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                            Text("Monday, Jul 21, 7:49AM")
                                .font(GreensheetTheme.headlineFont)
                                .fontWeight(.semibold)
                                .foregroundColor(GreensheetTheme.label)
                            Text("18 Holes • Green Briar Golf Course")
                                .font(GreensheetTheme.bodyFont)
                                .foregroundColor(GreensheetTheme.secondaryLabel)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        // Hole Stats Table
                        VStack(spacing: 0) {
                            // Table Header
                            HStack {
                                Text("Hole")
                                    .font(GreensheetTheme.captionFont)
                                    .fontWeight(.semibold)
                                    .foregroundColor(GreensheetTheme.secondaryLabel)
                                    .frame(width: 60, alignment: .leading)
                                
                                Text("Strokes")
                                    .font(GreensheetTheme.captionFont)
                                    .fontWeight(.semibold)
                                    .foregroundColor(GreensheetTheme.secondaryLabel)
                                    .frame(maxWidth: .infinity)
                                
                                Text("Fairways")
                                    .font(GreensheetTheme.captionFont)
                                    .fontWeight(.semibold)
                                    .foregroundColor(GreensheetTheme.secondaryLabel)
                                    .frame(maxWidth: .infinity)
                                
                                Text("Putts")
                                    .font(GreensheetTheme.captionFont)
                                    .fontWeight(.semibold)
                                    .foregroundColor(GreensheetTheme.secondaryLabel)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding()
                            .background(GreensheetTheme.backgroundTertiary)
                            
                            // Table Rows
                            ForEach(1...18, id: \.self) { hole in
                                HStack {
                                    Text("\(hole)")
                                        .font(GreensheetTheme.bodyFont)
                                        .fontWeight(.medium)
                                        .foregroundColor(GreensheetTheme.label)
                                        .frame(width: 60, alignment: .leading)
                                    
                                    Text("\(hole <= 9 ? 4 : 5)")
                                        .font(GreensheetTheme.bodyFont)
                                        .foregroundColor(GreensheetTheme.primaryGreen)
                                        .frame(maxWidth: .infinity)
                                    
                                    Text("-")
                                        .font(GreensheetTheme.bodyFont)
                                        .foregroundColor(GreensheetTheme.secondaryLabel)
                                        .frame(maxWidth: .infinity)
                                    
                                    Text("\(hole % 2 == 0 ? 1 : 2)")
                                        .font(GreensheetTheme.bodyFont)
                                        .foregroundColor(GreensheetTheme.birdie)
                                        .frame(maxWidth: .infinity)
                                }
                                .padding()
                                .background(hole % 2 == 0 ? GreensheetTheme.backgroundSecondary : GreensheetTheme.backgroundPrimary)
                                
                                if hole < 18 {
                                    Divider()
                                        .background(GreensheetTheme.separator)
                                        .padding(.leading, GreensheetTheme.spacingLarge)
                                }
                            }
                        }
                        .background(GreensheetTheme.backgroundSecondary)
                        .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                    }
                    .padding(.vertical, GreensheetTheme.spacingLarge)
                }
            }
            .background(GreensheetTheme.backgroundPrimary)
        }
    }
}

#Preview {
    HomeDashboardScreen()
        .environmentObject(AppState())
} 