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
    
    enum appSettingStatus: Int {
        case opened, pending
    }
    
    let myCurrentLocation = LocationManager()
    let tableView = UITableView()
    var newConnection = SharedConnection()
    var settingStatus: appSettingStatus = .pending
    let timeLapseInfo = TimeLapse()
    
    //Dark Sky API key
    let apiKey = "93a4de0efba74dfeb43a460f21e50d6b"
    
    var alertController = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Listens for the app to enter the background or foreground and update accordningly.
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: NSNotification.Name(rawValue: "appEntersBackground"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didBecomeActive), name: NSNotification.Name(rawValue: "appBecomesActive"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("\n\nThis is the start of the app...\nStatus is: \(myCurrentLocation.getCurrentLocation)")
        updateAndDisplayWeather()
    }
    
    //Application enters background
    @objc func didEnterBackground() {
        print("I'm sleepy\n")
        myCurrentLocation.stopUpdatingLocation()
    }
    
    //Application enters foreground
    @objc func didBecomeActive() {
        
        //This calls an update after user returns from the Settings app.
        timeLapseInfo.endTimeLapse()
        if settingStatus == .opened {
            self.updateAndDisplayWeather()
        }
    }
    
    func updateAndDisplayWeather() {
        
        myCurrentLocation.requestCurrentLocation()
        
        //If location access is denied, ask to change setting or display failure
        if myCurrentLocation.getCurrentLocation == .denied {
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
                    self.settingStatus = .opened
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
            newConnection.downloadWeatherData(with: apiKey, andGPSLocation: myCurrentLocation.currentLocation)
            timeLapseInfo.startTimeLapse() //Used to prevent too many calls from happening frequently
        }
    }
}
