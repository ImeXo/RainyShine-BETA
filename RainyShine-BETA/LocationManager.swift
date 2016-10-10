//
//  LocationManager.swift
//  LocationTest
//
//  Created by Mingo, Marlon (Admin) on 9/30/16.
//  Copyright © 2016 Mingo, Marlon (Admin). All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class Location: CLLocationManager, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private var _currentLocation: CLLocation!
    private var _allowLocationUse: Bool!
    
    
    var currentLocation: CLLocation {
        get {
            return _currentLocation
        }
    }
    
    var allowLocationUse: Bool {
        get {
            return _allowLocationUse
        }
    }
    
    var alertController: UIAlertController!
    
    
    func requestCurrentLocation() -> Void{
        self._allowLocationUse = true
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            self._currentLocation = locationManager.location
        }else if CLLocationManager.authorizationStatus() == .denied {
            
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
                let segueView = ViewController()
                segueView.performSegue(withIdentifier: "", sender: nil)
            }
            
            alertController.addAction(settingAction)
            alertController.addAction(cancelAction)
        }else {
            
            //request authorization to use phone's location
            locationManager.requestWhenInUseAuthorization()
            requestCurrentLocation()
        }
    }
    
    override init() {
        super.init()
        
        self._allowLocationUse = false
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}
