//
//  SharePhotoViewController.swift
//  FanGo
//
//  Created by Timothy Adamcik on 4/28/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

class SharePhotoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    
    var photo: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(data: photo.imageData!)
        imageView.image = image
    }
    
    
    @IBAction func shareBtnPressed(_ sender: Any) {
        let image = imageView.image
        let activityController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        
        present(activityController, animated: true)
    }
    
}
