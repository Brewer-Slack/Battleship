//
//  Stats.swift
//  Battleship
//
//  Created by Slack, Brewer Jay on 9/11/18.
//  Copyright © 2018 Slack, Brewer Jay. All rights reserved.
//

import Foundation

struct Stats: CustomStringConvertible {
    // MARK- Properties
    var hits: Int
    var misses: Int
    var totalShots: Int
    var hitsMissesRatio: Double
    
    var description: String{
        var stats = ""
        stats += "Hits: \(hits)\n"
        stats += "Misses: \(misses)\n"
        stats += "Total Shots: \(totalShots)\n"
        stats += "Hits to Misses Ratio: \(hits/(hits + misses)*100)%"
        return stats
    }
    
    
}
