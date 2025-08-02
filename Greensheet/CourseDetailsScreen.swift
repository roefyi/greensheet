//
//  CourseDetailsScreen.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

struct CourseDetailsScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var courseName = "Pebble Beach Golf Links"
    @State private var coursePar = 72
    @State private var courseYardage = "7075"
    @State private var numberOfHoles = 18
    @State private var addHolesLater = false
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingLarge) {
            // Header
            NavigationHeader(
                title: "Course Information",
                showBackButton: true,
                backAction: { appState.goBack() }
            )
            
            // Tab Selector
            HStack(spacing: 0) {
                Button(action: { selectedTab = 0 }) {
                    Text("Course Info")
                        .font(GreensheetTheme.captionFont)
                        .fontWeight(.semibold)
                        .foregroundColor(selectedTab == 0 ? .white : GreensheetTheme.primaryGreen)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, GreensheetTheme.spacingSmall)
                        .background(selectedTab == 0 ? GreensheetTheme.primaryGreen : Color.clear)
                        .cornerRadius(GreensheetTheme.cornerRadiusSmall)
                }
                
                Button(action: { selectedTab = 1 }) {
                    Text("Hole Details")
                        .font(GreensheetTheme.captionFont)
                        .fontWeight(.semibold)
                        .foregroundColor(selectedTab == 1 ? .white : GreensheetTheme.primaryGreen)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, GreensheetTheme.spacingSmall)
                        .background(selectedTab == 1 ? GreensheetTheme.primaryGreen : Color.clear)
                        .cornerRadius(GreensheetTheme.cornerRadiusSmall)
                }
            }
            .padding(.horizontal, GreensheetTheme.spacingLarge)
            
            if selectedTab == 0 {
                CourseInfoTab()
            } else {
                HoleDetailsTab()
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

struct CourseInfoTab: View {
    @State private var courseName = "Pebble Beach Golf Links"
    @State private var coursePar = 72
    @State private var courseYardage = "7075"
    @State private var numberOfHoles = 18
    @State private var addHolesLater = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: GreensheetTheme.spacingLarge) {
                // Course Image Placeholder
                VStack(spacing: GreensheetTheme.spacingMedium) {
                    Image(systemName: "photo")
                        .font(.system(size: 60))
                        .foregroundColor(GreensheetTheme.primaryGreen)
                    
                    Text("Add Course Photo")
                        .font(GreensheetTheme.captionFont)
                        .foregroundColor(GreensheetTheme.secondaryLabel)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .background(GreensheetTheme.backgroundSecondary)
                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                .padding(.horizontal, GreensheetTheme.spacingLarge)
                
                // Course Name
                FormField(
                    label: "Course Name",
                    placeholder: "Enter course name",
                    text: $courseName
                )
                .padding(.horizontal, GreensheetTheme.spacingLarge)
                
                // Course Stats
                VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                    Text("Course Statistics")
                        .font(GreensheetTheme.headlineFont)
                        .fontWeight(.semibold)
                        .foregroundColor(GreensheetTheme.label)
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                    
                    HStack(spacing: GreensheetTheme.spacingMedium) {
                                        CourseDetailStatCard(title: "Total Par", value: "\(coursePar)", icon: "flag")
                CourseDetailStatCard(title: "Total Yardage", value: "\(courseYardage)y", icon: "location")
                CourseDetailStatCard(title: "Holes", value: "\(numberOfHoles)", icon: "circle")
                    }
                    .padding(.horizontal, GreensheetTheme.spacingLarge)
                }
                
                // Total Par
                VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                    Text("Total Par")
                        .font(GreensheetTheme.captionFont)
                        .foregroundColor(GreensheetTheme.secondaryLabel)
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                    
                    Stepper(value: $coursePar, in: 54...90) {
                        Text("\(coursePar)")
                            .font(GreensheetTheme.bodyFont)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                    }
                    .padding(.horizontal, GreensheetTheme.spacingLarge)
                }
                
                // Total Yardage
                FormField(
                    label: "Total Yardage (optional)",
                    placeholder: "e.g., 7200",
                    text: $courseYardage
                )
                .padding(.horizontal, GreensheetTheme.spacingLarge)
                
                // Number of Holes
                VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                    Text("Number of Holes")
                        .font(GreensheetTheme.captionFont)
                        .foregroundColor(GreensheetTheme.secondaryLabel)
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                    
                    Picker("Number of Holes", selection: $numberOfHoles) {
                        Text("18 holes").tag(18)
                        Text("9 holes").tag(9)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, GreensheetTheme.spacingLarge)
                }
                
                // Course Description
                VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                    Text("Course Description")
                        .font(GreensheetTheme.captionFont)
                        .foregroundColor(GreensheetTheme.secondaryLabel)
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                    
                    Text("Pebble Beach Golf Links is one of the most iconic golf courses in the world. Located on the stunning coastline of California's Monterey Peninsula, this legendary course has hosted numerous U.S. Open Championships and is known for its breathtaking ocean views and challenging holes.")
                        .font(GreensheetTheme.bodyFont)
                        .foregroundColor(GreensheetTheme.secondaryLabel)
                        .padding()
                        .background(GreensheetTheme.backgroundSecondary)
                        .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                }
                
                // Add Holes Later Checkbox
                Toggle("I'll add hole details later", isOn: $addHolesLater)
                    .font(GreensheetTheme.bodyFont)
                    .padding()
                    .background(GreensheetTheme.backgroundSecondary)
                    .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                    .padding(.horizontal, GreensheetTheme.spacingLarge)
            }
            .padding(.vertical, GreensheetTheme.spacingLarge)
        }
    }
}

struct HoleDetailsTab: View {
    @State private var selectedHole = 1
    
    var body: some View {
        ScrollView {
            VStack(spacing: GreensheetTheme.spacingLarge) {
                // Hole Selector
                HStack(spacing: GreensheetTheme.spacingSmall) {
                    ForEach(1...18, id: \.self) { hole in
                        Button(action: {
                            selectedHole = hole
                        }) {
                            Text("\(hole)")
                                .font(GreensheetTheme.captionFont)
                                .fontWeight(.semibold)
                                .foregroundColor(selectedHole == hole ? .white : GreensheetTheme.primaryGreen)
                                .frame(width: 35, height: 35)
                                .background(selectedHole == hole ? GreensheetTheme.primaryGreen : GreensheetTheme.backgroundSecondary)
                                .cornerRadius(GreensheetTheme.cornerRadiusSmall)
                        }
                    }
                }
                .padding(.horizontal, GreensheetTheme.spacingLarge)
                
                // Hole Details Form
                VStack(spacing: GreensheetTheme.spacingLarge) {
                    Text("Hole \(selectedHole) Details")
                        .font(GreensheetTheme.headlineFont)
                        .fontWeight(.semibold)
                        .foregroundColor(GreensheetTheme.label)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Par
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                        Text("Par")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                        
                        Picker("Par", selection: .constant(4)) {
                            Text("Par 3").tag(3)
                            Text("Par 4").tag(4)
                            Text("Par 5").tag(5)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    // Distance
                    FormField(
                        label: "Distance (yards)",
                        placeholder: "e.g., 420",
                                                    text: .constant("420")
                    )
                    
                    // Handicap
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                        Text("Handicap Rating")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                        
                        Stepper(value: .constant(7), in: 1...18) {
                            Text("7")
                                .font(GreensheetTheme.bodyFont)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(GreensheetTheme.backgroundSecondary)
                                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                        }
                    }
                    
                    // Hole Description
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                        Text("Hole Description")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                        
                        Text("A challenging hole with strategic bunkering and undulating greens.")
                            .font(GreensheetTheme.bodyFont)
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                            .padding()
                            .background(GreensheetTheme.backgroundSecondary)
                            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                    }
                }
                .padding()
                .background(GreensheetTheme.backgroundSecondary)
                .cornerRadius(GreensheetTheme.cornerRadiusMedium)
                .padding(.horizontal, GreensheetTheme.spacingLarge)
                
                // Quick Add All Holes
                VStack(alignment: .leading, spacing: GreensheetTheme.spacingMedium) {
                    Text("Quick Setup")
                        .font(GreensheetTheme.headlineFont)
                        .fontWeight(.semibold)
                        .foregroundColor(GreensheetTheme.label)
                        .padding(.horizontal, GreensheetTheme.spacingLarge)
                    
                    Button("Add Standard 18-Hole Layout") {
                        // Add standard layout
                    }
                    .buttonStyle(GreensheetTheme.secondaryButtonStyle)
                    .padding(.horizontal, GreensheetTheme.spacingLarge)
                }
            }
            .padding(.vertical, GreensheetTheme.spacingLarge)
        }
    }
    
    // Sample data moved to SampleData.swift
}

struct CourseDetailStatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingSmall) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(GreensheetTheme.primaryGreen)
            
            Text(value)
                .font(GreensheetTheme.bodyFont)
                .fontWeight(.semibold)
                .foregroundColor(GreensheetTheme.label)
            
            Text(title)
                .font(GreensheetTheme.smallFont)
                .foregroundColor(GreensheetTheme.secondaryLabel)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(GreensheetTheme.backgroundSecondary)
        .cornerRadius(GreensheetTheme.cornerRadiusMedium)
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
                .foregroundColor(GreensheetTheme.secondaryLabel)
            
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