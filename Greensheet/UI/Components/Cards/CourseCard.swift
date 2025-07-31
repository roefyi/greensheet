//
//  CourseCard.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI

struct CourseCard: View {
    let course: Course
    let isFavorite: Bool
    let onTap: () -> Void
    let onFavoriteToggle: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: GreensheetTheme.spacingSmall) {
                courseHeader
                courseDetails
                courseStatistics
            }
            .padding(GreensheetTheme.spacingMedium)
            .background(GreensheetTheme.backgroundPrimary)
            .cornerRadius(GreensheetTheme.cornerRadiusMedium)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel("Course card for \(course.name ?? "Unknown Course")")
    }
    
    private var courseHeader: some View {
        HStack {
            VStack(alignment: .leading, spacing: GreensheetTheme.spacingXSmall) {
                Text(course.name ?? "Unknown Course")
                    .headlineFont()
                    .labelColor()
                    .lineLimit(1)
                
                Text(course.location ?? "Unknown Location")
                    .captionFont()
                    .secondaryLabelColor()
                    .lineLimit(1)
            }
            
            Spacer()
            
            Button(action: onFavoriteToggle) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite ? .red : GreensheetTheme.systemGray)
                    .font(.title2)
            }
            .accessibilityLabel(isFavorite ? "Remove from favorites" : "Add to favorites")
        }
    }
    
    private var courseDetails: some View {
        HStack(spacing: GreensheetTheme.spacingMedium) {
            VStack(spacing: GreensheetTheme.spacingXSmall) {
                Text("Par")
                    .smallFont()
                    .secondaryLabelColor()
                Text("\(course.par)")
                    .headlineFont()
                    .labelColor()
            }
            .frame(maxWidth: .infinity)
            
            Divider().frame(height: 30)
            
            VStack(spacing: GreensheetTheme.spacingXSmall) {
                Text("Yards")
                    .smallFont()
                    .secondaryLabelColor()
                Text("\(course.totalYardage)")
                    .headlineFont()
                    .labelColor()
            }
            .frame(maxWidth: .infinity)
            
            Divider().frame(height: 30)
            
            VStack(spacing: GreensheetTheme.spacingXSmall) {
                Text("Holes")
                    .smallFont()
                    .secondaryLabelColor()
                Text("18")
                    .headlineFont()
                    .labelColor()
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    private var courseStatistics: some View {
        HStack(spacing: GreensheetTheme.spacingMedium) {
            VStack(alignment: .leading, spacing: GreensheetTheme.spacingXSmall) {
                Text("Times Played")
                    .smallFont()
                    .secondaryLabelColor()
                Text("\(course.timesPlayed)")
                    .bodyFont()
                    .labelColor()
            }
            
            Spacer()
            
            if course.lastScore > 0 {
                VStack(alignment: .trailing, spacing: GreensheetTheme.spacingXSmall) {
                    Text("Last Score")
                        .smallFont()
                        .secondaryLabelColor()
                    Text("\(course.lastScore)")
                        .bodyFont()
                        .labelColor()
                }
            }
        }
        .padding(.top, GreensheetTheme.spacingSmall)
    }
}

#Preview {
    VStack(spacing: GreensheetTheme.spacingMedium) {
        CourseCard(
            course: createSampleCourse(),
            isFavorite: true,
            onTap: {},
            onFavoriteToggle: {}
        )
        
        CourseCard(
            course: createSampleCourse(),
            isFavorite: false,
            onTap: {},
            onFavoriteToggle: {}
        )
    }
    .padding()
    .background(GreensheetTheme.backgroundSecondary)
}

private func createSampleCourse() -> Course {
    let course = Course()
    course.name = "Pebble Beach Golf Links"
    course.location = "Pebble Beach, CA"
    course.par = 72
    course.totalYardage = 7075
    course.timesPlayed = 5
    course.lastScore = 78
    return course
}

extension Course {
    convenience init() {
        self.init()
    }
} 