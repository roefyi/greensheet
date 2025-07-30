//
//  FeatureOverviewScreen.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

struct FeatureOverviewScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var currentSlide = 0
    
    private let slides = [
        FeatureSlide(
            icon: "TRACK",
            title: "Track Every Round",
            description: "Keep detailed scorecards and watch your game improve over time"
        ),
        FeatureSlide(
            icon: "CALCULATE",
            title: "Calculate Handicap",
            description: "Automatic USGA handicap calculation as you play more rounds"
        ),
        FeatureSlide(
            icon: "FIND",
            title: "Find Courses",
            description: "Discover golf courses near you and save your favorites"
        )
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Feature Slides
            VStack(spacing: GreensheetTheme.spacingXLarge) {
                // Current Slide
                VStack(spacing: GreensheetTheme.spacingLarge) {
                    // Icon
                    Text(slides[currentSlide].icon)
                        .font(.custom("HostGrotesk-Regular", size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(GreensheetTheme.primaryGreen)
                        .padding()
                        .background(
                            Circle()
                                .fill(GreensheetTheme.primaryGreen.opacity(0.1))
                                .frame(width: 80, height: 80)
                        )
                    
                    // Title
                    Text(slides[currentSlide].title)
                        .font(.custom("HostGrotesk-Regular", size: 24))
                        .fontWeight(.semibold)
                        .foregroundColor(GreensheetTheme.label)
                        .multilineTextAlignment(.center)
                    
                    // Description
                    Text(slides[currentSlide].description)
                        .font(GreensheetTheme.bodyFont)
                        .foregroundColor(GreensheetTheme.secondaryLabel)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                }
                
                // Dots Navigation
                HStack(spacing: GreensheetTheme.spacingSmall) {
                    ForEach(0..<slides.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentSlide ? GreensheetTheme.primaryGreen : GreensheetTheme.systemGray4)
                            .frame(width: 8, height: 8)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    currentSlide = index
                                }
                            }
                    }
                }
                
                Spacer()
                    .frame(height: GreensheetTheme.spacingXLarge)
                
                // Continue Button
                Button(action: {
                    appState.navigateTo(.accountSetup)
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
                .padding(.horizontal, GreensheetTheme.spacingLarge)
            }
            .padding(.horizontal, GreensheetTheme.spacingLarge)
            
            Spacer()
        }
        .background(GreensheetTheme.backgroundPrimary)
        .navigationBarHidden(true)
        .onAppear {
            startAutoSlide()
        }
    }
    
    private func startAutoSlide() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.3)) {
                currentSlide = (currentSlide + 1) % slides.count
            }
        }
    }
}

struct FeatureSlide {
    let icon: String
    let title: String
    let description: String
}

#Preview {
    FeatureOverviewScreen()
        .environmentObject(AppState())
} 