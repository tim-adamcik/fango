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
    
    enum Mode {
        case view
        case select
    }
    
    @IBOutlet weak var rootStackView: UIStackView!
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
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    @IBOutlet weak var selectBtn: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var noPicturesLabel: UILabel!
    
    
    var currentStadiumName: String?
    var currentTeamName: String?
    var currentCityName: String?
    var currentStateName: String?
    var stadiumDetail: StadiumDetails!
    var savedPhotos = [Photo]()
    var images: [UIImage] = []
    let numberOfColumns: CGFloat = 3
    
    var mMode: Mode = .view {
        didSet {
            switch mMode {
            case .view:
                selectBtn.isEnabled = true
                deleteBtn.isEnabled = false
                addPhotoBtn.isEnabled = true
                navigationItem.leftBarButtonItem = nil
                if let selectedItems = collectionView.indexPathsForSelectedItems {
                    for selection in selectedItems {
                        let cell = collectionView.cellForItem(at: selection)
                        cell?.layer.borderColor = UIColor.clear.cgColor
                        cell?.layer.borderWidth = 3
                        collectionView.deselectItem(at: selection, animated: true)
                    }
                }
                collectionView.allowsMultipleSelection = false
            case .select:
                selectBtn.isEnabled = false
                deleteBtn.isEnabled = true
                addPhotoBtn.isEnabled = false
                navigationItem.leftBarButtonItem = cancelBtn
                collectionView.allowsMultipleSelection = true
            }
        }
    }
    
    lazy var addPhotoBtn: UIBarButtonItem = {
        let barBtnItem = UIBarButtonItem(title: "Add Photo", style: .plain, target: self, action: #selector(addPhotoBtnPressed(_:)))
        return barBtnItem
    }()
   lazy var cancelBtn: UIBarButtonItem = {
       let barBtnItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelBtnPressed(_:)))
       return barBtnItem
   }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = setBackGroundColor()
        view.alpha = 0.9
        view.layer.cornerRadius = 0.0
        return view
    }()
    
    private func pinBackground(_ view: UIView, to stackView: UIStackView) {
      view.translatesAutoresizingMaskIntoConstraints = false
      stackView.insertSubview(view, at: 0)
      view.pin(to: stackView)
    }
    
    fileprivate func setUpUI() {
        
        notesBtn.layer.cornerRadius = 5
        notesBtn.layer.borderWidth = 1
        navigationController?.title = "Details"
        stadiumName.text = currentStadiumName
        cityName.text = currentCityName
        stateName.text = currentStateName
        navigationItem.rightBarButtonItem = addPhotoBtn
        tabBarController?.tabBar.isHidden = true
        deleteBtn.isEnabled = false
        pinBackground(backgroundView, to: rootStackView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setUpUI()
        
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
//        setFontColor()
        
        
        savedPhotos = (stadiumDetail.photos?.allObjects as! [Photo])
        if savedPhotos.count > 0 {
            noPicturesLabel.isHidden = true
            collectionView.reloadData()
        }
    }
    
    func setFontColor() {
        let dictOfStadiumAndColors = StadiumArray.dictOfStadiumAndTeamColorHex
        
        
            if let stadium = stadiumName.text {
                if let teamColorHex = dictOfStadiumAndColors[stadium] {
                    if teamColorHex.count == 6 {
                        let teamColor = UIColor().colorFromHex(teamColorHex)
                        teamName.textColor = teamColor
                        stadiumName.textColor = teamColor
                        cityName.textColor = teamColor
                        stateName.textColor = teamColor
                    } else {
                        teamName.textColor = UIColor.black
                    }
                }
            } else {
                print("Error setting color")
            }
    }
    
    func setBackGroundColor() -> UIColor? {
        let dictOfStadiumAndColors = StadiumArray.dictOfStadiumAndTeamColorHex
        if let stadium = stadiumName.text {
            if let teamColorHex = dictOfStadiumAndColors[stadium] {
                if teamColorHex.count == 6 {
                    let teamColor = UIColor().colorFromHex(teamColorHex)
                    teamName.textColor = .white
                    stadiumName.textColor = .white
                    cityName.textColor = .white
                    stateName.textColor = .white
                    stadiumLabel.textColor = .white
                    teamLabel.textColor = .white
                    cityLabel.textColor = .white
                    stateLabel.textColor = .white
                    haveVisitedLabel.textColor = .white
                    return teamColor
                } else {
                    teamName.textColor = UIColor.black
                    return .white
                }
            }
        } else {
            print("Error setting color")
        }
        return nil
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
    
    @objc func cancelBtnPressed(_ sender: UIBarButtonItem) {
        mMode = mMode == .select ? .view : .select
    }
    
    @IBAction func deleteBtnPressed(_ sender: Any) {
        if let selectedIndexes = collectionView.indexPathsForSelectedItems?.sorted(by: >) {
            for indexPath in selectedIndexes {
                let savedPhoto = savedPhotos[indexPath.row]
                DataController.shared.viewContext.delete(savedPhoto)
                print("photo was deleted")
                try? DataController.shared.viewContext.save()
                savedPhotos.remove(at: indexPath.row)
            }
        }
         mMode = mMode == .select ? .view : .select
        collectionView.reloadData()
    }
    
    @IBAction func selectBtnPressed(_ sender: Any) {
        mMode = mMode == .view ? .select : .view
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectBtn.isEnabled == false {
            let cell = collectionView.cellForItem(at: indexPath)
            if cell?.isSelected == true {
                cell?.layer.borderColor = UIColor.blue.cgColor
                cell?.layer.borderWidth = 3
            }
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SharePhotoViewController") as! SharePhotoViewController
            let savedPhoto = savedPhotos[indexPath.row]
            vc.photo = savedPhoto
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if selectBtn.isEnabled == false {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.borderColor = UIColor.clear.cgColor
            cell?.layer.borderWidth = 3
            cell?.isSelected = false
        }
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
                self.noPicturesLabel.isHidden = true
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


    
    

