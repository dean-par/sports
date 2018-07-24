//
//  Match.swift
//  Sports
//
//  Created by Dean Parreno on 22/7/18.
//  Copyright © 2018 DeanParreno. All rights reserved.
//

import Foundation

struct Match: Codable {
    let matchID: String
    let teamA, teamB: Team
    let statType: String
    
    enum CodingKeys: String, CodingKey {
        case matchID = "match_id"
        case teamA = "team_A"
        case teamB = "team_B"
        case statType = "stat_type"
    }
}

struct Team: Codable {
    let id: Int?
    let name, code, shortName: String?
    let topPlayers: [Player]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, code
        case shortName = "short_name"
        case topPlayers = "top_players"
    }
}

struct Player: Codable {
    let id: Int
    let position, fullName, shortName: String
    let statValue, jumperNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case id, position
        case fullName = "full_name"
        case shortName = "short_name"
        case statValue = "stat_value"
        case jumperNumber = "jumper_number"
    }
}
