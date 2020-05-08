//
//  TableViewCell.swift
//  FanGo
//
//  Created by Timothy Adamcik on 4/1/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    func setTableCellBackGroundColor() {
        let dictOfStadiumAndColors = StadiumArray.dictOfStadiumAndTeamColorHex
        
        
        
        if let stadium = self.label.text {
            if let teamColorHex = dictOfStadiumAndColors[stadium] {
                if teamColorHex.count == 6 {
                    let teamColor = UIColor().colorFromHex(teamColorHex)
                    self.label.textColor = teamColor
                } else {
                    self.label.textColor = .black
                }
            }
        } else {
            print("Error setting color")
        }
    }
}
