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
    @State private var currentStrokes = ""
    @State private var currentPutts = ""
    @State private var currentFairwayHit = false
    @State private var currentGreenInRegulation = false
    @State private var currentHazards = 0
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingLarge) {
            // Header
            HStack {
                Button("←") {
                    appState.goBack()
                }
                .font(.title2)
                .foregroundColor(GreensheetTheme.primaryGreen)
                
                Spacer()
                
                Text("Score")
                    .font(GreensheetTheme.headlineFont)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("MENU") {
                    // TODO: Show menu
                }
                .font(GreensheetTheme.captionFont)
                .foregroundColor(GreensheetTheme.primaryGreen)
            }
            .padding(.horizontal, GreensheetTheme.spacingLarge)
            
            // Hole Info
            HoleInfoView(currentHole: currentHole)
            
            // Score Input Card
            VStack(spacing: GreensheetTheme.spacingMedium) {
                Text("Score Input")
                    .font(GreensheetTheme.headlineFont)
                    .foregroundColor(GreensheetTheme.label)
                
                HStack(spacing: GreensheetTheme.spacingMedium) {
                    VStack(alignment: .leading) {
                        Text("Strokes")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                        TextField("0", text: $currentStrokes)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Putts")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                        TextField("0", text: $currentPutts)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                }
                
                HStack(spacing: GreensheetTheme.spacingMedium) {
                    Toggle("Fairway Hit", isOn: $currentFairwayHit)
                        .font(GreensheetTheme.captionFont)
                    
                    Toggle("GIR", isOn: $currentGreenInRegulation)
                        .font(GreensheetTheme.captionFont)
                }
            }
            .padding()
            .background(GreensheetTheme.backgroundSecondary)
            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
            .padding(.horizontal, GreensheetTheme.spacingLarge)
            
            Spacer()
            
            // Navigation Buttons
            HStack(spacing: GreensheetTheme.spacingMedium) {
                Button("← Previous") {
                    if currentHole > 1 {
                        currentHole -= 1
                    }
                }
                .font(GreensheetTheme.captionFont)
                .foregroundColor(GreensheetTheme.primaryGreen)
                .padding()
                .background(GreensheetTheme.backgroundSecondary)
                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                
                Spacer()
                
                Button("Next →") {
                    if currentHole < 18 {
                        currentHole += 1
                    }
                }
                .font(GreensheetTheme.captionFont)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
                .background(GreensheetTheme.primaryGreen)
                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
            }
            .padding(.horizontal, GreensheetTheme.spacingLarge)
        }
        .background(GreensheetTheme.backgroundPrimary)
    }
}

struct HoleInfoView: View {
    let currentHole: Int
    
    var body: some View {
        HStack(spacing: GreensheetTheme.spacingMedium) {
            // Hole Number
            Text("\(currentHole)")
                .font(.custom("HostGrotesk-Regular", size: 32))
                .foregroundColor(GreensheetTheme.primaryGreen)
                .frame(width: 60, height: 60)
                .background(GreensheetTheme.lightGreen.opacity(0.1))
                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
            
            // Hole Details
            VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                Text("PAR 4")
                    .font(GreensheetTheme.bodyFont)
                    .fontWeight(.semibold)
                
                Divider()
                    .frame(width: 40)
                
                HStack(spacing: GreensheetTheme.spacingSmall) {
                    Circle()
                        .fill(.white)
                        .frame(width: 8, height: 8)
                    Text("420y")
                        .font(GreensheetTheme.captionFont)
                        .foregroundColor(GreensheetTheme.secondaryLabel)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, GreensheetTheme.spacingLarge)
    }
}

#Preview {
    ScorecardScreen()
        .environmentObject(AppState())
} 