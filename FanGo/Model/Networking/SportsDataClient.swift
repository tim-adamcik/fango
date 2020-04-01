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
    
    func getStadiums(completion: @escaping ([Stadium]?, Error?) -> Void) {
        
        guard let url = URL(string: Endpoints.stadiumNFL.stringValue) else {
            completion(nil, NetworkingError.invalidURL)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(nil, error)
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 else {
                completion(nil, NetworkingError.httpError)
                return }
            
            guard let data = data else {
                completion(nil, NetworkingError.nilData)
                return }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode([Stadium].self, from: data)
                completion(responseObject, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
}
