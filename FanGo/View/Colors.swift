//
//  Colors.swift
//  FanGo
//
//  Created by Timothy Adamcik on 5/7/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static let cardinalRed = UIColor().colorFromHex("97233F")
    static let falconRed = UIColor().colorFromHex("A71930")
    static let ravenPurple = UIColor().colorFromHex("241773")
    static let billsBlue = UIColor().colorFromHex("00338D")
    static let carolinaBlue = UIColor().colorFromHex("0085CA")
    static let bearsNavy = UIColor().colorFromHex("0B162A")
    static let bengalsBroncosOrange = UIColor().colorFromHex("FB4F14")
    static let brownsBrown = UIColor().colorFromHex("311D00")
    static let cowboyBlue = UIColor().colorFromHex("003594")
    static let lionsBlue = UIColor().colorFromHex("0076B6")
    static let packersGreen = UIColor().colorFromHex("203731")
    static let texansBlue = UIColor().colorFromHex("03202F")
    static let coltsBlue = UIColor().colorFromHex("002C5F")
    static let falconRed = UIColor().colorFromHex("")
    static let falconRed = UIColor().colorFromHex("")
    static let falconRed = UIColor().colorFromHex("")
    static let falconRed = UIColor().colorFromHex("")
    static let falconRed = UIColor().colorFromHex("")
    static let falconRed = UIColor().colorFromHex("")
    static let falconRed = UIColor().colorFromHex("")
    static let falconRed = UIColor().colorFromHex("")
    static let falconRed = UIColor().colorFromHex("")
    static let falconRed = UIColor().colorFromHex("")
    
 
    func colorFromHex(_ hex: String) -> UIColor {
        
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            return UIColor.black
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xff000000) >> 24) / 255,
        green: CGFloat((rgb & 0x00ff0000) >> 16) / 255,
        blue: CGFloat((rgb & 0x0000ff00) >> 8) / 255,
        alpha: CGFloat(rgb & 0x000000ff) / 255)
        
    }
    
}

