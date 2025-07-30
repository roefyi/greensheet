//
//  LocationPermissionScreen.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import SwiftUI
import CoreLocation

struct LocationPermissionScreen: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        VStack(spacing: GreensheetTheme.spacingXLarge) {
            // Header
            NavigationHeader(
                title: "Find Courses Near You",
                showBackButton: true,
                backAction: { appState.goBack() }
            )
            
            Spacer()
            
            // Permission Content
            VStack(spacing: GreensheetTheme.spacingLarge) {
                // Location Icon
                Image(systemName: "location.fill")
                    .font(.system(size: 60))
                    .foregroundColor(GreensheetTheme.primaryGreen)
                
                // Description
                Text("Allow Greensheet to access your location to find golf courses in your area")
                    .font(GreensheetTheme.bodyFont)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, GreensheetTheme.spacingLarge)
                
                // Benefits
                VStack(spacing: GreensheetTheme.spacingMedium) {
                    BenefitRow(icon: "🔍", text: "Discover new courses")
                    BenefitRow(icon: "⚡", text: "Quick course setup")
                }
                .padding(.vertical, GreensheetTheme.spacingLarge)
            }
            
            Spacer()
            
            // Action Buttons
            VStack(spacing: GreensheetTheme.spacingMedium) {
                Button("Allow Location Access") {
                    locationManager.requestLocationPermission()
                }
                .buttonStyle(GreensheetTheme.primaryButtonStyle)
                .padding(.horizontal, GreensheetTheme.spacingLarge)
                
                Button("Skip for Now") {
                    appState.navigateTo(.firstCourseSetup)
                }
                .buttonStyle(GreensheetTheme.secondaryButtonStyle)
                .padding(.horizontal, GreensheetTheme.spacingLarge)
            }
        }
        .background(GreensheetTheme.backgroundPrimary)
        .onReceive(locationManager.$authorizationStatus) { status in
            if status == .authorizedWhenInUse || status == .authorizedAlways {
                appState.navigateTo(.firstCourseSetup)
            }
        }
    }
}

struct BenefitRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: GreensheetTheme.spacingMedium) {
            Text(icon)
                .font(.title2)
            
            Text(text)
                .font(GreensheetTheme.bodyFont)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding(.horizontal, GreensheetTheme.spacingLarge)
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
    }
}

#Preview {
    LocationPermissionScreen()
        .environmentObject(AppState())
} 