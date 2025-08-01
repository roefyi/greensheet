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
    @State private var selectedHole = 1
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingLarge) {
            NavigationHeader(
                title: "Hole Details",
                showBackButton: true,
                backAction: { appState.goBack() }
            )
            
            ScrollView {
                VStack(spacing: GreensheetTheme.spacingLarge) {
                    // Hole Selector
                    HStack(spacing: GreensheetTheme.spacingSmall) {
                        ForEach(1...18, id: \.self) { hole in
                            Button(action: {
                                selectedHole = hole
                            }) {
                                Text("\(hole)")
                                    .font(GreensheetTheme.captionFont)
                                    .fontWeight(.semibold)
                                    .foregroundColor(selectedHole == hole ? .white : GreensheetTheme.primaryGreen)
                                    .frame(width: 35, height: 35)
                                    .background(selectedHole == hole ? GreensheetTheme.primaryGreen : GreensheetTheme.backgroundSecondary)
                                    .cornerRadius(GreensheetTheme.cornerRadiusSmall)
                            }
                        }
                    }
                    .padding(.horizontal, GreensheetTheme.spacingLarge)
                    
                    // Hole Info Card
                    VStack(spacing: GreensheetTheme.spacingMedium) {
                        HStack {
                            Text("Hole \(selectedHole)")
                                .font(GreensheetTheme.headlineFont)
                                .fontWeight(.semibold)
                                .foregroundColor(GreensheetTheme.label)
                            
                            Spacer()
                            
                            Text("Par \(sampleHolePar[selectedHole - 1])")
                                .font(GreensheetTheme.bodyFont)
                                .fontWeight(.semibold)
                                .foregroundColor(GreensheetTheme.primaryGreen)
                        }
                        
                        Divider()
                            .background(GreensheetTheme.separator)
                        
                        // Hole Stats
                        HStack(spacing: GreensheetTheme.spacingLarge) {
                            HoleStatItem(label: "Distance", value: "\(sampleHoleYardage[selectedHole - 1])y", icon: "location")
                            HoleStatItem(label: "Handicap", value: "\(sampleHoleHandicap[selectedHole - 1])", icon: "flag")
                        }
                        
                        // Hole Description
                        Text(sampleHoleDescriptions[selectedHole - 1])
                            .font(GreensheetTheme.bodyFont)
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    .background(GreensheetTheme.backgroundSecondary)
                    .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                    .padding(.horizontal, GreensheetTheme.spacingLarge)
                    
                    // Tee Options
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                        Text("Tee Options")
                            .font(GreensheetTheme.headlineFont)
                            .fontWeight(.semibold)
                            .foregroundColor(GreensheetTheme.label)
                            .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        VStack(spacing: 0) {
                            ForEach(sampleTeeOptions, id: \.name) { tee in
                                TeeOptionRow(tee: tee)
                                .padding(.vertical, GreensheetTheme.spacingSmall)
                                
                                if tee.name != sampleTeeOptions.last?.name {
                                    Divider()
                                        .background(GreensheetTheme.separator)
                                        .padding(.leading, GreensheetTheme.spacingLarge)
                                }
                            }
                        }
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                    }
                }
                .padding(.vertical, GreensheetTheme.spacingLarge)
            }
        }
        .background(GreensheetTheme.backgroundPrimary)
    }
    
    // Sample data moved to SampleData.swift
}

struct HoleStatItem: View {
    let label: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingSmall) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(GreensheetTheme.primaryGreen)
            
            Text(value)
                .font(GreensheetTheme.bodyFont)
                .fontWeight(.semibold)
                .foregroundColor(GreensheetTheme.label)
            
            Text(label)
                .font(GreensheetTheme.smallFont)
                .foregroundColor(GreensheetTheme.secondaryLabel)
        }
        .frame(maxWidth: .infinity)
    }
}

struct SampleTeeOption: Identifiable {
    let id = UUID()
    let name: String
    let distance: Int
    let color: Color
}

struct TeeOptionRow: View {
    let tee: SampleTeeOption
    
    var body: some View {
        HStack(spacing: GreensheetTheme.spacingMedium) {
            Circle()
                .fill(tee.color)
                .frame(width: 20, height: 20)
            
            VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                Text(tee.name)
                    .font(GreensheetTheme.bodyFont)
                    .fontWeight(.semibold)
                    .foregroundColor(GreensheetTheme.label)
                
                Text("\(tee.distance) yards")
                    .font(GreensheetTheme.captionFont)
                    .foregroundColor(GreensheetTheme.secondaryLabel)
            }
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - Tee Setup Screen
struct TeeSetupScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedTee = "White"
    @State private var numberOfPlayers = 1
    @State private var selectedPlayers: [SamplePlayer] = []
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingLarge) {
            NavigationHeader(
                title: "Tee Setup",
                showBackButton: true,
                backAction: { appState.goBack() }
            )
            
            ScrollView {
                VStack(spacing: GreensheetTheme.spacingLarge) {
                    // Course Info
                    VStack(spacing: GreensheetTheme.spacingSmall) {
                        Text("Pebble Beach Golf Links")
                            .font(GreensheetTheme.headlineFont)
                            .fontWeight(.semibold)
                            .foregroundColor(GreensheetTheme.label)
                        
                        Text("Par 72 • 7,075 yards")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                    }
                    .padding(.horizontal, GreensheetTheme.spacingLarge)
                    
                    // Tee Selection
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                        Text("Select Tee Box")
                            .font(GreensheetTheme.headlineFont)
                            .fontWeight(.semibold)
                            .foregroundColor(GreensheetTheme.label)
                            .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        VStack(spacing: 0) {
                            ForEach(sampleTeeOptions, id: \.name) { tee in
                                TeeSelectionRow(
                                    tee: tee,
                                    isSelected: selectedTee == tee.name,
                                    action: { selectedTee = tee.name }
                                )
                                .padding(.vertical, GreensheetTheme.spacingSmall)
                                
                                if tee.name != sampleTeeOptions.last?.name {
                                    Divider()
                                        .background(GreensheetTheme.separator)
                                        .padding(.leading, GreensheetTheme.spacingLarge)
                                }
                            }
                        }
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                    }
                    
                    // Player Setup
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                        Text("Players")
                            .font(GreensheetTheme.headlineFont)
                            .fontWeight(.semibold)
                            .foregroundColor(GreensheetTheme.label)
                            .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        VStack(spacing: 0) {
                            ForEach(samplePlayers, id: \.id) { player in
                                PlayerRow(
                                    player: player,
                                    isSelected: selectedPlayers.contains { $0.id == player.id },
                                    action: {
                                        if selectedPlayers.contains(where: { $0.id == player.id }) {
                                            selectedPlayers.removeAll { $0.id == player.id }
                                        } else {
                                            selectedPlayers.append(player)
                                        }
                                    }
                                )
                                .padding(.vertical, GreensheetTheme.spacingSmall)
                                
                                if player.id != samplePlayers.last?.id {
                                    Divider()
                                        .background(GreensheetTheme.separator)
                                        .padding(.leading, GreensheetTheme.spacingLarge)
                                }
                            }
                        }
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                    }
                    
                    // Weather Info
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                        Text("Weather")
                            .font(GreensheetTheme.headlineFont)
                            .fontWeight(.semibold)
                            .foregroundColor(GreensheetTheme.label)
                            .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        HStack(spacing: GreensheetTheme.spacingLarge) {
                            WeatherItem(icon: "thermometer", label: "Temperature", value: "72°F")
                            WeatherItem(icon: "wind", label: "Wind", value: "8 mph")
                            WeatherItem(icon: "cloud.sun", label: "Conditions", value: "Partly Cloudy")
                        }
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                    }
                }
                .padding(.vertical, GreensheetTheme.spacingLarge)
            }
            
            // Start Round Button
            Button("Start Round") {
                appState.navigateTo(.scorecard)
            }
            .buttonStyle(GreensheetTheme.primaryButtonStyle)
            .padding(.horizontal, GreensheetTheme.spacingLarge)
        }
        .background(GreensheetTheme.backgroundPrimary)
    }
    
    private let sampleTeeOptions = [
        SampleTeeOption(name: "Championship", distance: 7075, color: .black),
        SampleTeeOption(name: "Blue", distance: 6700, color: .blue),
        SampleTeeOption(name: "White", distance: 6300, color: .white),
        SampleTeeOption(name: "Gold", distance: 5900, color: .yellow),
        SampleTeeOption(name: "Red", distance: 5400, color: .red)
    ]
    
    private let samplePlayers = [
        SamplePlayer(id: UUID(), name: "John Smith", handicap: 12.4),
        SamplePlayer(id: UUID(), name: "Mike Johnson", handicap: 8.2),
        SamplePlayer(id: UUID(), name: "David Wilson", handicap: 15.7),
        SamplePlayer(id: UUID(), name: "Tom Brown", handicap: 6.1)
    ]
}

struct SamplePlayer: Identifiable {
    let id: UUID
    let name: String
    let handicap: Double
}

struct TeeSelectionRow: View {
    let tee: SampleTeeOption
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: GreensheetTheme.spacingMedium) {
                Circle()
                    .fill(tee.color)
                    .frame(width: 20, height: 20)
                
                VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                    Text(tee.name)
                        .font(GreensheetTheme.bodyFont)
                        .fontWeight(.semibold)
                        .foregroundColor(GreensheetTheme.label)
                    
                    Text("\(tee.distance) yards")
                        .font(GreensheetTheme.captionFont)
                        .foregroundColor(GreensheetTheme.secondaryLabel)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(GreensheetTheme.primaryGreen)
                }
            }
            .padding()
            .background(isSelected ? GreensheetTheme.lightGreen.opacity(0.1) : Color.clear)
            .cornerRadius(GreensheetTheme.cornerRadiusSmall)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct PlayerRow: View {
    let player: SamplePlayer
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: GreensheetTheme.spacingMedium) {
                VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                    Text(player.name)
                        .font(GreensheetTheme.bodyFont)
                        .fontWeight(.semibold)
                        .foregroundColor(GreensheetTheme.label)
                    
                    Text("Handicap: \(player.handicap, specifier: "%.1f")")
                        .font(GreensheetTheme.captionFont)
                        .foregroundColor(GreensheetTheme.secondaryLabel)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(GreensheetTheme.primaryGreen)
                }
            }
            .padding()
            .background(isSelected ? GreensheetTheme.lightGreen.opacity(0.1) : Color.clear)
            .cornerRadius(GreensheetTheme.cornerRadiusSmall)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct WeatherItem: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingSmall) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(GreensheetTheme.primaryGreen)
            
            Text(value)
                .font(GreensheetTheme.bodyFont)
                .fontWeight(.semibold)
                .foregroundColor(GreensheetTheme.label)
            
            Text(label)
                .font(GreensheetTheme.smallFont)
                .foregroundColor(GreensheetTheme.secondaryLabel)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(GreensheetTheme.backgroundSecondary)
        .cornerRadius(GreensheetTheme.cornerRadiusMedium)
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
            
            ScrollView {
                VStack(spacing: GreensheetTheme.spacingLarge) {
                    // Final Score
                    VStack(spacing: GreensheetTheme.spacingSmall) {
                        Text("Final Score")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                        
                        Text("78")
                            .font(.custom("HostGrotesk-Regular", size: 64))
                            .fontWeight(.bold)
                            .foregroundColor(GreensheetTheme.primaryGreen)
                        
                        Text("+6")
                            .font(GreensheetTheme.headlineFont)
                            .foregroundColor(.scoreColor(for: 78, par: 72))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(GreensheetTheme.lightGreen.opacity(0.1))
                    .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                    .padding(.horizontal, GreensheetTheme.spacingLarge)
                    
                    // Score Breakdown
                    HStack(spacing: GreensheetTheme.spacingLarge) {
                        ScoreBreakdownCard(title: "Front 9", score: 38, par: 36)
                        ScoreBreakdownCard(title: "Back 9", score: 40, par: 36)
                    }
                    .padding(.horizontal, GreensheetTheme.spacingLarge)
                    
                    // Round Stats
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                        Text("Round Statistics")
                            .font(GreensheetTheme.headlineFont)
                            .fontWeight(.semibold)
                            .foregroundColor(GreensheetTheme.label)
                            .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: GreensheetTheme.spacingMedium) {
                            RoundStatCard(title: "Putts", value: "32", icon: "flag")
                            RoundStatCard(title: "Fairways Hit", value: "10/14", icon: "location")
                            RoundStatCard(title: "Greens in Regulation", value: "8/18", icon: "circle")
                            RoundStatCard(title: "Sand Saves", value: "2/3", icon: "beach.umbrella")
                        }
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                    }
                    
                    // Score Distribution
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                        Text("Score Distribution")
                            .font(GreensheetTheme.headlineFont)
                            .fontWeight(.semibold)
                            .foregroundColor(GreensheetTheme.label)
                            .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        VStack(spacing: 0) {
                            ForEach(sampleScoreDistribution, id: \.score) { item in
                                ScoreDistributionRow(item: item)
                                .padding(.vertical, GreensheetTheme.spacingSmall)
                                
                                if item.score != sampleScoreDistribution.last?.score {
                                    Divider()
                                        .background(GreensheetTheme.separator)
                                        .padding(.leading, GreensheetTheme.spacingLarge)
                                }
                            }
                        }
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                    }
                    
                    // Handicap Impact
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                        Text("Handicap Impact")
                            .font(GreensheetTheme.headlineFont)
                            .fontWeight(.semibold)
                            .foregroundColor(GreensheetTheme.label)
                            .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        HStack(spacing: GreensheetTheme.spacingMedium) {
                            VStack(spacing: GreensheetTheme.spacingSmall) {
                                Text("Before")
                                    .font(GreensheetTheme.captionFont)
                                    .foregroundColor(GreensheetTheme.secondaryLabel)
                                Text("12.4")
                                    .font(GreensheetTheme.bodyFont)
                                    .fontWeight(.semibold)
                                    .foregroundColor(GreensheetTheme.label)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                            
                            Image(systemName: "arrow.right")
                                .foregroundColor(GreensheetTheme.primaryGreen)
                            
                            VStack(spacing: GreensheetTheme.spacingSmall) {
                                Text("After")
                                    .font(GreensheetTheme.captionFont)
                                    .foregroundColor(GreensheetTheme.secondaryLabel)
                                Text("12.1")
                                    .font(GreensheetTheme.bodyFont)
                                    .fontWeight(.semibold)
                                    .foregroundColor(GreensheetTheme.birdie)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                        }
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                    }
                }
                .padding(.vertical, GreensheetTheme.spacingLarge)
            }
            
            // Action Buttons
            VStack(spacing: GreensheetTheme.spacingMedium) {
                Button("Save Round") {
                    appState.navigateTo(.homeDashboard)
                }
                .buttonStyle(GreensheetTheme.primaryButtonStyle)
                
                Button("Play Another Round") {
                    appState.navigateTo(.courseSelection)
                }
                .buttonStyle(GreensheetTheme.secondaryButtonStyle)
            }
            .padding(.horizontal, GreensheetTheme.spacingLarge)
        }
        .background(GreensheetTheme.backgroundPrimary)
    }
    
    private let sampleScoreDistribution = [
        ScoreDistribution(score: "Eagles", count: 0, color: GreensheetTheme.eagle),
        ScoreDistribution(score: "Birdies", count: 2, color: GreensheetTheme.birdie),
        ScoreDistribution(score: "Pars", count: 8, color: GreensheetTheme.par),
        ScoreDistribution(score: "Bogeys", count: 6, color: GreensheetTheme.bogey),
        ScoreDistribution(score: "Double Bogeys+", count: 2, color: GreensheetTheme.bogey)
    ]
}

struct ScoreBreakdownCard: View {
    let title: String
    let score: Int
    let par: Int
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingSmall) {
            Text(title)
                .font(GreensheetTheme.captionFont)
                .foregroundColor(GreensheetTheme.secondaryLabel)
            
            Text("\(score)")
                .font(.custom("HostGrotesk-Regular", size: 32))
                .fontWeight(.bold)
                .foregroundColor(GreensheetTheme.primaryGreen)
            
            Text("+\(score - par)")
                .font(GreensheetTheme.bodyFont)
                .foregroundColor(.scoreColor(for: score, par: par))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(GreensheetTheme.backgroundSecondary)
        .cornerRadius(GreensheetTheme.cornerRadiusMedium)
    }
}

struct RoundStatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingSmall) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(GreensheetTheme.primaryGreen)
            
            Text(value)
                .font(GreensheetTheme.bodyFont)
                .fontWeight(.semibold)
                .foregroundColor(GreensheetTheme.label)
            
            Text(title)
                .font(GreensheetTheme.smallFont)
                .foregroundColor(GreensheetTheme.secondaryLabel)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(GreensheetTheme.backgroundSecondary)
        .cornerRadius(GreensheetTheme.cornerRadiusMedium)
    }
}

struct ScoreDistribution: Identifiable {
    let id = UUID()
    let score: String
    let count: Int
    let color: Color
}

struct ScoreDistributionRow: View {
    let item: ScoreDistribution
    
    var body: some View {
        HStack(spacing: GreensheetTheme.spacingMedium) {
            Circle()
                .fill(item.color)
                .frame(width: 12, height: 12)
            
            Text(item.score)
                .font(GreensheetTheme.bodyFont)
                .foregroundColor(GreensheetTheme.label)
            
            Spacer()
            
            Text("\(item.count)")
                .font(GreensheetTheme.bodyFont)
                .fontWeight(.semibold)
                .foregroundColor(GreensheetTheme.label)
        }
        .padding()
    }
}

#Preview {
    RoundSummaryScreen()
        .environmentObject(AppState())
}

// MARK: - Sample Data
let sampleTeeOptions = [
    SampleTeeOption(name: "White", distance: 72, color: .white),
    SampleTeeOption(name: "Blue", distance: 74, color: .blue),
    SampleTeeOption(name: "Gold", distance: 70, color: .yellow),
    SampleTeeOption(name: "Red", distance: 68, color: .red)
]
let sampleHolePar = [4, 3, 4, 5, 4, 3, 4, 4, 4, 4, 3, 4, 5, 4, 3, 4, 4, 4]
let sampleHoleYardage = [380, 175, 395, 520, 410, 185, 400, 420, 390, 405, 165, 395, 535, 415, 170, 400, 425, 395]
let sampleHoleHandicap = [7, 15, 11, 1, 9, 17, 13, 5, 3, 8, 18, 12, 2, 10, 16, 14, 6, 4]
let sampleHoleDescriptions = [
    "A challenging opening hole with a slight dogleg right. The fairway is narrow and requires accuracy off the tee.",
    "A short but tricky par 3 with a small green protected by bunkers on both sides.",
    "A straight par 4 with a wide fairway but challenging approach to a well-bunkered green.",
    "A long par 5 that offers a chance for eagle with two good shots. The green is large and receptive.",
    "A medium-length par 4 with a narrow landing area. The approach shot requires precision.",
    "A short par 3 with a large green but challenging pin positions.",
    "A straightforward par 4 with a wide fairway and accessible green.",
    "A long par 5 with multiple risk-reward options. The green is well-protected.",
    "A medium par 4 with a slight dogleg left. The approach shot is key to scoring well.",
    "A solid par 4 with a wide fairway and large green. Good scoring opportunity.",
    "A short par 3 with a small, well-bunkered green. Accuracy is crucial.",
    "A medium-length par 4 with a narrow fairway and challenging approach.",
    "A long par 5 with a wide fairway but challenging green complex.",
    "A straightforward par 4 with good scoring potential.",
    "A short par 3 with a large green and accessible pin positions.",
    "A medium par 4 with a slight dogleg and well-protected green.",
    "A solid par 4 with a wide fairway and large green.",
    "A challenging finishing hole with a narrow fairway and well-bunkered green."
]

