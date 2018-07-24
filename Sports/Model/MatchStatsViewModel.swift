//
//  MatchStatsSectionViewModel.swift
//  Sports
//
//  Created by Dean Parreno on 22/7/18.
//  Copyright © 2018 DeanParreno. All rights reserved.
//

import Foundation

class MatchStatsViewModel {
    
    enum StatType: String {
        case fantasyPoints = "fantasy_points"
        case tackles = "tackles"
        case runMetres = "run_metres"
        case runs = "runs"
        case other
        
        var title: String {
            let title: String
            switch self {
            case .fantasyPoints: title = "Fantasy Points"
            case .tackles: title = "Tackles"
            case .runMetres: title = "Run in Metres"
            case .runs: title = "Runs"
            case .other: title = "Other"
            }
            return title
        }
    }
    
    var numberOfSections = 0
    
    private var matchStats: [Match]
    
    private var firstMatch: Match? {
        return matchStats.first
    }
    
    private var teamA: Team? {
        return firstMatch?.teamA
    }
    
    private var teamB: Team? {
        return firstMatch?.teamB
    }
    
    var teamAID: String {
        let teamID: String
        if let team = teamA,
            let id = team.id
        {
            teamID = String(id)
        } else {
            teamID = ""
        }
        return teamID
    }
    
    // TODO: This is a copy of above, implement in way to re-use code.
    var teamBID: String {
        let teamID: String
        if let team = teamB,
            let id = team.id
        {
            teamID = String(id)
        } else {
            teamID = ""
        }
        return teamID
    }
    
    var teamAName: String {
        return teamA?.name ?? ""
    }
    
    var teamBName: String {
        return teamB?.name ?? ""
    }
    
    init(matchStats: [Match]) {
        numberOfSections = matchStats.count
        self.matchStats = matchStats
    }
    
    func matchFor(section: Int) -> Match {
        return matchStats[section]
    }
        
    func numberOfRows(section: Int) -> Int {
        return matchStats[section].teamA.topPlayers?.count ?? 0
    }
    
    func titleFor(section: Int) -> String {
        // Setting default to other if stat type doesn't exist.
        let statType = StatType.init(rawValue: matchStats[section].statType) ?? .other
        return statType.title
    }
    
}
