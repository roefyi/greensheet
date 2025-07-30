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
                TeeOptionModel(name: "Championship", color: .black, yardages: Array(repeating: 420, count: 18)),
                TeeOptionModel(name: "Blue", color: .blue, yardages: Array(repeating: 400, count: 18)),
                TeeOptionModel(name: "White", color: .white, yardages: Array(repeating: 380, count: 18)),
                TeeOptionModel(name: "Gold", color: .gold, yardages: Array(repeating: 360, count: 18)),
                TeeOptionModel(name: "Red", color: .red, yardages: Array(repeating: 340, count: 18))
            ],
            lastPlayed: Date().addingTimeInterval(-172800), // 2 days ago
            lastScore: 78,
            isFavorite: true,
            timesPlayed: 8
        ),
        CourseModel(
            name: "Spyglass Hill Golf Course",
            location: "Pebble Beach, CA",
            par: 72,
            totalYardage: 7100,
            holes: Array(1...18).map { HoleModel(number: $0, par: 4, yardage: 395, handicapRanking: $0) },
            teeOptions: [
                TeeOptionModel(name: "Championship", color: .black, yardages: Array(repeating: 410, count: 18)),
                TeeOptionModel(name: "Blue", color: .blue, yardages: Array(repeating: 395, count: 18)),
                TeeOptionModel(name: "White", color: .white, yardages: Array(repeating: 375, count: 18)),
                TeeOptionModel(name: "Gold", color: .gold, yardages: Array(repeating: 355, count: 18))
            ],
            lastPlayed: Date().addingTimeInterval(-604800), // 1 week ago
            lastScore: 82,
            isFavorite: true,
            timesPlayed: 3
        ),
        CourseModel(
            name: "Spanish Bay Golf Links",
            location: "Pebble Beach, CA",
            par: 72,
            totalYardage: 7050,
            holes: Array(1...18).map { HoleModel(number: $0, par: 4, yardage: 392, handicapRanking: $0) },
            teeOptions: [
                TeeOptionModel(name: "Championship", color: .black, yardages: Array(repeating: 405, count: 18)),
                TeeOptionModel(name: "Blue", color: .blue, yardages: Array(repeating: 392, count: 18)),
                TeeOptionModel(name: "White", color: .white, yardages: Array(repeating: 372, count: 18)),
                TeeOptionModel(name: "Gold", color: .gold, yardages: Array(repeating: 352, count: 18))
            ],
            lastPlayed: Date().addingTimeInterval(-1209600), // 2 weeks ago
            lastScore: 79,
            isFavorite: true,
            timesPlayed: 2
        ),
        CourseModel(
            name: "Del Monte Golf Course",
            location: "Monterey, CA",
            par: 72,
            totalYardage: 6200,
            holes: Array(1...18).map { HoleModel(number: $0, par: 4, yardage: 345, handicapRanking: $0) },
            teeOptions: [
                TeeOptionModel(name: "Blue", color: .blue, yardages: Array(repeating: 345, count: 18)),
                TeeOptionModel(name: "White", color: .white, yardages: Array(repeating: 325, count: 18)),
                TeeOptionModel(name: "Gold", color: .gold, yardages: Array(repeating: 305, count: 18))
            ],
            lastPlayed: Date().addingTimeInterval(-2592000), // 1 month ago
            lastScore: 85,
            isFavorite: false,
            timesPlayed: 1
        ),
        CourseModel(
            name: "Pacific Grove Golf Links",
            location: "Pacific Grove, CA",
            par: 72,
            totalYardage: 5800,
            holes: Array(1...18).map { HoleModel(number: $0, par: 4, yardage: 322, handicapRanking: $0) },
            teeOptions: [
                TeeOptionModel(name: "Blue", color: .blue, yardages: Array(repeating: 322, count: 18)),
                TeeOptionModel(name: "White", color: .white, yardages: Array(repeating: 302, count: 18)),
                TeeOptionModel(name: "Red", color: .red, yardages: Array(repeating: 282, count: 18))
            ],
            lastPlayed: nil,
            lastScore: nil,
            isFavorite: false,
            timesPlayed: 0
        ),
        CourseModel(
            name: "Bayonet and Black Horse Golf Course",
            location: "Seaside, CA",
            par: 72,
            totalYardage: 7100,
            holes: Array(1...18).map { HoleModel(number: $0, par: 4, yardage: 395, handicapRanking: $0) },
            teeOptions: [
                TeeOptionModel(name: "Championship", color: .black, yardages: Array(repeating: 395, count: 18)),
                TeeOptionModel(name: "Blue", color: .blue, yardages: Array(repeating: 375, count: 18)),
                TeeOptionModel(name: "White", color: .white, yardages: Array(repeating: 355, count: 18))
            ],
            lastPlayed: Date().addingTimeInterval(-5184000), // 2 months ago
            lastScore: 88,
            isFavorite: false,
            timesPlayed: 1
        ),
        CourseModel(
            name: "Monterey Peninsula Country Club",
            location: "Monterey, CA",
            par: 72,
            totalYardage: 7100,
            holes: Array(1...18).map { HoleModel(number: $0, par: 4, yardage: 395, handicapRanking: $0) },
            teeOptions: [
                TeeOptionModel(name: "Championship", color: .black, yardages: Array(repeating: 395, count: 18)),
                TeeOptionModel(name: "Blue", color: .blue, yardages: Array(repeating: 375, count: 18)),
                TeeOptionModel(name: "White", color: .white, yardages: Array(repeating: 355, count: 18))
            ],
            lastPlayed: nil,
            lastScore: nil,
            isFavorite: false,
            timesPlayed: 0
        ),
        CourseModel(
            name: "Cypress Point Club",
            location: "Pebble Beach, CA",
            par: 72,
            totalYardage: 6500,
            holes: Array(1...18).map { HoleModel(number: $0, par: 4, yardage: 361, handicapRanking: $0) },
            teeOptions: [
                TeeOptionModel(name: "Championship", color: .black, yardages: Array(repeating: 361, count: 18)),
                TeeOptionModel(name: "Blue", color: .blue, yardages: Array(repeating: 341, count: 18)),
                TeeOptionModel(name: "White", color: .white, yardages: Array(repeating: 321, count: 18))
            ],
            lastPlayed: nil,
            lastScore: nil,
            isFavorite: false,
            timesPlayed: 0
        )
    ]
}

extension PlayerModel {
    static let samplePlayer = PlayerModel(
        name: "You",
        handicap: 12.4,
        handicapRange: .elevenToFifteen
    )
    
    static let samplePlayers = [
        PlayerModel(name: "John Smith", handicap: 12.4, handicapRange: .elevenToFifteen),
        PlayerModel(name: "Mike Johnson", handicap: 8.2, handicapRange: .sixToTen),
        PlayerModel(name: "David Wilson", handicap: 15.7, handicapRange: .sixteenToTwenty),
        PlayerModel(name: "Tom Brown", handicap: 6.1, handicapRange: .sixToTen),
        PlayerModel(name: "Sarah Davis", handicap: 18.3, handicapRange: .sixteenToTwenty),
        PlayerModel(name: "Chris Lee", handicap: 3.8, handicapRange: .zeroToFive),
        PlayerModel(name: "Alex Rodriguez", handicap: 22.1, handicapRange: .twentyOnePlus),
        PlayerModel(name: "Emma Thompson", handicap: 14.6, handicapRange: .elevenToFifteen)
    ]
}

// MARK: - Sample Round Data
extension RoundModel {
    static let sampleRounds = [
        RoundModel(
            course: CourseModel.sampleCourses[0],
            date: Date().addingTimeInterval(-172800),
            players: [PlayerModel.samplePlayer],
            holes: generateSampleHoleScores(par: 72, score: 78),
            selectedTee: CourseModel.sampleCourses[0].teeOptions[2], // White tees
            startingHole: 1,
            totalHoles: 18,
            roundType: .stroke,
            notes: "Great round! Hit the ball well off the tee. Need to work on putting."
        ),
        RoundModel(
            course: CourseModel.sampleCourses[1],
            date: Date().addingTimeInterval(-604800),
            players: [PlayerModel.samplePlayer],
            holes: generateSampleHoleScores(par: 72, score: 82),
            selectedTee: CourseModel.sampleCourses[1].teeOptions[2], // White tees
            startingHole: 1,
            totalHoles: 18,
            roundType: .stroke,
            notes: "Challenging course. Struggled with approach shots."
        ),
        RoundModel(
            course: CourseModel.sampleCourses[2],
            date: Date().addingTimeInterval(-1209600),
            players: [PlayerModel.samplePlayer],
            holes: generateSampleHoleScores(par: 72, score: 79),
            selectedTee: CourseModel.sampleCourses[2].teeOptions[2], // White tees
            startingHole: 1,
            totalHoles: 18,
            roundType: .stroke,
            notes: "Solid round. Good putting saved the day."
        ),
        RoundModel(
            course: CourseModel.sampleCourses[0],
            date: Date().addingTimeInterval(-1814400),
            players: [PlayerModel.samplePlayer],
            holes: generateSampleHoleScores(par: 72, score: 81),
            selectedTee: CourseModel.sampleCourses[0].teeOptions[2], // White tees
            startingHole: 1,
            totalHoles: 18,
            roundType: .stroke,
            notes: "Windy conditions made it tough."
        ),
        RoundModel(
            course: CourseModel.sampleCourses[1],
            date: Date().addingTimeInterval(-2419200),
            players: [PlayerModel.samplePlayer],
            holes: generateSampleHoleScores(par: 72, score: 84),
            selectedTee: CourseModel.sampleCourses[1].teeOptions[2], // White tees
            startingHole: 1,
            totalHoles: 18,
            roundType: .stroke,
            notes: "First time playing this course. Very challenging."
        ),
        RoundModel(
            course: CourseModel.sampleCourses[0],
            date: Date().addingTimeInterval(-3024000),
            players: [PlayerModel.samplePlayer],
            holes: generateSampleHoleScores(par: 72, score: 77),
            selectedTee: CourseModel.sampleCourses[0].teeOptions[2], // White tees
            startingHole: 1,
            totalHoles: 18,
            roundType: .stroke,
            notes: "Personal best! Everything clicked today."
        ),
        RoundModel(
            course: CourseModel.sampleCourses[2],
            date: Date().addingTimeInterval(-3628800),
            players: [PlayerModel.samplePlayer],
            holes: generateSampleHoleScores(par: 72, score: 83),
            selectedTee: CourseModel.sampleCourses[2].teeOptions[2], // White tees
            startingHole: 1,
            totalHoles: 18,
            roundType: .stroke,
            notes: "Struggled with the wind on the back nine."
        ),
        RoundModel(
            course: CourseModel.sampleCourses[0],
            date: Date().addingTimeInterval(-4233600),
            players: [PlayerModel.samplePlayer],
            holes: generateSampleHoleScores(par: 72, score: 80),
            selectedTee: CourseModel.sampleCourses[0].teeOptions[2], // White tees
            startingHole: 1,
            totalHoles: 18,
            roundType: .stroke,
            notes: "Consistent round. No big numbers."
        )
    ]
    
    private static func generateSampleHoleScores(par: Int, score: Int) -> [HoleScoreModel] {
        let parValues = [4, 4, 4, 3, 4, 5, 3, 4, 4, 4, 4, 3, 4, 4, 5, 3, 4, 5]
        let scoreValues = generateRealisticScores(par: par, totalScore: score)
        
        return Array(1...18).map { holeNumber in
            let holePar = parValues[holeNumber - 1]
            let holeScore = scoreValues[holeNumber - 1]
            let putts = max(1, min(3, holeScore - holePar + 2)) // Realistic putt count
            
            return HoleScoreModel(
                holeNumber: holeNumber,
                strokes: holeScore,
                putts: putts,
                fairwayHit: [.hit, .left, .right].randomElement() ?? .hit,
                greenInRegulation: holeScore <= holePar + 1,
                hazards: []
            )
        }
    }
    
    private static func generateRealisticScores(par: Int, totalScore: Int) -> [Int] {
        let parValues = [4, 4, 4, 3, 4, 5, 3, 4, 4, 4, 4, 3, 4, 4, 5, 3, 4, 5]
        var scores = parValues.map { $0 }
        let overPar = totalScore - par
        
        // Distribute the over par strokes realistically
        for _ in 0..<overPar {
            let randomHole = Int.random(in: 0..<18)
            scores[randomHole] += 1
        }
        
        return scores
    }
} 