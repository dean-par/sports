//
//  IndividualStats.swift
//  Sports
//
//  Created by Dean Parreno on 22/7/18.
//  Copyright © 2018 DeanParreno. All rights reserved.
//

import Foundation

struct IndividualStats: Codable {
    let id: Int
    let surname, position, fullName, shortName: String?
    let dateOfBirth: String?
    let heightCM: Int
    let otherNames: String?
    let weightKg: Int
    let lastMatchID: String?
    let careerStats: CareerStats
    let lastMatchStats: [String: Double?]
    
    enum CodingKeys: String, CodingKey {
        case id, surname, position
        case fullName = "full_name"
        case shortName = "short_name"
        case dateOfBirth = "date_of_birth"
        case heightCM = "height_cm"
        case otherNames = "other_names"
        case weightKg = "weight_kg"
        case lastMatchID = "last_match_id"
        case careerStats = "career_stats"
        case lastMatchStats = "last_match_stats"
    }
}



struct CareerStats: Codable {
    let games, points, tries: Int
    let winPercentage: Double
    
    enum CodingKeys: String, CodingKey {
        case games, points, tries
        case winPercentage = "win_percentage"
    }
}
