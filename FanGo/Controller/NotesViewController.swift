//
//  NotesViewController.swift
//  FanGo
//
//  Created by Timothy Adamcik on 4/14/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

class NotesViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textField: UITextView!
    var stadiumDetail: StadiumDetails!
    var savedText = Note()
    var savedNote: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        navigationController?.title = "Notes"
        
        savedNote = (stadiumDetail.note?.text!)
        if let savedTextField = savedNote {
            textField.text = savedTextField
        } else {
            textField.becomeFirstResponder()
        }
        setBackgroundColor()
    
    }
    
    func setBackgroundColor() {
        let dictOfStadiumAndColors = StadiumArray.dictOfStadiumAndTeamColorHex
        
        if let stadium = stadiumDetail.name {
                if let teamColorHex = dictOfStadiumAndColors[stadium] {
                    if teamColorHex.count == 6 {
                        let teamColor = UIColor().colorFromHex(teamColorHex)
                        textField.backgroundColor = teamColor
                        textField.textColor = .white
                    } else {
                        textField.backgroundColor = .white
                        textField.textColor = .black
                    }
                }
            } else {
                print("Error setting color")
            }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    fileprivate func saveText() {
        let note = Note(context: DataController.shared.viewContext)
        note.text = textField.text
        note.stadium = stadiumDetail
        savedNote = textField.text
        DataController.shared.save()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        saveText()
    }
    

}
