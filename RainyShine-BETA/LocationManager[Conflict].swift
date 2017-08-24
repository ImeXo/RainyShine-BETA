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
    private var _locationCalled: Bool!
    
    
    var currentLocation: CLLocation {
        get {
            return _currentLocation
        }
    }
    
    var locationCalled: Bool {
        get {
            return _locationCalled
        }
    }
    
    var alertController: UIAlertController!
    
    
    func requestCurrentLocation() -> Void{
        self._locationCalled = true
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            self._currentLocation = locationManager.location
            print(self._currentLocation.coordinate)
            
        }else if CLLocationManager.authorizationStatus() == .denied {
            // code here
        }else {
            
            //request authorization to use phone's location
            locationManager.requestWhenInUseAuthorization()
            requestCurrentLocation()
        }
    }
    
    override init() {
        super.init()
        
        self._locationCalled = false
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}
