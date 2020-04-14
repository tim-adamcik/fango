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
        haveVisitedSwitch.isOn = false
        setTeamNames()
    }
    
    func setTeamNames() {
         let dictOfStadiumAndTeams = StadiumArray.dictOfStadiumAndTeams
         let stadiumKeys = StadiumArray.stadiumKeys
        
        for _ in stadiumKeys {
            if let stadium = stadiumName.text {
                let team = dictOfStadiumAndTeams[stadium]
                teamName.text = team
            } else {
                print("Error setting team names")
            }
        }
    }
    
    
    @IBAction func notesBtnPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "NotesViewController") as! NotesViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addPhotoButton(_ sender: Any) {
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
