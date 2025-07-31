//
//  View+Extensions.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

extension View {
    // MARK: - Layout Extensions
    
    func centerInParent() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func centerHorizontally() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
    
    // MARK: - Spacing Extensions
    
    func standardPadding() -> some View {
        self.padding(.horizontal, GreensheetTheme.spacingMedium)
            .padding(.vertical, GreensheetTheme.spacingSmall)
    }
    
    func horizontalPadding() -> some View {
        self.padding(.horizontal, GreensheetTheme.spacingMedium)
    }
    
    // MARK: - Corner Radius Extensions
    
    func standardCornerRadius() -> some View {
        self.cornerRadius(GreensheetTheme.cornerRadiusMedium)
    }
    
    func smallCornerRadius() -> some View {
        self.cornerRadius(GreensheetTheme.cornerRadiusSmall)
    }
    
    // MARK: - Shadow Extensions
    
    func subtleShadow() -> some View {
        self.shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    // MARK: - Background Extensions
    
    func standardBackground() -> some View {
        self.background(GreensheetTheme.backgroundPrimary)
    }
    
    func secondaryBackground() -> some View {
        self.background(GreensheetTheme.backgroundSecondary)
    }
    
    // MARK: - Typography Extensions
    
    func titleFont() -> some View {
        self.font(GreensheetTheme.titleFont)
    }
    
    func headlineFont() -> some View {
        self.font(GreensheetTheme.headlineFont)
    }
    
    func bodyFont() -> some View {
        self.font(GreensheetTheme.bodyFont)
    }
    
    func captionFont() -> some View {
        self.font(GreensheetTheme.captionFont)
    }
    
    func smallFont() -> some View {
        self.font(GreensheetTheme.smallFont)
    }
    
    // MARK: - Color Extensions
    
    func primaryGreenColor() -> some View {
        self.foregroundColor(GreensheetTheme.primaryGreen)
    }
    
    func labelColor() -> some View {
        self.foregroundColor(GreensheetTheme.label)
    }
    
    func secondaryLabelColor() -> some View {
        self.foregroundColor(GreensheetTheme.secondaryLabel)
    }
    
    // MARK: - Interactive Extensions
    
    func tappableWithHaptic() -> some View {
        self.onTapGesture {
            let impactFeedback = UIImpactFeedbackGenerator(style: .light)
            impactFeedback.impactOccurred()
        }
    }
    
    // MARK: - Accessibility Extensions
    
    func accessibilityLabel(_ label: String) -> some View {
        self.accessibilityLabel(Text(label))
    }
    
    func accessibleButton() -> some View {
        self.accessibilityAddTraits(.isButton)
    }
    
    // MARK: - Golf-Specific Extensions
    
    func golfCardStyle() -> some View {
        self
            .background(GreensheetTheme.backgroundPrimary)
            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            .padding(.horizontal, GreensheetTheme.spacingMedium)
            .padding(.vertical, GreensheetTheme.spacingSmall)
    }
    
    func scoreDisplayStyle() -> some View {
        self
            .font(GreensheetTheme.headlineFont)
            .fontWeight(.semibold)
            .padding(.horizontal, GreensheetTheme.spacingSmall)
            .padding(.vertical, GreensheetTheme.spacingXSmall)
            .background(GreensheetTheme.backgroundSecondary)
            .cornerRadius(GreensheetTheme.cornerRadiusSmall)
    }
} 