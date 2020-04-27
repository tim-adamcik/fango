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
        
        
    
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let note = Note(context: DataController.shared.viewContext)
        note.text = textField.text
        note.stadium = stadiumDetail
        savedNote = textField.text
        DataController.shared.save()
        print("note was saved")
    }
    

}
