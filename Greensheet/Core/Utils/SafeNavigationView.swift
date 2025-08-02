//
//  SafeNavigationView.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

struct SafeNavigationView<Content: View>: View {
    let content: Content
    @State private var hasAppeared = false
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            content
                .onAppear {
                    // Ensure proper safe area calculation on initial load
                    if !hasAppeared {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            hasAppeared = true
                        }
                    }
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// Extension to make it easier to use
extension View {
    func safeNavigationView() -> some View {
        SafeNavigationView {
            self
        }
    }
} 