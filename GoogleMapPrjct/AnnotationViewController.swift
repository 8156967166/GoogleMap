//
//  AnnotationViewController.swift
//  GoogleMapPrjct
//
//  Created by Bimal@AppStation on 26/08/22.
//

import UIKit
import MapKit

class AnnotationViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapView.delegate = self

        let info1 = CustomPointAnnotation()
        info1.coordinate = CLLocationCoordinate2DMake(26.889281, 75.836042)
        info1.title = "Info1"
        info1.subtitle = "Subtitle"
        info1.imageName = "flag.png"

        let info2 = CustomPointAnnotation()
        info2.coordinate = CLLocationCoordinate2DMake(26.862280, 75.815098)
        info2.title = "Info2"
        info2.subtitle = "Subtitle"
        info2.imageName = "flag.png"

        mapView.addAnnotation(info1)
        mapView.addAnnotation(info2)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        print("delegate called")

        if !(annotation is CustomPointAnnotation) {
            return nil
        }

        let reuseId = "test"

        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView?.canShowCallout = true
        }
        else {
            anView?.annotation = annotation
        }

        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...

        let cpa = annotation as! CustomPointAnnotation
        anView?.image = UIImage(named:cpa.imageName)

        return anView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
}

