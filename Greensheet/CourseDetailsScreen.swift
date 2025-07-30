//
//  CourseDetailsScreen.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

struct CourseDetailsScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var courseName = ""
    @State private var coursePar = 72
    @State private var courseYardage = ""
    @State private var numberOfHoles = 18
    @State private var addHolesLater = false
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingLarge) {
            // Header
            NavigationHeader(
                title: "Course Information",
                showBackButton: true,
                backAction: { appState.goBack() }
            )
            
            // Form Content
            ScrollView {
                VStack(spacing: GreensheetTheme.spacingLarge) {
                    // Course Name
                    FormField(
                        label: "Course Name",
                        placeholder: "Enter course name",
                        text: $courseName
                    )
                    
                    // Total Par
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                        Text("Total Par")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(.secondary)
                        
                        Stepper(value: $coursePar, in: 54...90) {
                            Text("\(coursePar)")
                                .font(GreensheetTheme.bodyFont)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(GreensheetTheme.backgroundSecondary)
                                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                        }
                    }
                    
                    // Total Yardage
                    FormField(
                        label: "Total Yardage (optional)",
                        placeholder: "e.g., 7200",
                        text: $courseYardage
                    )
                    
                    // Number of Holes
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                        Text("Number of Holes")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(.secondary)
                        
                        Picker("Number of Holes", selection: $numberOfHoles) {
                            Text("18 holes").tag(18)
                            Text("9 holes").tag(9)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    // Add Holes Later Checkbox
                    Toggle("I'll add hole details later", isOn: $addHolesLater)
                        .font(GreensheetTheme.bodyFont)
                        .padding()
                        .background(GreensheetTheme.backgroundSecondary)
                        .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                }
                .padding(.horizontal, GreensheetTheme.spacingLarge)
            }
            
            // Save Button
            Button("Save Course") {
                appState.navigateTo(.homeDashboard)
            }
            .buttonStyle(GreensheetTheme.primaryButtonStyle)
            .padding(.horizontal, GreensheetTheme.spacingLarge)
        }
        .background(GreensheetTheme.backgroundPrimary)
    }
}

struct FormField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
            Text(label)
                .font(GreensheetTheme.captionFont)
                .foregroundColor(.secondary)
            
            TextField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(GreensheetTheme.bodyFont)
        }
    }
}

#Preview {
    CourseDetailsScreen()
        .environmentObject(AppState())
} 