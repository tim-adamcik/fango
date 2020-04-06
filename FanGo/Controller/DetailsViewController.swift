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
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var stadiumTextField: UITextField!
    @IBOutlet weak var teamTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    
    var currentStadiumName: String?
    var currentTeamName: String?
    var currentCityName: String?
    var currentStateName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Details"
        stadiumTextField.text = currentStadiumName
        cityTextField.text = currentCityName
        stateTextField.text = currentStateName
    }
}
