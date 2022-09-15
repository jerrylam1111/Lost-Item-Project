//
//  MapViewController.swift
//  Lost Item Project
//
//  Created by Hei Lok Keith Kong on 14/9/2022.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UNSW
        let camera = GMSCameraPosition.camera(withLatitude: -33.92, longitude: 151.23, zoom: 15.0)
        mapView.camera = camera
    }
}
