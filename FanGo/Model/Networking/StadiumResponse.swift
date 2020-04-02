//
//  StadiumResponse.swift
//  FanGo
//
//  Created by Timothy Adamcik on 4/1/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation

struct Stadium: Codable {
    let stadiumID: Int
    let name: String
    let city: String
    let state: String?
    let geoLat: Double
    let geoLon: Double
    
    
    enum CodingKeys: String, CodingKey {
        case stadiumID = "StadiumID"
        case name = "Name"
        case city = "City"
        case state = "State"
        case geoLat = "GeoLat"
        case geoLon = "GeoLong"
        
    }
}
