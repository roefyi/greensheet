//
//  WelcomeScreen.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

struct WelcomeScreen: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Logo and Welcome Content
            VStack(spacing: GreensheetTheme.spacingLarge) {
                // Logo
                VStack(spacing: GreensheetTheme.spacingMedium) {
                    // App Icon
                    Image("Frame 5") // Using the app icon from assets
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .background(
                            Circle()
                                .fill(GreensheetTheme.primaryGreen.opacity(0.1))
                                .frame(width: 100, height: 100)
                        )
                    
                    // App Name
                    Text("Greensheet")
                        .font(.custom("HostGrotesk-Regular", size: 32))
                        .fontWeight(.bold)
                        .foregroundColor(GreensheetTheme.label)
                    
                    // Tagline
                    Text("Track your golf journey")
                        .font(GreensheetTheme.bodyFont)
                        .foregroundColor(GreensheetTheme.secondaryLabel)
                }
                
                Spacer()
                    .frame(height: GreensheetTheme.spacingXLarge)
                
                // Welcome Buttons
                VStack(spacing: GreensheetTheme.spacingMedium) {
                    Button(action: {
                        appState.navigateTo(.featureOverview)
                    }) {
                        Text("Get Started")
                            .font(GreensheetTheme.captionFont)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(GreensheetTheme.primaryGreen)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                    }
                    
                    Button(action: {
                        // Handle returning user
                        appState.navigateTo(.homeDashboard)
                    }) {
                        Text("I'm returning")
                            .font(GreensheetTheme.captionFont)
                            .fontWeight(.medium)
                            .foregroundColor(GreensheetTheme.primaryGreen)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                    }
                }
            }
            .padding(.horizontal, GreensheetTheme.spacingLarge)
            
            Spacer()
        }
        .background(GreensheetTheme.backgroundPrimary)
        .navigationBarHidden(true)
    }
}

#Preview {
    WelcomeScreen()
        .environmentObject(AppState())
} 