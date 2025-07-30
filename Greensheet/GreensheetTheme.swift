//
//  GreensheetTheme.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

struct GreensheetTheme {
    // MARK: - Colors (matching HTML color scheme)
    
    // Primary Green Colors
    static let primaryGreen = Color(red: 49/255, green: 87/255, blue: 44/255) // #31572c
    static let darkGreen = Color(red: 19/255, green: 42/255, blue: 19/255) // #132a13
    static let lightGreen = Color(red: 74/255, green: 124/255, blue: 89/255) // #4a7c59
    
    // iOS System Colors
    static let systemWhite = Color.white // #ffffff
    static let systemGray6 = Color(red: 242/255, green: 242/255, blue: 247/255) // #f2f2f7
    static let systemGray5 = Color(red: 229/255, green: 229/255, blue: 234/255) // #e5e5ea
    static let systemGray4 = Color(red: 209/255, green: 209/255, blue: 214/255) // #d1d1d6
    static let systemGray3 = Color(red: 199/255, green: 199/255, blue: 204/255) // #c7c7cc
    static let systemGray2 = Color(red: 174/255, green: 174/255, blue: 178/255) // #aeaeb2
    static let systemGray = Color(red: 142/255, green: 142/255, blue: 147/255) // #8e8e93
    
    // iOS Labels
    static let label = Color.black // #000000
    static let secondaryLabel = Color(red: 60/255, green: 60/255, blue: 67/255) // #3c3c43
    static let tertiaryLabel = Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.6) // #3c3c4399
    static let quaternaryLabel = Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.18) // #3c3c432e
    
    // Golf Score Colors
    static let eagle = Color(red: 212/255, green: 168/255, blue: 83/255) // #d4a853
    static let birdie = Color(red: 74/255, green: 123/255, blue: 167/255) // #4a7ba7
    static let par = Color(red: 107/255, green: 142/255, blue: 107/255) // #6b8e6b
    static let bogey = Color(red: 197/255, green: 90/255, blue: 90/255) // #c55a5a
    
    // Semantic Colors
    static let backgroundPrimary = Color.white // #ffffff
    static let backgroundSecondary = Color(red: 242/255, green: 242/255, blue: 247/255) // #f2f2f7
    static let backgroundTertiary = Color(red: 229/255, green: 229/255, blue: 234/255) // #e5e5ea
    static let separator = Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.29) // #3c3c4349
    
    // MARK: - Typography (using Host Grotesk)
    static let titleFont = Font.custom("HostGrotesk-Regular", size: 28)
    static let headlineFont = Font.custom("HostGrotesk-Regular", size: 20)
    static let bodyFont = Font.custom("HostGrotesk-Regular", size: 16)
    static let captionFont = Font.custom("HostGrotesk-Regular", size: 14)
    static let smallFont = Font.custom("HostGrotesk-Regular", size: 12)
    
    // MARK: - Spacing
    static let spacingSmall: CGFloat = 8
    static let spacingMedium: CGFloat = 16
    static let spacingLarge: CGFloat = 24
    static let spacingXLarge: CGFloat = 32
    
    // MARK: - Corner Radius
    static let cornerRadiusSmall: CGFloat = 8
    static let cornerRadiusMedium: CGFloat = 12
    static let cornerRadiusLarge: CGFloat = 16
    
    // MARK: - Button Styles
    static let primaryButtonStyle = PrimaryButtonStyle()
    static let secondaryButtonStyle = SecondaryButtonStyle()
    static let dangerButtonStyle = DangerButtonStyle()
}

// MARK: - Button Styles
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(GreensheetTheme.captionFont)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(GreensheetTheme.primaryGreen)
            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(GreensheetTheme.captionFont)
            .fontWeight(.medium)
            .foregroundColor(GreensheetTheme.primaryGreen)
            .frame(maxWidth: .infinity)
            .padding()
            .background(GreensheetTheme.backgroundSecondary)
            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct DangerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(GreensheetTheme.captionFont)
            .fontWeight(.medium)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(GreensheetTheme.bogey)
            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Card Style
struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(GreensheetTheme.backgroundSecondary)
            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }
}

// MARK: - Score Color Extension
extension Color {
    static func scoreColor(for score: Int, par: Int) -> Color {
        let difference = score - par
        switch difference {
        case ..<(-1):
            return GreensheetTheme.eagle
        case -1:
            return GreensheetTheme.birdie
        case 0:
            return GreensheetTheme.par
        case 1:
            return GreensheetTheme.bogey
        default:
            return GreensheetTheme.bogey
        }
    }
} 