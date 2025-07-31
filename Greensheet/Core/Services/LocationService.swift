//
//  LocationService.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import Foundation
import CoreLocation
import Combine

@MainActor
final class LocationService: NSObject, ObservableObject {
    @Published var currentLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var isLocationEnabled: Bool = false
    @Published var errorMessage: String?
    
    private let locationManager = CLLocationManager()
    private var locationUpdateTimer: Timer?
    private let locationUpdateInterval: TimeInterval = 30.0
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10.0
        locationManager.allowsBackgroundLocationUpdates = false
        locationManager.pausesLocationUpdatesAutomatically = true
    }
    
    func requestLocationPermission() async -> Result<Void, LocationError> {
        guard CLLocationManager.locationServicesEnabled() else {
            return .failure(.locationServicesDisabled)
        }
        
        switch authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return await waitForAuthorization()
        case .denied, .restricted:
            return .failure(.permissionDenied)
        case .authorizedWhenInUse, .authorizedAlways:
            return .success(())
        @unknown default:
            return .failure(.unknownAuthorizationStatus)
        }
    }
    
    func startLocationUpdates() async -> Result<Void, LocationError> {
        let permissionResult = await requestLocationPermission()
        
        switch permissionResult {
        case .success:
            locationManager.startUpdatingLocation()
            startLocationUpdateTimer()
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
        stopLocationUpdateTimer()
    }
    
    func getNearbyCourses(within radiusInMeters: Double) async -> Result<[Course], LocationError> {
        guard let location = currentLocation else {
            return .failure(.noLocationAvailable)
        }
        
        do {
            let courses = try await searchNearbyCourses(at: location, radius: radiusInMeters)
            return .success(courses)
        } catch {
            return .failure(.searchFailed(error))
        }
    }
    
    func calculateDistance(to coordinate: CLLocationCoordinate2D) async -> Result<CLLocationDistance, LocationError> {
        guard let currentLocation = currentLocation else {
            return .failure(.noLocationAvailable)
        }
        
        let targetLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let distance = currentLocation.distance(from: targetLocation)
        
        return .success(distance)
    }
    
    private func waitForAuthorization() async -> Result<Void, LocationError> {
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                switch self.authorizationStatus {
                case .authorizedWhenInUse, .authorizedAlways:
                    continuation.resume(returning: .success(()))
                case .denied, .restricted:
                    continuation.resume(returning: .failure(.permissionDenied))
                default:
                    continuation.resume(returning: .failure(.permissionDenied))
                }
            }
        }
    }
    
    private func startLocationUpdateTimer() {
        locationUpdateTimer = Timer.scheduledTimer(withTimeInterval: locationUpdateInterval, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.requestLocationUpdate()
            }
        }
    }
    
    private func stopLocationUpdateTimer() {
        locationUpdateTimer?.invalidate()
        locationUpdateTimer = nil
    }
    
    private func requestLocationUpdate() {
        locationManager.requestLocation()
    }
    
    private func searchNearbyCourses(at location: CLLocation, radius: Double) async throws -> [Course] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        let mockCourses = createMockCourses(near: location)
        
        return mockCourses.filter { course in
            // For now, return all courses since we don't have location data in the model
            return true
        }
    }
    
    private func createMockCourses(near location: CLLocation) -> [Course] {
        return []
    }
}

extension LocationService: @preconcurrency CLLocationManagerDelegate {
    nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        guard location.horizontalAccuracy <= 100 else { return }
        
        Task { @MainActor in
            currentLocation = location
            isLocationEnabled = true
            errorMessage = nil
        }
    }
    
    nonisolated func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Task { @MainActor in
            if let clError = error as? CLError {
                switch clError.code {
                case .denied:
                    errorMessage = "Location access denied"
                    isLocationEnabled = false
                case .locationUnknown:
                    errorMessage = "Unable to determine location"
                case .network:
                    errorMessage = "Network error occurred"
                default:
                    errorMessage = "Location error: \(clError.localizedDescription)"
                }
            } else {
                errorMessage = "Location error: \(error.localizedDescription)"
            }
        }
    }
    
    nonisolated func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        Task { @MainActor in
            authorizationStatus = status
            
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                isLocationEnabled = true
                errorMessage = nil
            case .denied, .restricted:
                isLocationEnabled = false
                errorMessage = "Location access denied"
            case .notDetermined:
                isLocationEnabled = false
                errorMessage = nil
            @unknown default:
                isLocationEnabled = false
                errorMessage = "Unknown authorization status"
            }
        }
    }
}

extension LocationService {
    enum LocationError: LocalizedError {
        case locationServicesDisabled
        case permissionDenied
        case noLocationAvailable
        case searchFailed(Error)
        case unknownAuthorizationStatus
        
        var errorDescription: String? {
            switch self {
            case .locationServicesDisabled:
                return "Location services are disabled on this device"
            case .permissionDenied:
                return "Location permission denied. Please enable in Settings."
            case .noLocationAvailable:
                return "No location data available"
            case .searchFailed(let error):
                return "Failed to search for courses: \(error.localizedDescription)"
            case .unknownAuthorizationStatus:
                return "Unknown authorization status"
            }
        }
        
        var recoverySuggestion: String? {
            switch self {
            case .locationServicesDisabled:
                return "Enable Location Services in Settings > Privacy & Security > Location Services"
            case .permissionDenied:
                return "Go to Settings > Privacy & Security > Location Services > Greensheet and select 'While Using App'"
            case .noLocationAvailable:
                return "Try moving to an area with better GPS signal"
            case .searchFailed:
                return "Check your internet connection and try again"
            case .unknownAuthorizationStatus:
                return "Try restarting the app"
            }
        }
    }
} 