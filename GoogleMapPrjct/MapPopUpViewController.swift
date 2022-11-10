//
//  MapPopUpViewController.swift
//  GoogleMapPrjct
//
//  Created by Bimal@AppStation on 29/08/22.

import UIKit

class MapPopUpViewController: UIViewController {
    @IBOutlet weak var setView: UIView!
    var getlocation = String()
    var passedLocation = CGPoint()
    var getView = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView.frame = CGRect(x: passedLocation.x , y: passedLocation.y, width: 200, height: 100)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func buttonActionClickHere(sender: UIButton) {
        let alert = UIAlertController(title: "Alert", message: "location: \(getlocation)", preferredStyle: UIAlertController.Style.alert)
//        let alert = UIAlertController(title: "Alert", message: "location: \(getlocation)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
           
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func buttonCloseArrow(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
