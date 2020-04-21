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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = "Click here to add notes"
        textField.textColor = .lightGray
        navigationController?.title = "Notes"
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Click here to add notes"
            textView.textColor = .lightGray
        }
    }
    
}
