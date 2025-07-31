//
//  ScorecardScreen.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

// MARK: - Direction State Enum
enum DirectionState: CaseIterable {
    case none, left, hit, right
}

// MARK: - Scorecard Screen
struct ScorecardScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var currentHole = 1
    @State private var strokes = 0
    @State private var putts = 0
    @State private var fairwayDirection: DirectionState = .none
    @State private var girDirection: DirectionState = .none
    @State private var hazards: [String] = []
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            headerView
            
            // Main Content
            TabView(selection: $selectedTab) {
                // Score Tab
                scoreTabView
                    .tag(0)
                
                // Stats Tab
                statsTabView
                    .tag(1)
                
                // Summary Tab
                summaryTabView
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            // Custom Tab Bar
            customTabBar
        }
        .background(GreensheetTheme.backgroundPrimary)
    }
    
    // MARK: - Header View
    private var headerView: some View {
        HStack {
            Button(action: {
                appState.currentScreen = .preRoundSetup
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(GreensheetTheme.label)
            }
            
            Spacer()
            
            Text("Hole \(currentHole)")
                .font(GreensheetTheme.headlineFont)
                .fontWeight(.semibold)
                .foregroundColor(GreensheetTheme.label)
            
            Spacer()
            
            Button("MENU") {
                // Show scorecard menu
            }
            .font(GreensheetTheme.captionFont)
            .fontWeight(.medium)
            .foregroundColor(GreensheetTheme.primaryGreen)
        }
        .padding(.horizontal, GreensheetTheme.spacingLarge)
        .padding(.vertical, GreensheetTheme.spacingMedium)
        .background(GreensheetTheme.backgroundPrimary)
    }
    
    // MARK: - Score Tab View
    private var scoreTabView: some View {
        ScrollView {
            VStack(spacing: GreensheetTheme.spacingLarge) {
                holeInfoSection
                holeInputCard
                runningTotalsSection
                holeNavigationSection
            }
            .padding(.vertical, GreensheetTheme.spacingLarge)
        }
    }
    
    // MARK: - Stats Tab View
    private var statsTabView: some View {
        ScrollView {
            VStack(spacing: GreensheetTheme.spacingLarge) {
                Text("Statistics")
                    .font(GreensheetTheme.headlineFont)
                    .fontWeight(.semibold)
                    .foregroundColor(GreensheetTheme.label)
                
                // Placeholder for stats content
                RoundedRectangle(cornerRadius: GreensheetTheme.cornerRadiusMedium)
                    .fill(GreensheetTheme.backgroundSecondary)
                    .frame(height: 200)
                    .overlay(
                        Text("Stats coming soon...")
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                    )
            }
            .padding(.vertical, GreensheetTheme.spacingLarge)
        }
    }
    
    // MARK: - Summary Tab View
    private var summaryTabView: some View {
        ScrollView {
            VStack(spacing: GreensheetTheme.spacingLarge) {
                Text("Round Summary")
                    .font(GreensheetTheme.headlineFont)
                    .fontWeight(.semibold)
                    .foregroundColor(GreensheetTheme.label)
                
                // Placeholder for summary content
                RoundedRectangle(cornerRadius: GreensheetTheme.cornerRadiusMedium)
                    .fill(GreensheetTheme.backgroundSecondary)
                    .frame(height: 200)
                    .overlay(
                        Text("Summary coming soon...")
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                    )
            }
            .padding(.vertical, GreensheetTheme.spacingLarge)
        }
    }
    
    // MARK: - Hole Info Section
    private var holeInfoSection: some View {
        HStack(spacing: GreensheetTheme.spacingMedium) {
            // Hole Number
            Text("\(currentHole)")
                .font(.custom("HostGrotesk-Regular", size: 48))
                .fontWeight(.bold)
                .foregroundColor(GreensheetTheme.primaryGreen)
                .frame(width: 80)
            
            // Hole Details
            VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                Text("PAR 4")
                    .font(GreensheetTheme.bodyFont)
                    .fontWeight(.semibold)
                    .foregroundColor(GreensheetTheme.label)
                
                Rectangle()
                    .fill(GreensheetTheme.separator)
                    .frame(height: 1)
                
                HStack(spacing: GreensheetTheme.spacingSmall) {
                    Circle()
                        .fill(GreensheetTheme.primaryGreen)
                        .frame(width: 12, height: 12)
                    Text("420y")
                        .font(GreensheetTheme.captionFont)
                        .foregroundColor(GreensheetTheme.secondaryLabel)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, GreensheetTheme.spacingLarge)
    }
    
    // MARK: - Hole Input Card
    private var holeInputCard: some View {
        VStack(spacing: 0) {
            // Strokes Section
            HoleInputSection(
                label: "Strokes",
                value: strokes,
                onDecrease: { if strokes > 0 { strokes -= 1 } },
                onIncrease: { strokes += 1 },
                valueColor: GreensheetTheme.primaryGreen
            )
            
            Divider()
                .background(GreensheetTheme.separator)
            
            // Putts Section
            HoleInputSection(
                label: "Putts",
                value: putts,
                onDecrease: { if putts > 0 { putts -= 1 } },
                onIncrease: { putts += 1 },
                valueColor: GreensheetTheme.primaryGreen
            )
            
            Divider()
                .background(GreensheetTheme.separator)
            
            // Fairways Section
            HoleDirectionSection(
                label: "Fairways",
                selectedDirection: fairwayDirection,
                onLeft: { 
                    fairwayDirection = fairwayDirection == .left ? .none : .left 
                },
                onHit: { 
                    fairwayDirection = fairwayDirection == .hit ? .none : .hit 
                },
                onRight: { 
                    fairwayDirection = fairwayDirection == .right ? .none : .right 
                }
            )
            
            Divider()
                .background(GreensheetTheme.separator)
            
            // GIR Section
            HoleDirectionSection(
                label: "GIR",
                selectedDirection: girDirection,
                onLeft: { 
                    girDirection = girDirection == .left ? .none : .left 
                },
                onHit: { 
                    girDirection = girDirection == .hit ? .none : .hit 
                },
                onRight: { 
                    girDirection = girDirection == .right ? .none : .right 
                }
            )
            
            Divider()
                .background(GreensheetTheme.separator)
            
            // Hazards Section
            HoleHazardsSection(hazards: $hazards)
        }
        .background(GreensheetTheme.backgroundSecondary)
        .cornerRadius(GreensheetTheme.cornerRadiusMedium)
        .padding(.horizontal, GreensheetTheme.spacingLarge)
    }
    
    // MARK: - Running Totals Section
    private var runningTotalsSection: some View {
        HStack(spacing: GreensheetTheme.spacingLarge) {
            VStack(spacing: GreensheetTheme.spacingSmall) {
                Text("Front 9")
                    .font(GreensheetTheme.captionFont)
                    .foregroundColor(GreensheetTheme.secondaryLabel)
                Text("36")
                    .font(GreensheetTheme.bodyFont)
                    .fontWeight(.semibold)
                    .foregroundColor(GreensheetTheme.primaryGreen)
            }
            .frame(maxWidth: .infinity)
            
            VStack(spacing: GreensheetTheme.spacingSmall) {
                Text("Back 9")
                    .font(GreensheetTheme.captionFont)
                    .foregroundColor(GreensheetTheme.secondaryLabel)
                Text("--")
                    .font(GreensheetTheme.bodyFont)
                    .fontWeight(.semibold)
                    .foregroundColor(GreensheetTheme.secondaryLabel)
            }
            .frame(maxWidth: .infinity)
            
            VStack(spacing: GreensheetTheme.spacingSmall) {
                Text("Total")
                    .font(GreensheetTheme.captionFont)
                    .foregroundColor(GreensheetTheme.secondaryLabel)
                Text("36")
                    .font(GreensheetTheme.bodyFont)
                    .fontWeight(.semibold)
                    .foregroundColor(GreensheetTheme.primaryGreen)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(GreensheetTheme.backgroundSecondary)
        .cornerRadius(GreensheetTheme.cornerRadiusMedium)
        .padding(.horizontal, GreensheetTheme.spacingLarge)
    }
    
    // MARK: - Hole Navigation Section
    private var holeNavigationSection: some View {
        HStack(spacing: GreensheetTheme.spacingMedium) {
            Button(action: {
                if currentHole > 1 {
                    currentHole -= 1
                    resetHoleData()
                }
            }) {
                HStack(spacing: GreensheetTheme.spacingSmall) {
                    Text("←")
                        .font(GreensheetTheme.bodyFont)
                        .fontWeight(.semibold)
                    Text("Previous")
                        .font(GreensheetTheme.bodyFont)
                        .fontWeight(.semibold)
                }
                .foregroundColor(GreensheetTheme.primaryGreen)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(GreensheetTheme.backgroundSecondary)
                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
            }
            .disabled(currentHole == 1)
            
            Button(action: {
                if currentHole < 18 {
                    currentHole += 1
                    resetHoleData()
                }
            }) {
                HStack(spacing: GreensheetTheme.spacingSmall) {
                    Text("Next")
                        .font(GreensheetTheme.bodyFont)
                        .fontWeight(.semibold)
                    Text("→")
                        .font(GreensheetTheme.bodyFont)
                        .fontWeight(.semibold)
                }
                .foregroundColor(GreensheetTheme.primaryGreen)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(GreensheetTheme.backgroundSecondary)
                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
            }
            .disabled(currentHole == 18)
        }
        .padding(.horizontal, GreensheetTheme.spacingLarge)
    }
    
    // MARK: - Custom Tab Bar
    private var customTabBar: some View {
        HStack(spacing: 0) {
            ForEach(0..<3) { index in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selectedTab = index
                    }
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: tabIcon(for: index))
                            .font(.system(size: 20))
                            .foregroundColor(selectedTab == index ? GreensheetTheme.primaryGreen : GreensheetTheme.secondaryLabel)
                        
                        Text(tabTitle(for: index))
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(selectedTab == index ? GreensheetTheme.primaryGreen : GreensheetTheme.secondaryLabel)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
            }
        }
        .background(GreensheetTheme.backgroundSecondary)
        .overlay(
            Rectangle()
                .fill(GreensheetTheme.separator)
                .frame(height: 1),
            alignment: .top
        )
    }
    
    // MARK: - Helper Methods
    private func resetHoleData() {
        strokes = 0
        putts = 0
        fairwayDirection = .none
        girDirection = .none
        hazards = []
    }
    
    private func tabIcon(for index: Int) -> String {
        switch index {
        case 0: return "number.circle"
        case 1: return "chart.bar"
        case 2: return "list.bullet"
        default: return "circle"
        }
    }
    
    private func tabTitle(for index: Int) -> String {
        switch index {
        case 0: return "Score"
        case 1: return "Stats"
        case 2: return "Summary"
        default: return ""
        }
    }
}

// MARK: - Supporting Views

struct HoleInputSection: View {
    let label: String
    let value: Int
    let onDecrease: () -> Void
    let onIncrease: () -> Void
    let valueColor: Color
    
    var body: some View {
        HStack {
            Text(label)
                .font(GreensheetTheme.bodyFont)
                .fontWeight(.semibold)
                .foregroundColor(GreensheetTheme.label)
            
            Spacer()
            
            HStack(spacing: 12) {
                Button(action: onDecrease) {
                    Text("-")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(valueColor)
                        .frame(width: 44, height: 44)
                        .background(GreensheetTheme.backgroundTertiary)
                        .cornerRadius(22)
                }
                
                Button(action: {}) {
                    Text("\(value)")
                        .font(.custom("HostGrotesk-Regular", size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(valueColor)
                        .frame(width: 44, height: 44)
                        .background(GreensheetTheme.backgroundTertiary)
                        .cornerRadius(22)
                }
                .disabled(true)
                
                Button(action: onIncrease) {
                    Text("+")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(valueColor)
                        .frame(width: 44, height: 44)
                        .background(GreensheetTheme.backgroundTertiary)
                        .cornerRadius(22)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

struct HoleDirectionSection: View {
    let label: String
    let selectedDirection: DirectionState
    let onLeft: () -> Void
    let onHit: () -> Void
    let onRight: () -> Void
    
    var body: some View {
        HStack {
            Text(label)
                .font(GreensheetTheme.bodyFont)
                .fontWeight(.semibold)
                .foregroundColor(GreensheetTheme.label)
            
            Spacer()
            
            HStack(spacing: 12) {
                Button(action: onLeft) {
                    Text("↖")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(selectedDirection == .left ? .white : .black)
                        .frame(width: 44, height: 44)
                        .background(selectedDirection == .left ? GreensheetTheme.errorRed : GreensheetTheme.backgroundTertiary)
                        .overlay(
                            RoundedRectangle(cornerRadius: 22)
                                .stroke(selectedDirection == .left ? GreensheetTheme.errorRed : Color.clear, lineWidth: 2)
                        )
                        .cornerRadius(22)
                }
                
                Button(action: onHit) {
                    Circle()
                        .fill(selectedDirection == .hit ? GreensheetTheme.primaryGreen : GreensheetTheme.backgroundTertiary)
                        .frame(width: 44, height: 44)
                        .overlay(
                            Circle()
                                .stroke(selectedDirection == .hit ? Color.clear : GreensheetTheme.primaryGreen, lineWidth: 2)
                        )
                }
                
                Button(action: onRight) {
                    Text("↗")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(selectedDirection == .right ? .white : .black)
                        .frame(width: 44, height: 44)
                        .background(selectedDirection == .right ? GreensheetTheme.errorRed : GreensheetTheme.backgroundTertiary)
                        .overlay(
                            RoundedRectangle(cornerRadius: 22)
                                .stroke(selectedDirection == .right ? GreensheetTheme.errorRed : Color.clear, lineWidth: 2)
                        )
                        .cornerRadius(22)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

struct HoleHazardsSection: View {
    @Binding var hazards: [String]
    
    var body: some View {
        HStack {
            Text("Hazards")
                .font(GreensheetTheme.bodyFont)
                .fontWeight(.semibold)
                .foregroundColor(GreensheetTheme.label)
            
            Spacer()
            
            HStack(spacing: 12) {
                VStack(spacing: 4) {
                    Button(action: {
                        if hazards.contains("penalty") {
                            hazards.removeAll { $0 == "penalty" }
                        } else {
                            hazards.append("penalty")
                        }
                    }) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.title2)
                            .foregroundColor(hazards.contains("penalty") ? .white : GreensheetTheme.errorRed)
                            .frame(width: 44, height: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 22)
                                    .fill(hazards.contains("penalty") ? GreensheetTheme.errorRed : GreensheetTheme.backgroundTertiary)
                            )
                    }
                    Text("Penalty")
                        .font(.caption)
                        .foregroundColor(GreensheetTheme.label)
                }
                
                VStack(spacing: 4) {
                    Button(action: {
                        if hazards.contains("sand") {
                            hazards.removeAll { $0 == "sand" }
                        } else {
                            hazards.append("sand")
                        }
                    }) {
                        Image(systemName: "circle.fill")
                            .font(.title2)
                            .foregroundColor(hazards.contains("sand") ? .white : GreensheetTheme.warningYellow)
                            .frame(width: 44, height: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 22)
                                    .fill(hazards.contains("sand") ? GreensheetTheme.warningYellow : GreensheetTheme.backgroundTertiary)
                            )
                    }
                    Text("Sand")
                        .font(.caption)
                        .foregroundColor(GreensheetTheme.label)
                }
                
                VStack(spacing: 4) {
                    Button(action: {
                        if hazards.contains("water") {
                            hazards.removeAll { $0 == "water" }
                        } else {
                            hazards.append("water")
                        }
                    }) {
                        Image(systemName: "drop.fill")
                            .font(.title2)
                            .foregroundColor(hazards.contains("water") ? .white : GreensheetTheme.infoBlue)
                            .frame(width: 44, height: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 22)
                                    .fill(hazards.contains("water") ? GreensheetTheme.infoBlue : GreensheetTheme.backgroundTertiary)
                            )
                    }
                    Text("Water")
                        .font(.caption)
                        .foregroundColor(GreensheetTheme.label)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

#Preview {
    ScorecardScreen()
        .environmentObject(AppState())
} 