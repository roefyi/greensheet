//
//  AccountSetupScreen.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

struct AccountSetupScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var playerName = ""
    @State private var selectedHandicap = ""
    
    private let handicapOptions = [
        ("", "I don't know"),
        ("0-5", "0-5"),
        ("6-10", "6-10"),
        ("11-15", "11-15"),
        ("16-20", "16-20"),
        ("21+", "21+")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: {
                    appState.goBack()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(GreensheetTheme.primaryGreen)
                }
                
                Spacer()
                
                Text("Create Your Profile")
                    .font(GreensheetTheme.headlineFont)
                    .fontWeight(.semibold)
                    .foregroundColor(GreensheetTheme.label)
                
                Spacer()
                
                // Invisible spacer to center the title
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .opacity(0)
            }
            .padding(.horizontal, GreensheetTheme.spacingLarge)
            .padding(.top, GreensheetTheme.spacingMedium)
            
            // Form Content
            VStack(spacing: GreensheetTheme.spacingLarge) {
                // Name Field
                VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                    Text("Name")
                        .font(GreensheetTheme.captionFont)
                        .fontWeight(.medium)
                        .foregroundColor(GreensheetTheme.label)
                    
                    TextField("Enter your name", text: $playerName)
                        .font(GreensheetTheme.bodyFont)
                        .padding()
                        .background(GreensheetTheme.backgroundSecondary)
                        .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                        .overlay(
                            RoundedRectangle(cornerRadius: GreensheetTheme.cornerRadiusMedium)
                                .stroke(GreensheetTheme.systemGray4, lineWidth: 1)
                        )
                }
                
                // Handicap Field
                VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                    Text("Approximate Handicap")
                        .font(GreensheetTheme.captionFont)
                        .fontWeight(.medium)
                        .foregroundColor(GreensheetTheme.label)
                    
                    Menu {
                        ForEach(handicapOptions, id: \.0) { option in
                            Button(option.1) {
                                selectedHandicap = option.0
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedHandicap.isEmpty ? "I don't know" : handicapOptions.first { $0.0 == selectedHandicap }?.1 ?? "I don't know")
                                .font(GreensheetTheme.bodyFont)
                                .foregroundColor(selectedHandicap.isEmpty ? GreensheetTheme.tertiaryLabel : GreensheetTheme.label)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .font(.caption)
                                .foregroundColor(GreensheetTheme.secondaryLabel)
                        }
                        .padding()
                        .background(GreensheetTheme.backgroundSecondary)
                        .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                        .overlay(
                            RoundedRectangle(cornerRadius: GreensheetTheme.cornerRadiusMedium)
                                .stroke(GreensheetTheme.systemGray4, lineWidth: 1)
                        )
                    }
                }
                
                // iCloud Notice
                VStack(spacing: GreensheetTheme.spacingSmall) {
                    HStack {
                        Image(systemName: "icloud")
                            .font(.caption)
                            .foregroundColor(GreensheetTheme.primaryGreen)
                        
                        Text("Your data will sync across devices using iCloud")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                    }
                    .padding()
                    .background(GreensheetTheme.primaryGreen.opacity(0.1))
                    .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                }
                
                Spacer()
                
                // Continue Button
                Button(action: {
                    appState.navigateTo(.locationPermission)
                }) {
                    Text("Continue")
                        .font(GreensheetTheme.captionFont)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(GreensheetTheme.primaryGreen)
                        .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                }
            }
            .padding(.horizontal, GreensheetTheme.spacingLarge)
            .padding(.top, GreensheetTheme.spacingLarge)
        }
        .background(GreensheetTheme.backgroundPrimary)
        .navigationBarHidden(true)
    }
}

#Preview {
    AccountSetupScreen()
        .environmentObject(AppState())
} 