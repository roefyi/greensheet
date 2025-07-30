//
//  DataController.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Greensheet")
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func save() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("Error saving to Core Data: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Helper Methods for Core Data Entities
    
    func createPlayer(name: String, handicap: Double? = nil, handicapRange: String? = nil) -> Player {
        let player = Player(context: container.viewContext)
        player.id = UUID()
        player.name = name
        player.handicap = handicap ?? 0.0
        player.handicapRange = handicapRange
        save()
        return player
    }
    
    func createCourse(name: String, location: String, par: Int16, totalYardage: Int32? = nil) -> Course {
        let course = Course(context: container.viewContext)
        course.id = UUID()
        course.name = name
        course.location = location
        course.par = par
        course.totalYardage = totalYardage ?? 0
        course.isFavorite = false
        course.timesPlayed = 0
        course.lastScore = 0
        save()
        return course
    }
    
    func createHole(number: Int16, par: Int16, yardage: Int32, handicapRanking: Int16? = nil, course: Course) -> Hole {
        let hole = Hole(context: container.viewContext)
        hole.id = UUID()
        hole.number = number
        hole.par = par
        hole.yardage = yardage
        hole.handicapRanking = handicapRanking ?? 0
        hole.course = course
        save()
        return hole
    }
    
    func createRound(course: Course, date: Date? = nil, startingHole: Int16 = 1, totalHoles: Int16 = 18) -> Round {
        let round = Round(context: container.viewContext)
        round.id = UUID()
        round.course = course
        round.date = date ?? Date()
        round.startingHole = startingHole
        round.totalHoles = totalHoles
        round.roundType = "Stroke Play"
        save()
        return round
    }
    
    func createHoleScore(holeNumber: Int16, strokes: Int16, putts: Int16, round: Round) -> HoleScore {
        let holeScore = HoleScore(context: container.viewContext)
        holeScore.id = UUID()
        holeScore.holeNumber = holeNumber
        holeScore.strokes = strokes
        holeScore.putts = putts
        holeScore.greenInRegulation = true
        holeScore.round = round
        save()
        return holeScore
    }
    
    func createTeeOption(name: String, color: String? = nil, course: Course) -> TeeOption {
        let teeOption = TeeOption(context: container.viewContext)
        teeOption.id = UUID()
        teeOption.name = name
        teeOption.color = color
        teeOption.course = course
        save()
        return teeOption
    }
}

// MARK: - Sample Data Models (for UI purposes)
struct PlayerModel: Identifiable, Codable {
    let id = UUID()
    var name: String
    var handicap: Double?
    var handicapRange: HandicapRange?
    
    enum HandicapRange: String, CaseIterable, Codable {
        case unknown = "I don't know"
        case zeroToFive = "0-5"
        case sixToTen = "6-10"
        case elevenToFifteen = "11-15"
        case sixteenToTwenty = "16-20"
        case twentyOnePlus = "21+"
    }
}

struct CourseModel: Identifiable, Codable {
    let id = UUID()
    var name: String
    var location: String
    var par: Int
    var totalYardage: Int?
    var holes: [HoleModel]
    var teeOptions: [TeeOptionModel]
    var lastPlayed: Date?
    var lastScore: Int?
    var isFavorite: Bool = false
    var timesPlayed: Int = 0
    
    struct HoleModel: Identifiable, Codable {
        let id = UUID()
        var number: Int
        var par: Int
        var yardage: Int
        var handicapRanking: Int?
    }
    
    struct TeeOptionModel: Identifiable, Codable {
        let id = UUID()
        var name: String
        var color: TeeColor
        var yardages: [Int] // 18 holes
        
        enum TeeColor: String, Codable, CaseIterable {
            case white = "White"
            case blue = "Blue"
            case red = "Red"
            case gold = "Gold"
            case black = "Black"
        }
    }
}

struct RoundModel: Identifiable, Codable {
    let id = UUID()
    var course: CourseModel
    var date: Date
    var players: [PlayerModel]
    var holes: [HoleScoreModel]
    var selectedTee: CourseModel.TeeOptionModel
    var startingHole: Int
    var totalHoles: Int // 9 or 18
    var roundType: RoundType
    var notes: String?
    
    struct HoleScoreModel: Identifiable, Codable {
        let id = UUID()
        var holeNumber: Int
        var strokes: Int
        var putts: Int
        var fairwayHit: FairwayResult
        var greenInRegulation: Bool
        var hazards: [Hazard]
        
        enum FairwayResult: String, Codable {
            case hit = "hit"
            case left = "left"
            case right = "right"
        }
        
        enum Hazard: String, Codable, CaseIterable {
            case penalty = "penalty"
            case sand = "sand"
            case water = "water"
        }
    }
    
    enum RoundType: String, Codable, CaseIterable {
        case stroke = "Stroke Play"
        case match = "Match Play"
    }
}

// MARK: - Sample Data
extension CourseModel {
    static let sampleCourses = [
        CourseModel(
            name: "Pebble Beach Golf Links",
            location: "Pebble Beach, CA",
            par: 72,
            totalYardage: 7200,
            holes: Array(1...18).map { HoleModel(number: $0, par: 4, yardage: 400, handicapRanking: $0) },
            teeOptions: [
                TeeOptionModel(name: "White Tees", color: .white, yardages: Array(repeating: 400, count: 18))
            ],
            lastPlayed: Date().addingTimeInterval(-172800), // 2 days ago
            lastScore: 78,
            timesPlayed: 8
        ),
        CourseModel(
            name: "Spyglass Hill Golf Course",
            location: "Pebble Beach, CA",
            par: 72,
            totalYardage: 7100,
            holes: Array(1...18).map { HoleModel(number: $0, par: 4, yardage: 395, handicapRanking: $0) },
            teeOptions: [
                TeeOptionModel(name: "White Tees", color: .white, yardages: Array(repeating: 395, count: 18))
            ],
            lastPlayed: Date().addingTimeInterval(-604800), // 1 week ago
            lastScore: 82,
            timesPlayed: 3
        )
    ]
}

extension PlayerModel {
    static let samplePlayer = PlayerModel(
        name: "You",
        handicap: 12.4,
        handicapRange: .elevenToFifteen
    )
} 