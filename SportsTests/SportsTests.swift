//
//  SportsTests.swift
//  SportsTests
//
//  Created by Dean Parreno on 22/7/18.
//  Copyright © 2018 DeanParreno. All rights reserved.
//

import XCTest
@testable import Sports

class SportsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testStatValueIntIsConvertedToStringWithLabel() {
        let playerViewModel = PlayerViewModel(player: Player(id: 4131, position: "Fullback", fullName: "James Dean", shortName: "J. Dean", statValue: 78, jumperNumber: 32))
        XCTAssert(playerViewModel.statValue == "stat value: 78")
    }
    
    func testStatValueIntCannotBeNegative() {
        let playerViewModel = PlayerViewModel(player: Player(id: 4131, position: "Fullback", fullName: "James Dean", shortName: "J. Dean", statValue: -78, jumperNumber: 32))
        XCTAssertFalse(playerViewModel.statValue == "stat value: -78")
        XCTAssert(playerViewModel.statValue == "stat value: 0")
    }
    
    func testJumperNumberIntIsConvertedToString() {
        let playerViewModel = PlayerViewModel(player: Player(id: 4131, position: "Fullback", fullName: "James Dean", shortName: "J. Dean", statValue: 78, jumperNumber: 32))
        XCTAssert(playerViewModel.jumperNumber == "32")
    }
    
    func testJumperNumberCannotBeNegative() {
        let playerViewModel = PlayerViewModel(player: Player(id: 4131, position: "Fullback", fullName: "James Dean", shortName: "J. Dean", statValue: 78, jumperNumber: -32))
        XCTAssertFalse(playerViewModel.jumperNumber == "-32")
        XCTAssert(playerViewModel.jumperNumber == "0")
    }
    
    func testIDIntIsConvertedToString() {
        let playerViewModel = PlayerViewModel(player: Player(id: 4131, position: "Fullback", fullName: "James Dean", shortName: "J. Dean", statValue: 78, jumperNumber: 32))
        XCTAssert(playerViewModel.id == "4131")
    }
    
    func testFullNameIsEqualToModel() {
        let player = Player(id: 4131, position: "Fullback", fullName: "James Dean", shortName: "J. Dean", statValue: 78, jumperNumber: 32)
        let playerViewModel = PlayerViewModel(player: player)
        XCTAssert(playerViewModel.fullName == player.fullName)
    }
    
    func testIndividualStatsAreEqualToModel() {
        let lastMatchStats = [
            "try_involvements": 2.0
        ]
        let individualStatsViewModel = IndividualStatsViewModel(individualStats: IndividualStats.init(id: 123, surname: "James", position: "Fullback", fullName: "James Dean", shortName: "J. Dean", dateOfBirth: "5/10/90", heightCM: 180, otherNames: "Big Man", weightKg: 80, lastMatchID: "1234", careerStats: CareerStats(games: 2, points: 3, tries: 3, winPercentage: 87), lastMatchStats: lastMatchStats))
        XCTAssert(individualStatsViewModel.statValues?.first == "2.0")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
