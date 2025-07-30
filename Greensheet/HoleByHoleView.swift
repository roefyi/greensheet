//
//  HoleByHoleView.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

struct HoleByHoleView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: {
                        appState.currentScreen = .roundDetails
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(GreensheetTheme.label)
                    }
                    
                    Spacer()
                    
                    Text("Hole by Hole")
                        .font(GreensheetTheme.headlineFont)
                        .foregroundColor(GreensheetTheme.label)
                    
                    Spacer()
                }
                .padding(.horizontal, GreensheetTheme.spacingLarge)
                .padding(.vertical, GreensheetTheme.spacingMedium)
                
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
    HoleByHoleView()
        .environmentObject(AppState())
} 