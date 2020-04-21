//
//  CoreDataSingleton.swift
//  FanGo
//
//  Created by Timothy Adamcik on 4/21/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation

class CoreDataStadiums {
    static let shared = CoreDataStadiums()
    
    var savedStadiumObjects = [StadiumDetails]()
    
}
