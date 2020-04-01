//
//  SportsDataClient.swift
//  FanGo
//
//  Created by Timothy Adamcik on 4/1/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation

class SportsDataClient {
    
   static let apiKey = ""
    
    enum Endpoints {
        static let apiKeyParadigm = "?key=\(SportsDataClient.apiKey)"
        
        case stadiumNFL
        
        var url: URL {
            return URL(string: stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .stadiumNFL:
                return "https://api.sportsdata.io/v3/nfl/scores/json/Stadiums\(Endpoints.apiKeyParadigm)"
            }
        }
    }
    
    
    
}
