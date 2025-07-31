//
//  RoundViewModel.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import Foundation
import Combine
import CoreData

@MainActor
final class RoundViewModel: ObservableObject {
    // MARK: - Published Properties
    
    @Published var currentRound: Round?
    @Published var holeScores: [HoleScore] = []
    @Published var currentHole: Int = 1
    @Published var totalStrokes: Int = 0
    @Published var totalPutts: Int = 0
    @Published var greensInRegulation: Int = 0
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isRoundComplete: Bool = false
    
    // MARK: - Private Properties
    
    private let dataController: DataController
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Computed Properties
    
    var totalPar: Int {
        guard let round = currentRound,
              let course = round.course else { return 0 }
        return Int(course.par)
    }
    
    var totalScore: Int {
        return totalStrokes - totalPar
    }
    
    var scoreDisplay: String {
        if totalScore > 0 {
            return "+\(totalScore)"
        } else if totalScore < 0 {
            return "\(totalScore)"
        } else {
            return "E"
        }
    }
    
    var averagePuttsPerHole: Double {
        guard !holeScores.isEmpty else { return 0.0 }
        return Double(totalPutts) / Double(holeScores.count)
    }
    
    var greensInRegulationPercentage: Double {
        guard !holeScores.isEmpty else { return 0.0 }
        return Double(greensInRegulation) / Double(holeScores.count) * 100.0
    }
    
    // MARK: - Initialization
    
    init(dataController: DataController) {
        self.dataController = dataController
        setupBindings()
    }
    
    // MARK: - Setup
    
    private func setupBindings() {
        $holeScores
            .sink { [weak self] scores in
                self?.updateTotals(from: scores)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Public Methods
    
    func startNewRound(for course: Course) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let round = dataController.createRound(course: course)
            currentRound = round
            holeScores = []
            currentHole = 1
            isRoundComplete = false
            
            await initializeHoleScores(for: course)
        } catch {
            errorMessage = "Failed to start round: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func recordHoleScore(strokes: Int, putts: Int, greenInRegulation: Bool) async {
        guard let round = currentRound else {
            errorMessage = "No active round"
            return
        }
        
        do {
            let holeScore = dataController.createHoleScore(
                holeNumber: Int16(currentHole),
                strokes: Int16(strokes),
                putts: Int16(putts),
                round: round
            )
            holeScore.greenInRegulation = greenInRegulation
            
            if let index = holeScores.firstIndex(where: { $0.holeNumber == Int16(currentHole) }) {
                holeScores[index] = holeScore
            } else {
                holeScores.append(holeScore)
            }
            
            if currentHole < 18 {
                currentHole += 1
            } else {
                await completeRound()
            }
        } catch {
            errorMessage = "Failed to record score: \(error.localizedDescription)"
        }
    }
    
    func navigateToHole(_ holeNumber: Int) {
        guard holeNumber >= 1 && holeNumber <= 18 else {
            errorMessage = "Invalid hole number"
            return
        }
        currentHole = holeNumber
    }
    
    func getHoleScore(for holeNumber: Int) -> HoleScore? {
        return holeScores.first { $0.holeNumber == Int16(holeNumber) }
    }
    
    func getHoleScoreRelativeToPar(holeNumber: Int, course: Course) -> Int? {
        guard let holeScore = getHoleScore(for: holeNumber),
              let hole = course.holes?.first(where: { ($0 as? Hole)?.number == Int16(holeNumber) }) as? Hole else {
            return nil
        }
        return Int(holeScore.strokes) - Int(hole.par)
    }
    
    // MARK: - Private Methods
    
    private func initializeHoleScores(for course: Course) async {
        guard let holes = course.holes?.allObjects as? [Hole] else { return }
        
        for hole in holes.sorted(by: { $0.number < $1.number }) {
            let holeScore = dataController.createHoleScore(
                holeNumber: hole.number,
                strokes: 0,
                putts: 0,
                round: currentRound!
            )
            holeScore.greenInRegulation = false
            holeScores.append(holeScore)
        }
    }
    
    private func updateTotals(from scores: [HoleScore]) {
        totalStrokes = scores.reduce(0) { $0 + Int($1.strokes) }
        totalPutts = scores.reduce(0) { $0 + Int($1.putts) }
        greensInRegulation = scores.filter { $0.greenInRegulation }.count
    }
    
    private func completeRound() async {
        guard let round = currentRound else { return }
        
        do {
            round.totalStrokes = Int32(totalStrokes)
            round.totalPutts = Int32(totalPutts)
            round.greensInRegulation = Int32(greensInRegulation)
            round.isComplete = true
            
            dataController.save()
            isRoundComplete = true
        } catch {
            errorMessage = "Failed to complete round: \(error.localizedDescription)"
        }
    }
}

// MARK: - Error Handling

extension RoundViewModel {
    enum RoundError: LocalizedError {
        case noActiveRound
        case invalidHoleNumber
        case scoreAlreadyRecorded
        case roundAlreadyComplete
        
        var errorDescription: String? {
            switch self {
            case .noActiveRound: return "No active round found"
            case .invalidHoleNumber: return "Invalid hole number"
            case .scoreAlreadyRecorded: return "Score already recorded for this hole"
            case .roundAlreadyComplete: return "Round is already complete"
            }
        }
    }
} 