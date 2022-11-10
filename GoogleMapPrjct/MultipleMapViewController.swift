//
//  MultipleMapViewController.swift
//  GoogleMapPrjct
//
//  Created by Bimal@AppStation on 26/08/22.
//

import UIKit
import MapKit
import GoogleMaps

class MultipleMapViewController: UIViewController, MKMapViewDelegate, GMSMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var setLocation = CGPoint()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        view.addSubview(mapView)
        displayMultipleLocationInMapKitView()
        getDirections()
//       var locationx =
        // Do any additional setup after loading the view.
    }
    let locations = [["title": "Trivandrum", "latitude": 8.5241, "longitude": 76.9366], ["title": "Kochi", "latitude": 9.9312, "longitude": 76.2673], ["title": "Palakkad", "latitude": 10.7867, "longitude": 76.6548], ["title": "Kasaragod", "latitude": 12.4996, "longitude": 74.9869]]
    func displayMultipleLocationInMapKitView() {
    
//        for location in locations {
//
//            let annotation = MKPointAnnotation()
//            annotation.title = location["title"] as? String
//            let loc = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
//
//            annotation.coordinate =  loc
//            mapView?.addAnnotation(annotation)
//
//        }
        
        for location in locations {
            let info1 = SetCustomPointAnnotation()
//            info1.title = location["title"] as? String
            let loc = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
            print("locationlatitude =====> \(location["title"]!)")
            info1.imageName = "pin"
            info1.coordinate =  loc
            info1.title = "\(location["title"]!)"
            info1.subtitle = "Kerala, India"
            mapView?.addAnnotation(info1)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is SetCustomPointAnnotation) {
            return nil
        }

        let reuseId = "test"

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            annotationView?.canShowCallout = true
        }
        else {
            annotationView?.annotation = annotation
        }

        let cpa = annotation as! SetCustomPointAnnotation
        annotationView?.image = UIImage(named:cpa.imageName)
        let resizedSize = CGSize(width: 30 , height: 30)
        let image = UIImage(named: "pin")
        UIGraphicsBeginImageContext(resizedSize)
        image?.draw(in: CGRect(origin: .zero, size: resizedSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        annotationView?.image = resizedImage
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("annotation Clicked ......")
        print("selected annotation =======> \(String(describing: view.annotation?.title!))")
        let views = Bundle.main.loadNibNamed("Makers", owner: nil, options: nil)
        let calloutView = views?[0] as! Makers
//        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        calloutView.center = CGPoint(x: view.bounds.size.width , y: -calloutView.bounds.size.height*0.52)
        calloutView.locationName.text = view.annotation?.title ?? ""
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
//        self.performSegue(withIdentifier: "MapPopUpViewController", sender: view.annotation?.title ?? "")
//        self.performSegue(withIdentifier: "MapPopUpViewController", sender: nil)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: MKAnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self.view)
        print("location of x and y \(location)")
        print("location of x =====> \(location.x)")
        print("location of y =====> \(location.y)")
        setLocation = location
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {
        if let vc = segue.destination as? MapPopUpViewController {
//            vc.getlocation = sender as? String ?? ""
            vc.passedLocation = setLocation
//            vc.getView = sender
//            print("sender ====> \(String(describing: sender!))")
        }
    }
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
       
        print("maker Clicked ......")
//        self.performSegue(withIdentifier: "MapPopUpViewController", sender: nil)
         return true
     }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        print("markerInfoWindow Clicked")
        let infoWindow = Bundle.main.loadNibNamed("Makers", owner: self.view, options: nil)!.first! as! Makers
        marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.4)
//        let view = Bundle.main.loadNibNamed("Makers", owner: self, options: nil)![0] as! Makers
//        let frame = CGRect(x: 10, y: 10, width: 200, height: view.frame.height)
//        view.frame = frame
        return infoWindow
        
    }
   
    func getDirections() {
           let request = MKDirections.Request()
           // Source
           let sourcePlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 8.5241, longitude: 76.9366))
           request.source = MKMapItem(placemark: sourcePlaceMark)
           // Destination
           let destPlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 12.4996, longitude: 74.9869))
           request.destination = MKMapItem(placemark: destPlaceMark)
           // Transport Types
            request.transportType = [.automobile, .walking]

           let directions = MKDirections(request: request)
           directions.calculate { response, error in
               guard let response = response else {
                   print("Error: \(error?.localizedDescription ?? "No error specified").")
                   return
               }
               let route = response.routes[0]
               self.mapView.addOverlay(route.polyline)
           }
    }
}
extension MultipleMapViewController {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = #colorLiteral(red: 0.2405847907, green: 0.5227430377, blue: 1, alpha: 1)
        return renderer
    }
}
class SetCustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
}
