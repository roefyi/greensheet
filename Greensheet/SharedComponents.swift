//
//  SharedComponents.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

struct NavigationHeader: View {
    let title: String
    let showBackButton: Bool
    let backAction: (() -> Void)?
    
    init(title: String, showBackButton: Bool = true, backAction: (() -> Void)? = nil) {
        self.title = title
        self.showBackButton = showBackButton
        self.backAction = backAction
    }
    
    var body: some View {
        HStack {
            if showBackButton {
                Button(action: {
                    backAction?()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(GreensheetTheme.label)
                }
            }
            
            Spacer()
            
            Text(title)
                .font(GreensheetTheme.headlineFont)
                .foregroundColor(GreensheetTheme.label)
            
            Spacer()
            
            if showBackButton {
                // Invisible spacer to balance the back button
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.clear)
            }
        }
        .padding(.horizontal, GreensheetTheme.spacingLarge)
        .padding(.vertical, GreensheetTheme.spacingMedium)
        .background(GreensheetTheme.backgroundPrimary)
    }
}

 