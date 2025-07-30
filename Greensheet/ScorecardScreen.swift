//
//  ScorecardScreen.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

struct ScorecardScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var currentHole = 1
    @State private var strokes = 4
    @State private var putts = 2
    @State private var fairwayHit = true
    @State private var greenInRegulation = true
    @State private var hazards: [String] = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button("←") {
                        appState.currentScreen = .preRoundSetup
                    }
                    .font(.title2)
                    .foregroundColor(GreensheetTheme.primaryGreen)
                    
                    Text("Score")
                        .font(GreensheetTheme.titleFont)
                        .fontWeight(.bold)
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
                .padding(.top, GreensheetTheme.spacingLarge)
                
                ScrollView {
                    VStack(spacing: GreensheetTheme.spacingLarge) {
                        // Hole Info Compact
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
                        
                        // Hole Input Card
                        VStack(spacing: 0) {
                            // Strokes Section
                            VStack(spacing: GreensheetTheme.spacingMedium) {
                                Text("Strokes")
                                    .font(GreensheetTheme.bodyFont)
                                    .fontWeight(.semibold)
                                    .foregroundColor(GreensheetTheme.label)
                                
                                HStack(spacing: GreensheetTheme.spacingLarge) {
                                    Button(action: { if strokes > 1 { strokes -= 1 } }) {
                                        Text("-")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(GreensheetTheme.primaryGreen)
                                            .frame(width: 44, height: 44)
                                            .background(GreensheetTheme.backgroundTertiary)
                                            .cornerRadius(22)
                                    }
                                    
                                    Text("\(strokes)")
                                        .font(.custom("HostGrotesk-Regular", size: 32))
                                        .fontWeight(.bold)
                                        .foregroundColor(GreensheetTheme.primaryGreen)
                                        .frame(width: 80)
                                    
                                    Button(action: { strokes += 1 }) {
                                        Text("+")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(GreensheetTheme.primaryGreen)
                                            .frame(width: 44, height: 44)
                                            .background(GreensheetTheme.backgroundTertiary)
                                            .cornerRadius(22)
                                    }
                                }
                            }
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                            
                            Divider()
                                .background(GreensheetTheme.separator)
                            
                            // Putts Section
                            VStack(spacing: GreensheetTheme.spacingMedium) {
                                Text("Putts")
                                    .font(GreensheetTheme.bodyFont)
                                    .fontWeight(.semibold)
                                    .foregroundColor(GreensheetTheme.label)
                                
                                HStack(spacing: GreensheetTheme.spacingLarge) {
                                    Button(action: { if putts > 1 { putts -= 1 } }) {
                                        Text("-")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(GreensheetTheme.birdie)
                                            .frame(width: 44, height: 44)
                                            .background(GreensheetTheme.backgroundTertiary)
                                            .cornerRadius(22)
                                    }
                                    
                                    Text("\(putts)")
                                        .font(.custom("HostGrotesk-Regular", size: 32))
                                        .fontWeight(.bold)
                                        .foregroundColor(GreensheetTheme.birdie)
                                        .frame(width: 80)
                                    
                                    Button(action: { putts += 1 }) {
                                        Text("+")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(GreensheetTheme.birdie)
                                            .frame(width: 44, height: 44)
                                            .background(GreensheetTheme.backgroundTertiary)
                                            .cornerRadius(22)
                                    }
                                }
                            }
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                            
                            Divider()
                                .background(GreensheetTheme.separator)
                            
                            // Fairways Section
                            VStack(spacing: GreensheetTheme.spacingMedium) {
                                Text("Fairways")
                                    .font(GreensheetTheme.bodyFont)
                                    .fontWeight(.semibold)
                                    .foregroundColor(GreensheetTheme.label)
                                
                                HStack(spacing: GreensheetTheme.spacingLarge) {
                                    Button(action: { fairwayHit = false }) {
                                        Text("↖")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(fairwayHit ? GreensheetTheme.secondaryLabel : GreensheetTheme.bogey)
                                            .frame(width: 44, height: 44)
                                            .background(fairwayHit ? GreensheetTheme.backgroundTertiary : GreensheetTheme.bogey.opacity(0.1))
                                            .cornerRadius(22)
                                    }
                                    
                                    Button(action: { fairwayHit = true }) {
                                        Circle()
                                            .fill(fairwayHit ? GreensheetTheme.primaryGreen : GreensheetTheme.backgroundTertiary)
                                            .frame(width: 44, height: 44)
                                            .overlay(
                                                Circle()
                                                    .stroke(fairwayHit ? Color.clear : GreensheetTheme.secondaryLabel, lineWidth: 2)
                                            )
                                    }
                                    
                                    Button(action: { fairwayHit = false }) {
                                        Text("↗")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(fairwayHit ? GreensheetTheme.secondaryLabel : GreensheetTheme.bogey)
                                            .frame(width: 44, height: 44)
                                            .background(fairwayHit ? GreensheetTheme.backgroundTertiary : GreensheetTheme.bogey.opacity(0.1))
                                            .cornerRadius(22)
                                    }
                                }
                            }
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                            
                            Divider()
                                .background(GreensheetTheme.separator)
                            
                            // GIR Section
                            VStack(spacing: GreensheetTheme.spacingMedium) {
                                Text("GIR")
                                    .font(GreensheetTheme.bodyFont)
                                    .fontWeight(.semibold)
                                    .foregroundColor(GreensheetTheme.label)
                                
                                HStack(spacing: GreensheetTheme.spacingLarge) {
                                    Button(action: { greenInRegulation = false }) {
                                        Text("↖")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(greenInRegulation ? GreensheetTheme.secondaryLabel : GreensheetTheme.bogey)
                                            .frame(width: 44, height: 44)
                                            .background(greenInRegulation ? GreensheetTheme.backgroundTertiary : GreensheetTheme.bogey.opacity(0.1))
                                            .cornerRadius(22)
                                    }
                                    
                                    Button(action: { greenInRegulation = true }) {
                                        Circle()
                                            .fill(greenInRegulation ? GreensheetTheme.primaryGreen : GreensheetTheme.backgroundTertiary)
                                            .frame(width: 44, height: 44)
                                            .overlay(
                                                Circle()
                                                    .stroke(greenInRegulation ? Color.clear : GreensheetTheme.secondaryLabel, lineWidth: 2)
                                            )
                                    }
                                    
                                    Button(action: { greenInRegulation = false }) {
                                        Text("↗")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(greenInRegulation ? GreensheetTheme.secondaryLabel : GreensheetTheme.bogey)
                                            .frame(width: 44, height: 44)
                                            .background(greenInRegulation ? GreensheetTheme.backgroundTertiary : GreensheetTheme.bogey.opacity(0.1))
                                            .cornerRadius(22)
                                    }
                                }
                            }
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                            
                            Divider()
                                .background(GreensheetTheme.separator)
                            
                            // Hazards Section
                            VStack(spacing: GreensheetTheme.spacingMedium) {
                                Text("Hazards")
                                    .font(GreensheetTheme.bodyFont)
                                    .fontWeight(.semibold)
                                    .foregroundColor(GreensheetTheme.label)
                                
                                HStack(spacing: GreensheetTheme.spacingMedium) {
                                    HazardButton(
                                        title: "Penalty",
                                        icon: "!",
                                        isSelected: hazards.contains("penalty"),
                                        action: {
                                            if hazards.contains("penalty") {
                                                hazards.removeAll { $0 == "penalty" }
                                            } else {
                                                hazards.append("penalty")
                                            }
                                        }
                                    )
                                    
                                    HazardButton(
                                        title: "Sand",
                                        icon: "○",
                                        isSelected: hazards.contains("sand"),
                                        action: {
                                            if hazards.contains("sand") {
                                                hazards.removeAll { $0 == "sand" }
                                            } else {
                                                hazards.append("sand")
                                            }
                                        }
                                    )
                                    
                                    HazardButton(
                                        title: "Water",
                                        icon: "~",
                                        isSelected: hazards.contains("water"),
                                        action: {
                                            if hazards.contains("water") {
                                                hazards.removeAll { $0 == "water" }
                                            } else {
                                                hazards.append("water")
                                            }
                                        }
                                    )
                                }
                            }
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                        }
                        .background(GreensheetTheme.backgroundSecondary)
                        .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        // Running Totals
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
                        .padding()
                        .background(GreensheetTheme.backgroundSecondary)
                        .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        // Hole Navigation
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
                                .padding()
                                .background(GreensheetTheme.backgroundSecondary)
                                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                            }
                            .disabled(currentHole == 1)
                            
                            Button(action: {
                                if currentHole < 18 {
                                    currentHole += 1
                                    resetHoleData()
                                } else {
                                    // Complete round
                                    appState.currentScreen = .roundSummary
                                }
                            }) {
                                HStack(spacing: GreensheetTheme.spacingSmall) {
                                    Text(currentHole == 18 ? "Finish" : "Next")
                                        .font(GreensheetTheme.bodyFont)
                                        .fontWeight(.semibold)
                                    if currentHole < 18 {
                                        Text("→")
                                            .font(GreensheetTheme.bodyFont)
                                            .fontWeight(.semibold)
                                    }
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(GreensheetTheme.primaryGreen)
                                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                            }
                        }
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                    }
                    .padding(.vertical, GreensheetTheme.spacingLarge)
                }
            }
            .background(GreensheetTheme.backgroundPrimary)
        }
    }
    
    private func resetHoleData() {
        strokes = 4
        putts = 2
        fairwayHit = true
        greenInRegulation = true
        hazards = []
    }
}

struct HazardButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: GreensheetTheme.spacingSmall) {
                Text(icon)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(isSelected ? .white : GreensheetTheme.secondaryLabel)
                Text(title)
                    .font(GreensheetTheme.smallFont)
                    .fontWeight(.medium)
                    .foregroundColor(isSelected ? .white : GreensheetTheme.secondaryLabel)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, GreensheetTheme.spacingMedium)
            .background(isSelected ? GreensheetTheme.bogey : GreensheetTheme.backgroundTertiary)
            .cornerRadius(GreensheetTheme.cornerRadiusSmall)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ScorecardScreen()
        .environmentObject(AppState())
} 