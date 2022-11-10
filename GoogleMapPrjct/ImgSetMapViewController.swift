//
//  ImgSetMapViewController.swift
//  GoogleMapPrjct
//
//  Created by Bimal@AppStation on 26/08/22.
//
import CoreLocation
import UIKit
import GoogleMaps

class ImgSetMapViewController: UIViewController {
    var receivedlatitude = Double()
    var receivedlongitude = Double()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let camera = GMSCameraPosition.camera(withLatitude: receivedlatitude, longitude: receivedlongitude, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        view.addSubview(mapView)
        let positionLondon = CLLocationCoordinate2D(latitude: receivedlatitude, longitude: receivedlongitude)
        let london = GMSMarker(position: positionLondon)
        london.icon = UIImage(named: "pin")
        london.map = mapView
        let markerImage = UIImage(named: "pin")!.withRenderingMode(.alwaysOriginal)
        london.icon = self.image(markerImage, scaledToSize: CGSize(width: 30, height: 30))
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
