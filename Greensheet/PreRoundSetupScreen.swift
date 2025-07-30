//
//  PreRoundSetupScreen.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

struct PreRoundSetupScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedTee = CourseModel.TeeOptionModel(name: "White Tees", color: .white, yardages: Array(repeating: 400, count: 18))
    @State private var numberOfHoles = 18
    @State private var startingHole = 1
    @State private var roundDate = Date()
    @State private var roundType = RoundModel.RoundType.stroke
@State private var players = [PlayerModel.samplePlayer]
    @State private var showingTeeSelector = false
    @State private var showingStartingHoleSelector = false
    @State private var showingRoundTypeSelector = false
    @State private var showingAddPlayer = false
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingLarge) {
            // Header
            NavigationHeader(
                title: "Round Setup",
                showBackButton: true,
                backAction: { appState.goBack() }
            )
            
            // Setup Content
            ScrollView {
                VStack(spacing: GreensheetTheme.spacingLarge) {
                    // Course Display
                    VStack(spacing: GreensheetTheme.spacingSmall) {
                        Text("Pebble Beach Golf Links")
                            .font(GreensheetTheme.headlineFont)
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(GreensheetTheme.backgroundSecondary)
                    .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                    
                    // Holes & Tees
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                        Text("Holes & Tees")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(.secondary)
                        
                        HStack(spacing: GreensheetTheme.spacingMedium) {
                            // Tee Selector
                            Button(action: { showingTeeSelector = true }) {
                                HStack(spacing: GreensheetTheme.spacingSmall) {
                                    TeeColorDot(color: selectedTee.color)
                                    Text(selectedTee.name)
                                        .font(GreensheetTheme.bodyFont)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                                .background(GreensheetTheme.backgroundSecondary)
                                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            // Holes Selector
                            HStack(spacing: 0) {
                                Button(action: { numberOfHoles = 18 }) {
                                    Text("18")
                                        .font(GreensheetTheme.bodyFont)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(numberOfHoles == 18 ? GreensheetTheme.primaryGreen : GreensheetTheme.backgroundSecondary)
                                        .foregroundColor(numberOfHoles == 18 ? .white : .primary)
                                }
                                
                                Button(action: { numberOfHoles = 9 }) {
                                    Text("9")
                                        .font(GreensheetTheme.bodyFont)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(numberOfHoles == 9 ? GreensheetTheme.primaryGreen : GreensheetTheme.backgroundSecondary)
                                        .foregroundColor(numberOfHoles == 9 ? .white : .primary)
                                }
                            }
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                        }
                        
                        // Starting Hole
                        Button(action: { showingStartingHoleSelector = true }) {
                            HStack {
                                Text("Starting Hole \(startingHole)")
                                    .font(GreensheetTheme.bodyFont)
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    // Date & Time
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                        Text("Date & Time")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(.secondary)
                        
                        DatePicker("", selection: $roundDate, displayedComponents: [.date, .hourAndMinute])
                            .datePickerStyle(CompactDatePickerStyle())
                            .labelsHidden()
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                    }
                    
                    // Round Type
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                        Text("Round Type")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(.secondary)
                        
                        Button(action: { showingRoundTypeSelector = true }) {
                            HStack {
                                Text(roundType.rawValue)
                                    .font(GreensheetTheme.bodyFont)
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    // Players
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                        Text("Players")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(.secondary)
                        
                        VStack(spacing: GreensheetTheme.spacingSmall) {
                            ForEach(players, id: \.id) { player in
                                PlayerRow(player: player)
                            }
                        }
                        
                        Button(action: { showingAddPlayer = true }) {
                            HStack(spacing: GreensheetTheme.spacingMedium) {
                                Text("+")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text("Write-In a Player")
                                    .font(GreensheetTheme.bodyFont)
                            }
                            .foregroundColor(GreensheetTheme.primaryGreen)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(GreensheetTheme.primaryGreen.opacity(0.1))
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, GreensheetTheme.spacingLarge)
            }
            
            // Tee Off Button
            Button("Tee Off") {
                appState.navigateTo(.scorecard)
            }
            .buttonStyle(GreensheetTheme.primaryButtonStyle)
            .padding(.horizontal, GreensheetTheme.spacingLarge)
        }
        .background(GreensheetTheme.backgroundPrimary)
        .sheet(isPresented: $showingTeeSelector) {
            TeeSelectorView(selectedTee: $selectedTee)
        }
        .sheet(isPresented: $showingStartingHoleSelector) {
            StartingHoleSelectorView(startingHole: $startingHole)
        }
        .sheet(isPresented: $showingRoundTypeSelector) {
            RoundTypeSelectorView(roundType: $roundType)
        }
        .sheet(isPresented: $showingAddPlayer) {
            AddPlayerView(players: $players)
        }
    }
}

struct TeeColorDot: View {
    let color: CourseModel.TeeOptionModel.TeeColor
    
    var body: some View {
        Circle()
            .fill(teeColor)
            .frame(width: 16, height: 16)
    }
    
    private var teeColor: Color {
        switch color {
        case .white: return .white
        case .blue: return .blue
        case .red: return .red
        case .gold: return .yellow
        case .black: return .black
        }
    }
}

struct PlayerRow: View {
    let player: PlayerModel
    
    var body: some View {
        HStack(spacing: GreensheetTheme.spacingMedium) {
            VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                Text(player.name)
                    .font(GreensheetTheme.bodyFont)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                if let handicap = player.handicap {
                    Text("Handicap: \(handicap, specifier: "%.1f")")
                        .font(GreensheetTheme.captionFont)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(GreensheetTheme.backgroundSecondary)
        .cornerRadius(GreensheetTheme.cornerRadiusMedium)
    }
}

// Placeholder views for selectors
struct TeeSelectorView: View {
    @Binding var selectedTee: CourseModel.TeeOptionModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                ForEach(CourseModel.TeeOptionModel.TeeColor.allCases, id: \.self) { color in
                    Button(action: {
                        selectedTee = CourseModel.TeeOptionModel(name: "\(color.rawValue) Tees", color: color, yardages: Array(repeating: 400, count: 18))
                        dismiss()
                    }) {
                        HStack {
                            TeeColorDot(color: color)
                            Text("\(color.rawValue) Tees")
                        }
                    }
                }
            }
            .navigationTitle("Select Tees")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

struct StartingHoleSelectorView: View {
    @Binding var startingHole: Int
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: 10) {
                ForEach(1...18, id: \.self) { hole in
                    Button(action: {
                        startingHole = hole
                        dismiss()
                    }) {
                        Text("\(hole)")
                            .font(GreensheetTheme.bodyFont)
                            .frame(width: 50, height: 50)
                            .background(startingHole == hole ? GreensheetTheme.primaryGreen : GreensheetTheme.backgroundSecondary)
                            .foregroundColor(startingHole == hole ? .white : .primary)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                    }
                }
            }
            .padding()
            .navigationTitle("Select Starting Hole")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

struct RoundTypeSelectorView: View {
    @Binding var roundType: RoundModel.RoundType
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                ForEach(RoundModel.RoundType.allCases, id: \.self) { type in
                    Button(action: {
                        roundType = type
                        dismiss()
                    }) {
                        Text(type.rawValue)
                    }
                }
            }
            .navigationTitle("Select Round Type")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

struct AddPlayerView: View {
    @Binding var players: [PlayerModel]
    @State private var playerName = ""
    @State private var playerHandicap = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: GreensheetTheme.spacingLarge) {
                FormField(label: "Player Name", placeholder: "Enter player name", text: $playerName)
                FormField(label: "Handicap (optional)", placeholder: "e.g., 12", text: $playerHandicap)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Add Player")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        let handicap = Double(playerHandicap)
                        let newPlayer = PlayerModel(name: playerName, handicap: handicap)
                        players.append(newPlayer)
                        dismiss()
                    }
                    .disabled(playerName.isEmpty)
                }
            }
        }
    }
}

#Preview {
    PreRoundSetupScreen()
        .environmentObject(AppState())
} 