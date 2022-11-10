//
//  ShowMapViewController.swift
//  GoogleMapPrjct
//
//  Created by Bimal@AppStation on 25/08/22.
//
import CoreLocation
import UIKit
import GoogleMaps

class ShowMapViewController: UIViewController, CLLocationManagerDelegate {
    var receivedlatitude = Double()
    var receivedlongitude = Double()
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
//        GMSServices.provideAPIKey("AIzaSyBNLEc640tCJZng5ZaS7uk6wyHoGMuhvaE")
        
        let camera = GMSCameraPosition.camera(withLatitude: receivedlatitude, longitude: receivedlongitude, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        view.addSubview(mapView)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: receivedlatitude, longitude: receivedlongitude)
        marker.title = ""
        marker.snippet = ""
        marker.map = mapView
        let markerImage = UIImage(named: "pin")!.withRenderingMode(.alwaysTemplate)
        marker.icon = self.image(markerImage, scaledToSize: CGSize(width: 20, height: 20))
//        marker.icon = [self image:marker.icon scaledToSize:CGSizeMake(3.0f, 3.0f)];
        marker.icon = GMSMarker.markerImage(with: .green)
        print("License ===> \(GMSServices.openSourceLicenseInfo())")
       print("receivedlatitude ====> \(receivedlatitude)")
        print("receivedlongitude ====> \(receivedlongitude)")
        // Do any additional setup after loading the view.
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
    @IBAction func buttonActionCloseArrow(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else {
//            return
//        }
//        let coordinate = location.coordinate
//        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 6.0)
//        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
//        view.addSubview(mapView)
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
//    }
}
