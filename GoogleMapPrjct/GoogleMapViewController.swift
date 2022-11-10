//
//  GoogleMapViewController.swift
//  GoogleMapPrjct
//
//  Created by Bimal@AppStation on 25/08/22.


import UIKit
import GoogleMaps

//class GoogleMapViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        GMSServices.provideAPIKey("AIzaSyBNLEc640tCJZng5ZaS7uk6wyHoGMuhvaE")
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
//        view.addSubview(mapView)
//        let marker = GMSMarker()
//                marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//                marker.title = "Sydney"
//                marker.snippet = "Australia"
//                marker.map = mapView
//  }
//}

class GoogleMapViewController: UIViewController {
    @IBOutlet weak var textFieldLatitude: UITextField!
    @IBOutlet weak var textFieldLongitude: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
  }
    @IBAction func buttonActionGo(sender: UIButton) {
        if textFieldLatitude.text?.isEmpty == false {
            if textFieldLongitude.text?.isEmpty == false {
                performSegue(withIdentifier: "ImgSetMapViewController", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ImgSetMapViewController {
            let receivedLatitudeToDouble = Double(textFieldLatitude.text!)
            let receivedLongitudeToDouble = Double(textFieldLongitude.text!)
            vc.receivedlatitude = receivedLatitudeToDouble ?? 0
            vc.receivedlongitude = receivedLongitudeToDouble ?? 0
//            vc.receivedlatitude = textFieldLatitude.text ?? ""
//            vc.receivedlongitude = textFieldLongitude.text ?? ""
        }
    }
}
