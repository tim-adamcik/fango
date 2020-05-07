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
    
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("text view did begin editing")
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
        print("note was saved")
    }
    

}
