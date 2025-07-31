//
//  RoundViewModelTests.swift
//  GreensheetTests
//
//  Created by Rome on 7/26/25.
//

import XCTest
import CoreData
@testable import Greensheet

@MainActor
final class RoundViewModelTests: XCTestCase {
    var viewModel: RoundViewModel!
    var dataController: DataController!
    var testCourse: Course!
    var testRound: Round!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // Create a new DataController for testing
        dataController = DataController()
        
        // Override the container with an in-memory store for testing
        let container = NSPersistentContainer(name: "Greensheet")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        // Load the persistent stores
        let expectation = XCTestExpectation(description: "Load persistent stores")
        container.loadPersistentStores { _, error in
            if let error = error {
                XCTFail("Failed to load test Core Data stack: \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        
        // Replace the container in the data controller
        dataController.container = container
        
        testCourse = createTestCourse()
        testRound = createTestRound()
        viewModel = RoundViewModel(dataController: dataController)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        dataController = nil
        testCourse = nil
        testRound = nil
        try super.tearDownWithError()
    }
    
    func testStartNewRound() async throws {
        XCTAssertNil(viewModel.currentRound)
        XCTAssertTrue(viewModel.holeScores.isEmpty)
        XCTAssertEqual(viewModel.currentHole, 1)
        XCTAssertFalse(viewModel.isRoundComplete)
        
        await viewModel.startNewRound(for: testCourse)
        
        XCTAssertNotNil(viewModel.currentRound)
        XCTAssertEqual(viewModel.currentRound?.course, testCourse)
        XCTAssertEqual(viewModel.currentHole, 1)
        XCTAssertFalse(viewModel.isRoundComplete)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testRecordHoleScore() async throws {
        await viewModel.startNewRound(for: testCourse)
        let initialHole = viewModel.currentHole
        
        await viewModel.recordHoleScore(strokes: 4, putts: 2, greenInRegulation: true)
        
        XCTAssertEqual(viewModel.currentHole, initialHole + 1)
        XCTAssertEqual(viewModel.totalStrokes, 4)
        XCTAssertEqual(viewModel.totalPutts, 2)
        XCTAssertEqual(viewModel.greensInRegulation, 1)
        
        let holeScore = viewModel.getHoleScore(for: initialHole)
        XCTAssertNotNil(holeScore)
        XCTAssertEqual(holeScore?.strokes, 4)
        XCTAssertEqual(holeScore?.putts, 2)
        XCTAssertTrue(holeScore?.greenInRegulation ?? false)
    }
    
    func testRecordHoleScoreWithoutActiveRound() async throws {
        XCTAssertNil(viewModel.currentRound)
        
        await viewModel.recordHoleScore(strokes: 4, putts: 2, greenInRegulation: true)
        
        XCTAssertEqual(viewModel.errorMessage, "No active round")
        XCTAssertEqual(viewModel.totalStrokes, 0)
        XCTAssertEqual(viewModel.totalPutts, 0)
        XCTAssertEqual(viewModel.greensInRegulation, 0)
    }
    
    func testCompleteRound() async throws {
        await viewModel.startNewRound(for: testCourse)
        
        for hole in 1...18 {
            await viewModel.recordHoleScore(strokes: 4, putts: 2, greenInRegulation: true)
        }
        
        XCTAssertTrue(viewModel.isRoundComplete)
        XCTAssertEqual(viewModel.totalStrokes, 72)
        XCTAssertEqual(viewModel.totalPutts, 36)
        XCTAssertEqual(viewModel.greensInRegulation, 18)
        XCTAssertEqual(viewModel.currentHole, 18)
    }
    
    func testNavigateToHole() async throws {
        await viewModel.startNewRound(for: testCourse)
        XCTAssertEqual(viewModel.currentHole, 1)
        
        viewModel.navigateToHole(5)
        
        XCTAssertEqual(viewModel.currentHole, 5)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testNavigateToInvalidHole() async throws {
        await viewModel.startNewRound(for: testCourse)
        
        viewModel.navigateToHole(0)
        
        XCTAssertEqual(viewModel.errorMessage, "Invalid hole number")
        XCTAssertEqual(viewModel.currentHole, 1)
    }
    
    func testGetHoleScoreRelativeToPar() async throws {
        await viewModel.startNewRound(for: testCourse)
        await viewModel.recordHoleScore(strokes: 3, putts: 1, greenInRegulation: true)
        
        let relativeScore = viewModel.getHoleScoreRelativeToPar(holeNumber: 1, course: testCourse)
        
        XCTAssertEqual(relativeScore, -1)
    }
    
    func testScoreDisplayCalculations() async throws {
        await viewModel.startNewRound(for: testCourse)
        
        for hole in 1...18 {
            let strokes = hole <= 9 ? 3 : 5
            await viewModel.recordHoleScore(strokes: strokes, putts: 2, greenInRegulation: true)
        }
        
        XCTAssertEqual(viewModel.totalStrokes, 72)
        XCTAssertEqual(viewModel.totalPar, 72)
        XCTAssertEqual(viewModel.totalScore, 0)
        XCTAssertEqual(viewModel.scoreDisplay, "E")
    }
    
    func testAveragePuttsPerHole() async throws {
        await viewModel.startNewRound(for: testCourse)
        
        for hole in 1...18 {
            let putts = hole <= 9 ? 1 : 3
            await viewModel.recordHoleScore(strokes: 4, putts: putts, greenInRegulation: true)
        }
        
        XCTAssertEqual(viewModel.totalPutts, 36)
        XCTAssertEqual(viewModel.averagePuttsPerHole, 2.0, accuracy: 0.01)
    }
    
    func testGreensInRegulationPercentage() async throws {
        await viewModel.startNewRound(for: testCourse)
        
        for hole in 1...18 {
            let greenInRegulation = hole <= 12
            await viewModel.recordHoleScore(strokes: 4, putts: 2, greenInRegulation: greenInRegulation)
        }
        
        XCTAssertEqual(viewModel.greensInRegulation, 12)
        XCTAssertEqual(viewModel.greensInRegulationPercentage, 66.67, accuracy: 0.01)
    }
    
    func testErrorHandling() async throws {
        await viewModel.startNewRound(for: testCourse)
        
        viewModel.navigateToHole(25)
        XCTAssertEqual(viewModel.errorMessage, "Invalid hole number")
        
        viewModel.navigateToHole(5)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    private func createTestCourse() -> Course {
        let course = Course(context: dataController.container.viewContext)
        course.id = UUID()
        course.name = "Test Golf Course"
        course.location = "Test Location"
        course.par = 72
        course.totalYardage = 7000
        course.isFavorite = false
        course.timesPlayed = 0
        course.lastScore = 0
        
        for holeNumber in 1...18 {
            let hole = Hole(context: dataController.container.viewContext)
            hole.id = UUID()
            hole.number = Int16(holeNumber)
            hole.par = 4
            hole.yardage = 400
            hole.handicapRanking = Int16(holeNumber)
            hole.course = course
        }
        
        return course
    }
    
    private func createTestRound() -> Round {
        let round = Round(context: dataController.container.viewContext)
        round.id = UUID()
        round.course = testCourse
        round.date = Date()
        round.startingHole = 1
        round.totalHoles = 18
        round.roundType = "Stroke Play"
        round.isComplete = false
        return round
    }
}

extension RoundViewModelTests {
    func testPerformanceStartNewRound() throws {
        measure {
            Task {
                await viewModel.startNewRound(for: testCourse)
            }
        }
    }
    
    func testPerformanceRecordMultipleHoleScores() throws {
        await viewModel.startNewRound(for: testCourse)
        
        measure {
            Task {
                for hole in 1...18 {
                    await viewModel.recordHoleScore(strokes: 4, putts: 2, greenInRegulation: true)
                }
            }
        }
    }
} 