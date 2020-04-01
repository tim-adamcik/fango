//
//  NetworkingErrors.swift
//  FanGo
//
//  Created by Timothy Adamcik on 4/1/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case invalidURLComponents
    case invalidURL
    case nilData
    case httpError
}
