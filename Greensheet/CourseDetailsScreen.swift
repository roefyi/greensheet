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
                        
                        Picker("Par", selection: .constant(sampleHolePar[selectedHole - 1])) {
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
                        text: .constant("\(sampleHoleYardage[selectedHole - 1])")
                    )
                    
                    // Handicap
                    VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                        Text("Handicap Rating")
                            .font(GreensheetTheme.captionFont)
                            .foregroundColor(GreensheetTheme.secondaryLabel)
                        
                        Stepper(value: .constant(sampleHoleHandicap[selectedHole - 1]), in: 1...18) {
                            Text("\(sampleHoleHandicap[selectedHole - 1])")
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
                        
                        Text(sampleHoleDescriptions[selectedHole - 1])
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
    
    private let sampleHolePar = [4, 4, 4, 3, 4, 5, 3, 4, 4, 4, 4, 3, 4, 4, 5, 3, 4, 5]
    private let sampleHoleYardage = [380, 516, 404, 208, 195, 523, 106, 428, 526, 495, 390, 202, 445, 580, 397, 162, 208, 543]
    private let sampleHoleHandicap = [7, 1, 11, 17, 15, 3, 13, 9, 5, 8, 12, 18, 6, 2, 4, 16, 14, 10]
    private let sampleHoleDescriptions = [
        "A challenging opening hole with a dogleg right. The fairway slopes from left to right, making accuracy off the tee crucial.",
        "One of the most famous holes in golf. A long par-4 with the Pacific Ocean as a backdrop. Accuracy and distance required.",
        "A straightaway par-4 with bunkers guarding the green. Good approach shot placement is key.",
        "A short but tricky par-3 with a small, undulating green protected by bunkers.",
        "A medium-length par-4 with a narrow fairway. Trees line both sides, requiring precision off the tee.",
        "A long par-5 with multiple landing areas. Strategic play can lead to birdie opportunities.",
        "A short par-3 with a large green but challenging pin positions.",
        "A classic par-4 with a slight dogleg left. The green is well-protected by bunkers.",
        "A strong par-4 finishing hole for the front nine. Requires both power and accuracy.",
        "A challenging par-4 with a narrow landing area. The green slopes from back to front.",
        "A medium-length par-4 with a wide fairway but challenging green complex.",
        "A picturesque par-3 with ocean views. The green is small and well-protected.",
        "A long par-4 with a slight dogleg right. The approach shot is crucial for scoring.",
        "A challenging par-4 with a narrow fairway and well-protected green.",
        "A reachable par-5 with risk-reward options. Eagle opportunities for long hitters.",
        "A short par-3 with a large green but challenging wind conditions.",
        "A medium-length par-4 with a slight dogleg left. Accuracy off the tee is important.",
        "A dramatic finishing hole with ocean views. A long par-5 that can make or break a round."
    ]
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