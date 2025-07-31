//
//  Color+Extensions.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

extension Color {
    // MARK: - Golf Score Colors
    
    static let eagleScore = Color(red: 212/255, green: 168/255, blue: 83/255)
    static let birdieScore = Color(red: 74/255, green: 123/255, blue: 167/255)
    static let parScore = Color(red: 107/255, green: 142/255, blue: 107/255)
    static let bogeyScore = Color(red: 197/255, green: 90/255, blue: 90/255)
    static let doubleBogeyScore = Color(red: 139/255, green: 69/255, blue: 19/255)
    
    // MARK: - Helper Methods
    
    /// Returns the appropriate score color based on strokes vs par
    static func scoreColor(strokes: Int, par: Int) -> Color {
        let difference = strokes - par
        
        switch difference {
        case ..<(-1):
            return .eagleScore
        case -1:
            return .birdieScore
        case 0:
            return .parScore
        case 1:
            return .bogeyScore
        default:
            return .doubleBogeyScore
        }
    }
} 