//
//  playerImageView.swift
//  Sports
//
//  Created by Dean Parreno on 24/7/18.
//  Copyright © 2018 DeanParreno. All rights reserved.
//

import UIKit

class PlayerImageView: UIImageView {
    
    var player: Player?
    var matchID: String?
    
    var playerID: String? {
        return String(player?.id ?? 0)
    }

}
