//
//  DetailsViewController.swift
//  FanGo
//
//  Created by Timothy Adamcik on 4/6/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var stadiumLabel: UILabel!
    @IBOutlet weak var stadiumName: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var stateName: UILabel!
    
    
    var currentStadiumName: String?
    var currentTeamName: String?
    var currentCityName: String?
    var currentStateName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Details"
        stadiumName.text = currentStadiumName
        cityName.text = currentCityName
        stateName.text = currentStateName
        setTeamNames()
    }
    
    func setTeamNames() {
         let dictOfStadiumAndTeams = StadiumArray.dictOfStadiumAndTeams
         let stadiumKeys = StadiumArray.stadiumKeys
        
        for _ in stadiumKeys {
            if let stadium = stadiumName.text {
                let team = dictOfStadiumAndTeams[stadium]
                teamName.text = team
            } else {
                print("Error setting team names")
            }
        }
    }

}
