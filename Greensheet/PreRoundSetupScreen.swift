//
//  PreRoundSetupScreen.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

struct PreRoundSetupScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedTee = "White"
    @State private var numberOfHoles = 18
    @State private var startingHole = 1
    @State private var roundDate = Date()
    @State private var roundType = "Stroke Play"
    @State private var players = [PlayerSetupModel.samplePlayers[0]]
    @State private var showingTeeSelector = false
    @State private var showingStartingHoleSelector = false
    @State private var showingRoundTypeSelector = false
    @State private var showingAddPlayer = false
    @State private var weatherConditions = "Partly Cloudy"
    @State private var temperature = "72°F"
    @State private var windSpeed = "8 mph"
    
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
                            .foregroundColor(GreensheetTheme.label)
                        
                        Text("Par 72 • 7,075 yards")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(GreensheetTheme.backgroundSecondary)
                    .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                    .padding(.horizontal, GreensheetTheme.spacingLarge)
                    
                    // Holes & Tees
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                        Text("Holes & Tees")
                            .font(GreensheetTheme.headlineFont)
                            .fontWeight(.semibold)
                            .foregroundColor(GreensheetTheme.label)
                            .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        HStack(spacing: GreensheetTheme.spacingMedium) {
                            // Tee Selector
                            Button(action: { showingTeeSelector = true }) {
                                HStack(spacing: GreensheetTheme.spacingSmall) {
                                    Circle()
                                        .fill(Color(selectedTee.lowercased()))
                                        .frame(width: 20, height: 20)
                                    Text(selectedTee)
                                        .font(GreensheetTheme.bodyFont)
                                        .foregroundColor(GreensheetTheme.label)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .font(.caption)
                                        .foregroundColor(GreensheetTheme.secondaryLabel)
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
                                        .foregroundColor(numberOfHoles == 18 ? .white : GreensheetTheme.label)
                                }
                                
                                Button(action: { numberOfHoles = 9 }) {
                                    Text("9")
                                        .font(GreensheetTheme.bodyFont)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(numberOfHoles == 9 ? GreensheetTheme.primaryGreen : GreensheetTheme.backgroundSecondary)
                                        .foregroundColor(numberOfHoles == 9 ? .white : GreensheetTheme.label)
                                }
                            }
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                        }
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        // Starting Hole
                        Button(action: { showingStartingHoleSelector = true }) {
                            HStack {
                                Text("Starting Hole \(startingHole)")
                                    .font(GreensheetTheme.bodyFont)
                                    .foregroundColor(GreensheetTheme.label)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .font(.caption)
                                    .foregroundColor(GreensheetTheme.secondaryLabel)
                            }
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                    }
                    
                    // Round Type
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                        Text("Round Type")
                            .font(GreensheetTheme.headlineFont)
                            .fontWeight(.semibold)
                            .foregroundColor(GreensheetTheme.label)
                            .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        Button(action: { showingRoundTypeSelector = true }) {
                            HStack {
                                Text(roundType)
                                    .font(GreensheetTheme.bodyFont)
                                    .foregroundColor(GreensheetTheme.label)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .font(.caption)
                                    .foregroundColor(GreensheetTheme.secondaryLabel)
                            }
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                    }
                    
                    // Players
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                        HStack {
                            Text("Players")
                                .font(GreensheetTheme.headlineFont)
                                .fontWeight(.semibold)
                                .foregroundColor(GreensheetTheme.label)
                            
                            Spacer()
                            
                            Button(action: { showingAddPlayer = true }) {
                                Image(systemName: "plus.circle")
                                    .font(.title2)
                                    .foregroundColor(GreensheetTheme.primaryGreen)
                            }
                        }
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        VStack(spacing: 0) {
                            ForEach(players, id: \.id) { player in
                                PlayerSetupRow(player: player)
                                .padding(.vertical, GreensheetTheme.spacingSmall)
                                
                                if player.id != players.last?.id {
                                    Divider()
                                        .background(GreensheetTheme.separator)
                                        .padding(.leading, GreensheetTheme.spacingLarge)
                                }
                            }
                        }
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                    }
                    
                    // Weather Conditions
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                        Text("Weather Conditions")
                            .font(GreensheetTheme.headlineFont)
                            .fontWeight(.semibold)
                            .foregroundColor(GreensheetTheme.label)
                            .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        HStack(spacing: GreensheetTheme.spacingMedium) {
                            WeatherSetupCard(icon: "cloud.sun", label: "Conditions", value: weatherConditions, color: GreensheetTheme.primaryGreen)
                            WeatherSetupCard(icon: "thermometer", label: "Temperature", value: temperature, color: GreensheetTheme.primaryGreen)
                            WeatherSetupCard(icon: "wind", label: "Wind", value: windSpeed, color: GreensheetTheme.primaryGreen)
                        }
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                    }
                    
                    // Round Date
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                        Text("Round Date")
                            .font(GreensheetTheme.headlineFont)
                            .fontWeight(.semibold)
                            .foregroundColor(GreensheetTheme.label)
                            .padding(.horizontal, GreensheetTheme.spacingLarge)
                        
                        DatePicker("Round Date", selection: $roundDate, displayedComponents: [.date])
                            .datePickerStyle(CompactDatePickerStyle())
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
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
        .sheet(isPresented: $showingTeeSelector) {
            TeeSelectorSheet(selectedTee: $selectedTee)
        }
        .sheet(isPresented: $showingStartingHoleSelector) {
            StartingHoleSelectorSheet(startingHole: $startingHole)
        }
        .sheet(isPresented: $showingRoundTypeSelector) {
            RoundTypeSelectorSheet(roundType: $roundType)
        }
        .sheet(isPresented: $showingAddPlayer) {
            AddPlayerSheet(players: $players)
        }
    }
}

struct PlayerSetupModel: Identifiable {
    let id = UUID()
    let name: String
    let handicap: Double
    let isSelected: Bool
    let avatar: String
    let lastRound: String?
}

extension PlayerSetupModel {
    static let samplePlayers = [
        PlayerSetupModel(
            name: "John Smith",
            handicap: 12.4,
            isSelected: true,
            avatar: "person.circle.fill",
            lastRound: "78 at Pebble Beach"
        ),
        PlayerSetupModel(
            name: "Mike Johnson",
            handicap: 8.2,
            isSelected: false,
            avatar: "person.circle.fill",
            lastRound: "75 at Spyglass Hill"
        ),
        PlayerSetupModel(
            name: "David Wilson",
            handicap: 15.7,
            isSelected: false,
            avatar: "person.circle.fill",
            lastRound: "82 at Spanish Bay"
        ),
        PlayerSetupModel(
            name: "Tom Brown",
            handicap: 6.1,
            isSelected: false,
            avatar: "person.circle.fill",
            lastRound: "73 at Del Monte"
        ),
        PlayerSetupModel(
            name: "Sarah Davis",
            handicap: 18.3,
            isSelected: false,
            avatar: "person.circle.fill",
            lastRound: "85 at Pacific Grove"
        ),
        PlayerSetupModel(
            name: "Chris Lee",
            handicap: 3.8,
            isSelected: false,
            avatar: "person.circle.fill",
            lastRound: "71 at Bayonet"
        )
    ]
}

struct PlayerSetupRow: View {
    let player: PlayerSetupModel
    
    var body: some View {
        HStack(spacing: GreensheetTheme.spacingMedium) {
            // Player Avatar
            Image(systemName: player.avatar)
                .font(.title2)
                .foregroundColor(GreensheetTheme.primaryGreen)
                .frame(width: 40, height: 40)
                .background(GreensheetTheme.primaryGreen.opacity(0.1))
                .cornerRadius(GreensheetTheme.cornerRadiusSmall)
            
            // Player Info
            VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                Text(player.name)
                    .font(GreensheetTheme.bodyFont)
                    .fontWeight(.semibold)
                    .foregroundColor(GreensheetTheme.label)
                
                HStack(spacing: GreensheetTheme.spacingMedium) {
                    Text("Handicap: \(player.handicap, specifier: "%.1f")")
                        .font(GreensheetTheme.captionFont)
                        .foregroundColor(GreensheetTheme.secondaryLabel)
                    
                    if let lastRound = player.lastRound {
                        Text("•")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                        
                        Text(lastRound)
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                    }
                }
            }
            
            Spacer()
            
            // Selection Indicator
            if player.isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(GreensheetTheme.primaryGreen)
                    .font(.title2)
            } else {
                Image(systemName: "circle")
                    .foregroundColor(GreensheetTheme.tertiaryLabel)
                    .font(.title2)
            }
        }
        .padding()
    }
}

struct WeatherSetupCard: View {
    let icon: String
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingSmall) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
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
        .background(color.opacity(0.1))
        .cornerRadius(GreensheetTheme.cornerRadiusMedium)
    }
}

struct TeeSelectorSheet: View {
    @Binding var selectedTee: String
    @Environment(\.dismiss) private var dismiss
    
    private let teeOptions = ["Championship", "Blue", "White", "Gold", "Red"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: GreensheetTheme.spacingLarge) {
                Text("Select Tee Box")
                    .font(GreensheetTheme.headlineFont)
                    .fontWeight(.semibold)
                    .foregroundColor(GreensheetTheme.label)
                    .padding(.top, GreensheetTheme.spacingLarge)
                
                VStack(spacing: 0) {
                    ForEach(teeOptions, id: \.self) { tee in
                        Button(action: {
                            selectedTee = tee
                            dismiss()
                        }) {
                            HStack(spacing: GreensheetTheme.spacingMedium) {
                                Circle()
                                    .fill(Color(tee.lowercased()))
                                    .frame(width: 20, height: 20)
                                
                                Text(tee)
                                    .font(GreensheetTheme.bodyFont)
                                    .foregroundColor(GreensheetTheme.label)
                                
                                Spacer()
                                
                                if selectedTee == tee {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(GreensheetTheme.primaryGreen)
                                }
                            }
                            .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        if tee != teeOptions.last {
                            Divider()
                                .background(GreensheetTheme.separator)
                        }
                    }
                }
                .background(GreensheetTheme.backgroundSecondary)
                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                .padding(.horizontal, GreensheetTheme.spacingLarge)
                
                Spacer()
            }
            .background(GreensheetTheme.backgroundPrimary)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(GreensheetTheme.primaryGreen)
                }
            }
        }
    }
}

struct StartingHoleSelectorSheet: View {
    @Binding var startingHole: Int
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: GreensheetTheme.spacingLarge) {
                Text("Select Starting Hole")
                    .font(GreensheetTheme.headlineFont)
                    .fontWeight(.semibold)
                    .foregroundColor(GreensheetTheme.label)
                    .padding(.top, GreensheetTheme.spacingLarge)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: GreensheetTheme.spacingMedium) {
                    ForEach(1...18, id: \.self) { hole in
                        Button(action: {
                            startingHole = hole
                            dismiss()
                        }) {
                            Text("\(hole)")
                                .font(GreensheetTheme.bodyFont)
                                .fontWeight(.semibold)
                                .foregroundColor(startingHole == hole ? .white : GreensheetTheme.primaryGreen)
                                .frame(width: 50, height: 50)
                                .background(startingHole == hole ? GreensheetTheme.primaryGreen : GreensheetTheme.backgroundSecondary)
                                .cornerRadius(GreensheetTheme.cornerRadiusSmall)
                        }
                    }
                }
                .padding(.horizontal, GreensheetTheme.spacingLarge)
                
                Spacer()
            }
            .background(GreensheetTheme.backgroundPrimary)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(GreensheetTheme.primaryGreen)
                }
            }
        }
    }
}

struct RoundTypeSelectorSheet: View {
    @Binding var roundType: String
    @Environment(\.dismiss) private var dismiss
    
    private let roundTypes = ["Stroke Play", "Match Play", "Stableford", "Scramble", "Best Ball"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: GreensheetTheme.spacingLarge) {
                Text("Select Round Type")
                    .font(GreensheetTheme.headlineFont)
                    .fontWeight(.semibold)
                    .foregroundColor(GreensheetTheme.label)
                    .padding(.top, GreensheetTheme.spacingLarge)
                
                VStack(spacing: 0) {
                    ForEach(roundTypes, id: \.self) { type in
                        Button(action: {
                            roundType = type
                            dismiss()
                        }) {
                            HStack {
                                Text(type)
                                    .font(GreensheetTheme.bodyFont)
                                    .foregroundColor(GreensheetTheme.label)
                                
                                Spacer()
                                
                                if roundType == type {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(GreensheetTheme.primaryGreen)
                                }
                            }
                            .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        if type != roundTypes.last {
                            Divider()
                                .background(GreensheetTheme.separator)
                        }
                    }
                }
                .background(GreensheetTheme.backgroundSecondary)
                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                .padding(.horizontal, GreensheetTheme.spacingLarge)
                
                Spacer()
            }
            .background(GreensheetTheme.backgroundPrimary)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(GreensheetTheme.primaryGreen)
                }
            }
        }
    }
}

struct AddPlayerSheet: View {
    @Binding var players: [PlayerSetupModel]
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPlayers: Set<UUID> = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: GreensheetTheme.spacingLarge) {
                Text("Add Players")
                    .font(GreensheetTheme.headlineFont)
                    .fontWeight(.semibold)
                    .foregroundColor(GreensheetTheme.label)
                    .padding(.top, GreensheetTheme.spacingLarge)
                
                VStack(spacing: 0) {
                    ForEach(PlayerSetupModel.samplePlayers, id: \.id) { player in
                        Button(action: {
                            if selectedPlayers.contains(player.id) {
                                selectedPlayers.remove(player.id)
                            } else {
                                selectedPlayers.insert(player.id)
                            }
                        }) {
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
                                
                                if selectedPlayers.contains(player.id) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(GreensheetTheme.primaryGreen)
                                }
                            }
                            .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        if player.id != PlayerSetupModel.samplePlayers.last?.id {
                            Divider()
                                .background(GreensheetTheme.separator)
                        }
                    }
                }
                .background(GreensheetTheme.backgroundSecondary)
                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                .padding(.horizontal, GreensheetTheme.spacingLarge)
                
                Spacer()
                
                Button("Add Selected Players") {
                    let newPlayers = PlayerSetupModel.samplePlayers.filter { selectedPlayers.contains($0.id) }
                    players.append(contentsOf: newPlayers)
                    dismiss()
                }
                .buttonStyle(GreensheetTheme.primaryButtonStyle)
                .padding(.horizontal, GreensheetTheme.spacingLarge)
            }
            .background(GreensheetTheme.backgroundPrimary)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(GreensheetTheme.primaryGreen)
                }
            }
        }
    }
}

#Preview {
    PreRoundSetupScreen()
        .environmentObject(AppState())
} 