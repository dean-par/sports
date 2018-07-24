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
    var jumperNumber: String
    var position: String
    var statValue: String
    
    init(player: Player) {
        fullName = player.fullName
        jumperNumber = String(player.jumperNumber)
        position = player.position
        statValue = String(player.statValue)
        id = String(player.id)
    }
    
}
