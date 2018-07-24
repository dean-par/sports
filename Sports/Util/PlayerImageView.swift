//
//  playerImageView.swift
//  Sports
//
//  Created by Dean Parreno on 24/7/18.
//  Copyright © 2018 DeanParreno. All rights reserved.
//

import UIKit

class PlayerImageView: UIImageView {
    
    var playerViewModel: PlayerViewModel?
    var teamID: String?
    
    var playerID: String? {
        return playerViewModel?.id ?? ""
    }

}
