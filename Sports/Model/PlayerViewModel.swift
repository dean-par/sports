//
//  PlayerDetailViewModel.swift
//  Sports
//
//  Created by Dean Parreno on 23/7/18.
//  Copyright © 2018 DeanParreno. All rights reserved.
//

import Foundation

class PlayerViewModel {
    
    var id: String
    var fullName: String
    var shortName: String
    var jumperNumber: String
    var position: String
    var statValue: String
    
    init(player: Player) {
        fullName = player.fullName
        shortName = player.shortName
        // Jumper number should not be below 0. If it is, set it to 0.
        jumperNumber = String(player.jumperNumber < 0 ? 0 : player.jumperNumber)
        position = player.position
        // Stat value should not be below 0. If it is, set it to 0.
        statValue = ["stat value: ", String(player.statValue < 0 ? 0 : player.statValue)].joined()
        id = String(player.id)
    }
    
}
