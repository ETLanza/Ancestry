//
//  PersonDetailViewController.swift
//  Ancestry
//
//  Created by Eric Lanza on 5/27/19.
//  Copyright © 2019 ETLanza. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PersonDetailViewController: UIViewController {
    
    var person: Person? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAnnotations()
    }
    
    func updateViews() {
        guard let person = person else { return }
        imageView.image = person.image
        nameLabel.text = person.name
        sexLabel.text = person.sex
        birthLabel.text = "Born on \(person.birthInfo.date) in \(person.birthInfo.name)"
        if let death = person.deathInfo {
            deathLabel.isHidden = false
            deathLabel.text = "Died on \(death.date) in \(death.name)"
        } else {
            deathLabel.isHidden = true
        }
    }
    
    func addAnnotations() {
        let trimSet = CharacterSet(charactersIn: "° NWSE")
        guard let person = person,
            let birthLat = Double(person.birthInfo.lat.trimmingCharacters(in: trimSet)),
            let birthLong = Double(person.birthInfo.long.trimmingCharacters(in: trimSet)) else { return }
        let birthAnnotation = MKPointAnnotation()
        birthAnnotation.coordinate = CLLocationCoordinate2D(latitude: birthLat, longitude: birthLong)
        
        birthAnnotation.title = "\(person.name) was born here"
        birthAnnotation.subtitle = "\(person.birthInfo.lat) \(person.birthInfo.long)"
        mapView.addAnnotation(birthAnnotation)
        
        if let deathInfo = person.deathInfo,
            let deathLat = Double(deathInfo.lat.trimmingCharacters(in: trimSet)),
            let deathLong = Double(deathInfo.long.trimmingCharacters(in: trimSet)) {
            let deathAnnotation = MKPointAnnotation()
            deathAnnotation.coordinate = CLLocationCoordinate2D(latitude: deathLat, longitude: deathLong)
            deathAnnotation.title = "\(person.name) died here"
            deathAnnotation.subtitle = "\(deathInfo.lat) \(deathInfo.long)"
            
            mapView.addAnnotation(deathAnnotation)
        }
        
        let span = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        let region = MKCoordinateRegion(center: birthAnnotation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}
