//
//  TestMapViewController.swift
//  GoogleMapPrjct
//
//  Created by Bimal@AppStation on 29/08/22.
//

import UIKit
import GoogleMaps
import MapKit


class TestMapViewController: UIViewController, GMSMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setAddMAker()
        let camera = GMSCameraPosition.camera(withLatitude: 10, longitude: 10, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        view.addSubview(mapView)
        let position = CLLocationCoordinate2D(latitude: 10, longitude: 10)
        let marker = GMSMarker(position: position)
        marker.title = "Hello World"
        marker.snippet = "Population: 8,174,100"
        marker.accessibilityLabel = "0"
        let degrees = 40.0
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        marker.rotation = degrees
        marker.map = mapView
        marker.icon = GMSMarker.markerImage(with: .cyan)
        marker.icon = UIImage(named: "pin")
        marker.opacity = 5
        let markerImage = UIImage(named: "pin")!.withRenderingMode(.alwaysOriginal)
        marker.icon = self.image(markerImage, scaledToSize: CGSize(width: 30, height: 30))
        mapView.delegate = self
        // Do any additional setup after loading the view.
    }
    func setAddMAker() {
        
//        mapView.selectedMarker = marker
        
//        mapView.selectedMarker = nil
        
       
    }
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let view = Bundle.main.loadNibNamed("Makers", owner: self, options: nil)![0] as! Makers
        let frame = CGRect(x: 10, y: 10, width: 200, height: view.frame.height)
        view.frame = frame
        return view
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//       performSegue(withIdentifier: "MapPopUpViewController", sender: nil)
        print("maker Clicked ......")
         return true
     }
    fileprivate func image(_ originalImage:UIImage, scaledToSize:CGSize) -> UIImage {
        if originalImage.size.equalTo(scaledToSize) {
            return originalImage
        }
        UIGraphicsBeginImageContextWithOptions(scaledToSize, false, 0.0)
        originalImage.draw(in: CGRect(x: 0, y: 0, width: scaledToSize.width, height: scaledToSize.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

}
