//
//  MultipleMarkerViewController.swift
//  GoogleMapPrjct
//
//  Created by Bimal@AppStation on 26/08/22.
//

import UIKit
import GoogleMaps

struct State {
    var name: String = ""
    var long: Double = Double()
    var lat: Double = Double()
}
class MultipleMarkerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let states = [
            State(name: "Zoo 1", long:102.2989 , lat:  2.276537),
            State(name: "Zoo 2", long:151.20 , lat:  -33.86),
            // the other 51 states here...
        ]
        for state in states {
            let camera = GMSCameraPosition.camera(withLatitude: state.lat, longitude: state.long, zoom: 6.0)
            let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
            view.addSubview(mapView)
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: state.lat, longitude: state.long)
            marker.map = mapView
       }
        
        // Do any additional setup after loading the view.
    }

}
