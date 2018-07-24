//
//  IndidualStatsViewModel.swift
//  Sports
//
//  Created by Dean Parreno on 24/7/18.
//  Copyright © 2018 DeanParreno. All rights reserved.
//

import UIKit

class IndividualStatsViewModel {
    
    var individualStats: IndividualStats
    
    var statKeys: [String]? {
        return individualStats.lastMatchStats.map { $0.key }
    }
    
    var statValues: [String]? {
        return individualStats.lastMatchStats.map { String($0.value ?? 0) }
    }
    
    var statsCount: Int {
        return individualStats.lastMatchStats.count
    }
    
    init(individualStats: IndividualStats) {
        self.individualStats = individualStats
    }
    
}
