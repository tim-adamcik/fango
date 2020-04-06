//
//  StadiumListViewController.swift
//  FanGo
//
//  Created by Timothy Adamcik on 3/27/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

class StadiumListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var stadiumListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let detailVC: DetailsViewController = DetailsViewController()
        stadiumListTableView.delegate = self
        stadiumListTableView.dataSource = self
        loadTableView()
    }
    
    func loadTableView() {
        _ = SportsDataClient.getStadiums(completion: { (stadiums, error) in
            if let error = error {
                DispatchQueue.main.async {
                    let alertVC = UIAlertController(title: "Error", message: "Error retrieving data", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    self.present(alertVC, animated: true)
                    print(error.localizedDescription)
                }
            } else {
                if let stadiums = stadiums {
                    StadiumArray.stadiums = stadiums
                    print(stadiums)
                    DispatchQueue.main.async {
                        self.stadiumListTableView.reloadData()
                    }
                }
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        StadiumArray.stadiums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        let stadium = StadiumArray.stadiums[indexPath.row]
        
        cell.label.text = stadium.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        let stadium = StadiumArray.stadiums[indexPath.row]
        vc.currentStadiumName = stadium.name
        vc.currentCityName = stadium.city
        vc.currentStateName = stadium.state
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
