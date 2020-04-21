//
//  DetailsViewController.swift
//  FanGo
//
//  Created by Timothy Adamcik on 4/6/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

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
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var currentStadiumName: String?
    var currentTeamName: String?
    var currentCityName: String?
    var currentStateName: String?
    var stadiumDetail: StadiumDetails!
    
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
    
    @IBAction func addPhotoButton(_ sender: Any) {
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
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        return cell
    }
    
    
}
