//
//  Configuration.swift
//  Sports
//
//  Created by Dean Parreno on 22/7/18.
//  Copyright © 2018 DeanParreno. All rights reserved.
//

import Foundation

class Configuration {
    
    static let scheme = "https://"
    static let basePath = "statsapi.foxsports.com.au/3.0/api/sports/league/"
    
    class func matchURL(for matchID: String) -> URL? {
        // Force unwrapping since it is certain the string can be encoded.
//        let urlString = [scheme, host, basePath, "matches/", matchID].joined()
//        guard var urlComponents = URLComponents(string: urlString) else { return nil }
//        urlComponents.path.append("/topplayerstats.json;type=fantasy_points;type=tackles;type=runs;type=run_metres")
//        urlComponents.queryItems = [URLQueryItem(name: "limit", value: "5"),
//                                    URLQueryItem(name: "userkey", value: "A00239D3-45F6-4A0A-810C-54A347F144C2")]
//        return urlComponents.url
        return URL(string: [scheme, basePath, "matches/", matchID, "/topplayerstats.json;type=fantasy_points;type=tackles;type=runs;type=run_metres?limit=5&userkey=A00239D3-45F6-4A0A-810C-54A347F144C2"].joined())
    }
    
    class func playerStatsURL(for matchID: String, playerID: String) -> URL? {
//        let urlString = [scheme, host, basePath, "series/1/seasons/115/teams/", matchID, "/players/", playerID, "/detailedstats.json"].joined()
//        guard var urlComponents = URLComponents(string: urlString) else { return nil }
//        urlComponents.queryItems = [URLQueryItem(name: "userkey", value: "9024ec15-d791-4bfd-aa3b-5bcf5d36da4f")]
//        return urlComponents.url
        return URL(string: [scheme, basePath, "series/1/seasons/115/teams/", matchID, "/players/", playerID, "/detailedstats.json?userkey=9024ec15-d791-4bfd-aa3b-5bcf5d36da4f"].joined())
    }
    
}
