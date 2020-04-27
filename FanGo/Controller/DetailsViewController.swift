//
//  DetailsViewController.swift
//  FanGo
//
//  Created by Timothy Adamcik on 4/6/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var stadiumLabel: UILabel!
    @IBOutlet weak var stadiumName: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var stateName: UILabel!
    @IBOutlet weak var haveVisitedLabel: UILabel!
    @IBOutlet weak var haveVisitedSwitch: UISwitch!
    @IBOutlet weak var notesBtn: UIButton!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var currentStadiumName: String?
    var currentTeamName: String?
    var currentCityName: String?
    var currentStateName: String?
    var stadiumDetail: StadiumDetails!
    var savedPhotos = [Photo]()
    var images: [UIImage] = []
    let numberOfColumns: CGFloat = 3
    
    lazy var addPhotoBtn: UIBarButtonItem = {
        let barBtnItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhotoBtnPressed(_:)))
        return barBtnItem
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        notesBtn.layer.cornerRadius = 5
        notesBtn.layer.borderWidth = 1
        navigationController?.title = "Details"
        stadiumName.text = currentStadiumName
        cityName.text = currentCityName
        stateName.text = currentStateName
        navigationItem.rightBarButtonItem = addPhotoBtn
        tabBarController?.tabBar.isHidden = true
        
        if stadiumDetail.haveVisited == true {
            haveVisitedSwitch.isOn = true
        } else {
            haveVisitedSwitch.isOn = false
        }
        if let team = stadiumDetail.teamName {
            teamName.text = team
        } else {
            setTeamNames()
        }
        
        savedPhotos = (stadiumDetail.photos?.allObjects as! [Photo])
        if savedPhotos.count > 0 {
            collectionView.reloadData()
        }
    }
    
    func setTeamNames() {
         let dictOfStadiumAndTeams = StadiumArray.dictOfStadiumAndTeams
         let stadiumKeys = StadiumArray.stadiumKeys
        
        for _ in stadiumKeys {
            if let stadium = stadiumName.text {
                let team = dictOfStadiumAndTeams[stadium]
                teamName.text = team
                stadiumDetail.teamName = team
                DataController.shared.save()
            } else {
                print("Error setting team names")
            }
        }
    }
    
    
    @IBAction func notesBtnPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "NotesViewController") as! NotesViewController
        let stadiumDetail = self.stadiumDetail
        vc.stadiumDetail = stadiumDetail
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func shareBtnPressed(_ sender: Any) {
    }
    
    @IBAction func switchBtnTapped(_ sender: Any) {
        if haveVisitedSwitch.isOn == true {
            stadiumDetail.haveVisited = true
            DataController.shared.save()
        } else {
            stadiumDetail.haveVisited = false
            DataController.shared.save()
        }
        
    }
    
}

extension DetailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        savedPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        let photo = savedPhotos[indexPath.row]
        cell.setUpCell(photo)
//        let cellImage = images[indexPath.row]
//        cell.imageView.image = cellImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             let width = collectionView.frame.width / numberOfColumns - 2
             return CGSize(width: width, height: width)
         }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
             return .zero
         }
         
         func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
             return 3
         }
         
         func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
             return 0
         }
}
    
    extension DetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @objc func addPhotoBtnPressed(_ sender: UIBarButtonItem) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            present(pickerController, animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                images.append(image)
                if let imageData = image.pngData() {
                    saveImageToCoreData(data: imageData)
                }
                self.collectionView.reloadData()
            }
            dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
        
        func saveImageToCoreData(data: Data) {
            let photo = Photo(context: DataController.shared.viewContext)
            photo.imageData = data
            photo.stadium = stadiumDetail
            savedPhotos.append(photo)
            DataController.shared.save()
            print("image was saved")
        }
        
    }
    
    

