//
//  MatchStatsSectionViewModel.swift
//  Sports
//
//  Created by Dean Parreno on 22/7/18.
//  Copyright © 2018 DeanParreno. All rights reserved.
//

import Foundation

class MatchStatsSectionViewModel {
    
    var numberOfSections = 0
    private var matchStats: [Match]
    
    init(matchStats: [Match]) {
        numberOfSections = matchStats.count
        self.matchStats = matchStats
    }
    
    func numberOfRows(section: Int) -> Int {
        return matchStats[section].teamA.topPlayers?.count ?? 0
    }
    
    func titleFor(section: Int) -> String {
        return matchStats[section].statType
    }
    
}
