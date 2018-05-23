//
//  ViewController.swift
//  RainyShine-BETA
//
//  Created by Mingo, Marlon (Admin) on 10/3/16.
//  Copyright © 2016 Mingo, Marlon (Admin). All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, SharedConnectionDelegate {
    
    enum appSettingStatus: Int {
        case granted, pending
    }
    
    private let plistData = InfoPlist(withName: "APIKey")
    var newConnection = SharedConnection()
    var settingStatus: appSettingStatus = .pending
    var alertController = UIAlertController()
    
    let myCurrentLocation = LocationManager(statusIs: .pending)
    let tableView = UITableView()
    
    //get the application name
    let applicationName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        newConnection.delegate = self
        
        // Listens for the app to enter the background or foreground and update accordningly.
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: NSNotification.Name(rawValue: "appEntersBackground"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didBecomeActive), name: NSNotification.Name(rawValue: "appBecomesActive"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(applicationName)
        updateAndDisplayWeather()
    }
    
    //Application enters background
    @objc func didEnterBackground() {
        myCurrentLocation.stopUpdatingLocation()
    }
    
    //Application enters foreground
    @objc func didBecomeActive() {
        
        //This calls an update after user returns from the Settings app.
        if settingStatus == .granted {
            settingStatus = .pending
            self.updateAndDisplayWeather()
        }
    }
    
    
    //Start gathering weather data from online if needed and display the updated data
    private func updateAndDisplayWeather() {
        
        myCurrentLocation.requestCurrentLocation() //request location data from the phone and store it
        
        //If access to the phone's location is denied, ask to change setting or display failure
        if myCurrentLocation.getCurrentLocation == .denied {
            alertController = UIAlertController(title: "Location Services Permission", message: "\(applicationName) uses GPS to provide accurate weather in your area. Please enable location service to continue.", preferredStyle: .actionSheet)
            
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
                    self.settingStatus = .granted
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
            //This starts theweather data download
            newConnection.downloadWeatherData(withKey: plistData.apiKey, andGPSLocation: myCurrentLocation.currentLocation)
        }
    }
    
    //Waits for data to be downloading before printing it out
    func downloadIsComplete(_ sender: SharedConnection) {
        print(newConnection.weatherDetails)
    }
}
