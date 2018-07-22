//
//  MatchTopPlayersViewModel.swift
//  Sports
//
//  Created by Dean Parreno on 22/7/18.
//  Copyright © 2018 DeanParreno. All rights reserved.
//

import Foundation

class MatchTopPlayersViewModel {
    
    let teamATopPlayers: [Player]
    let teamBTopPlayers: [Player]
    let statType: String
    
    var numberOfSections = 0
    
    init(match: Match) {
        teamATopPlayers = match.teamA.topPlayers!
        teamBTopPlayers = match.teamB.topPlayers!
        statType = match.statType
    }
    

    
}
