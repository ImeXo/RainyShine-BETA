//
//  ViewController.swift
//  RainyShine-BETA
//
//  Created by Mingo, Marlon (Admin) on 10/3/16.
//  Copyright © 2016 Mingo, Marlon (Admin). All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let location = Location()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: NSNotification.Name(rawValue: "appEntersBackground"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didBecomeActive), name: NSNotification.Name(rawValue: "appBecomesActive"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //This makes sure the location request stays visible until the user
        //chooses an option
        beginUpdates()
    }
    
    //Application enters background
    func didEnterBackground() {
        location.stopUpdatingLocation()
    }
    
    //Application enters foreground
    func didBecomeActive() {
        
        //        print("\n\n\(location.locationUseApproval)\n\n")
        if location.allowLocationUse {
            beginUpdates()
        }
    }
    
    func beginUpdates() {
        
        location.requestCurrentLocation()
        
        //If location access is denied, ask to change setting or display failure
        if CLLocationManager.authorizationStatus() == .denied {
            self.present(location.alertController, animated: true, completion: nil)
        } else {
            //add update call here
        }
    }
    
    
}
