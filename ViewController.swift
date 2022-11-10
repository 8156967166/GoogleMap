//
//  ViewController.swift
//  GoogleMapPrjct
//
//  Created by Bimal@AppStation on 30/08/22.


import UIKit
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate {
    @IBOutlet weak var googleMap: GMSMapView!
    var tappedMaker = GMSMarker()
    var customInfoWindow = infoView()
    override func viewDidLoad() {
        super.viewDidLoad()

        googleMap.delegate = self
        customInfoWindow = Bundle.main.loadNibNamed("infoView", owner: self, options: nil)?.first as! infoView
        let maker = GMSMarker()
        maker.position = CLLocationCoordinate2D(latitude: 35.8000, longitude: 30.7990)
        maker.map = googleMap
        // Do any additional setup after loading the view.
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        self.view.addSubview(customInfoWindow.viewInfoView)
        tappedMaker = marker
        customInfoWindow.buttonInfoView.addTarget(self, action: #selector(click(maker:)), for: .touchUpInside)
        return false
    }
    
    @objc func click(maker:GMSMarker) {
        
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if (tappedMaker != nil) {
            let location = tappedMaker.position
            customInfoWindow.viewInfoView.center = mapView.projection.point(for: location)
            customInfoWindow.viewInfoView.center.x = mapView.center.x
            customInfoWindow.viewInfoView.center.y = customInfoWindow.viewInfoView.center.y-150
        }
    }

}
