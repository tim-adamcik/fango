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
    static let jaguarsTeal = UIColor().colorFromHex("006778")
    static let chiefsRed = UIColor().colorFromHex("E31837")
    static let chargerBlue = UIColor().colorFromHex("0080C6")
    static let ramsBlue = UIColor().colorFromHex("002244")
    static let dolphinsAqua = UIColor().colorFromHex("008E97")
    static let vikingsPurple = UIColor().colorFromHex("4F2683")
    static let patriotsBlue = UIColor().colorFromHex("002244")
    static let saintsGold = UIColor().colorFromHex("D3BC8D")
    static let giantBlue = UIColor().colorFromHex("0B2265")
    static let jetGreen = UIColor().colorFromHex("125740")
    static let raidersSilver = UIColor().colorFromHex("A5ACAF")
    static let eagleGreen = UIColor().colorFromHex("004C54")
    static let steelersGold = UIColor().colorFromHex("FFB612")
    static let sanFranRed = UIColor().colorFromHex("AA0000")
    static let seattleBlue = UIColor().colorFromHex("002244")
    static let tampaRed = UIColor().colorFromHex("D50A0A")
    static let titanBlue = UIColor().colorFromHex("0C2340")
    static let redskinRed = UIColor().colorFromHex("773141")
    
 
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

