//
//  MapViewController.swift
//  FanGo
//
//  Created by Timothy Adamcik on 3/27/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var annotations: [MKPointAnnotation] = [MKPointAnnotation]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        pinStadiumsOnMap()
    }
    
    func pinStadiumsOnMap() {
        annotations = []
        mapView.removeAnnotations(mapView.annotations)
        
        for stadium in StadiumArray.stadiums {
            let annotation: MKPointAnnotation = MKPointAnnotation()
            if let lat = CLLocationDegrees(exactly: stadium.geoLat), let lon = CLLocationDegrees(exactly: stadium.geoLon) {
                let coordinateLocation = CLLocationCoordinate2DMake(lat, lon)
                annotation.coordinate = coordinateLocation
                annotation.title = stadium.name
                annotation.subtitle = stadium.city
                annotations.append(annotation)
            }
        }
        mapView.addAnnotations(annotations)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "idForView"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view!.canShowCallout = true
            view!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            return view
        } else {
            view!.annotation = annotation
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let vc = storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        let pin = view.annotation as? MKPointAnnotation
        
        for stadium in StadiumArray.stadiums {
            if stadium.geoLat == pin?.coordinate.latitude &&
                stadium.geoLon == pin?.coordinate.longitude {
                vc.currentStadiumName = stadium.name
                vc.currentCityName = stadium.city
                vc.currentStateName = stadium.state
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
