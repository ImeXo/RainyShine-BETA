//
//  ViewController.swift
//  RainyShine-BETA
//
//  Created by Mingo, Marlon (Admin) on 10/3/16.
//  Copyright © 2016 Mingo, Marlon (Admin). All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController {
    
    let location = Location()
    let tableView = UITableView()
    var newConnection = SharedConnection()
    
    let apiKey = "93a4de0efba74dfeb43a460f21e50d6b"
    
    var alertController = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: NSNotification.Name(rawValue: "appEntersBackground"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didBecomeActive), name: NSNotification.Name(rawValue: "appBecomesActive"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        DispatchQueue.main.async {
//            <#code#>
//        }
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
        
        //prevent this from runing the first time the progrm starts due to
        //notification listeners
        if location.locationCall == .granted {
            
            DispatchQueue.main.async {
                self.beginUpdates()
            }
            
        }
    }
    
    func beginUpdates() {
        
        location.requestCurrentLocation()
        
        //If location access is denied, ask to change setting or display failure
        if location.locationCall == .denied {
            alertController = UIAlertController(title: "Location Services Permission", message: "Please enable location services to determine the weather in your area.", preferredStyle: .actionSheet)
            
            //open setting to enable location services
            let settingAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                let settingsUrl = URL(string: UIApplicationOpenSettingsURLString)
                if let url = settingsUrl {
                    if #available(iOS 10.0, *) {
                        let options = [UIApplicationOpenURLOptionUniversalLinksOnly : false]
                        UIApplication.shared.open(url, options: options, completionHandler: nil)
                    } else {
                        // Fallback on earlier versions
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (_) -> Void in
                
                //Create default view
                self.performSegue(withIdentifier: "unknownLocation", sender: self)
//                self.present("vc2", animated: true, completion: nil)
            }
            
            alertController.addAction(settingAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            //add update call here
            newConnection.dataTask(with: apiKey, andLocation: location.currentLocation)
        }
    }
}
