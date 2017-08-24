//
//  LocationManager.swift
//  LocationTest
//
//  Created by Mingo, Marlon (Admin) on 9/30/16.
//  Copyright © 2016 Mingo, Marlon (Admin). All rights reserved.
//

import Foundation
import CoreLocation

class Location: CLLocationManager, CLLocationManagerDelegate {
    
    enum locationStatus {
        case pending
        case granted
        case denied
    }
    
    private let locationManager = CLLocationManager()
    private var _currentLocation: CLLocation!
    private var _locationCalled: locationStatus!
    
    
    var currentLocation: CLLocation {
        get {
            return _currentLocation
        }
    }
    
    var locationCalled: locationStatus {
        get {
            return _locationCalled
        }
    }
    
    func requestCurrentLocation() -> Void {
        self._locationCalled = .granted
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            self._currentLocation = locationManager.location
            print(self._currentLocation!)
            
        }else if CLLocationManager.authorizationStatus() == .denied {
            
            //if user declined to allow location use
            _locationCalled = .denied
        }else {
            
            //request authorization to use phone's location
            locationManager.requestWhenInUseAuthorization()
            requestCurrentLocation() //function return is not needed in this call.
        }
    }
    
    override init() {
        super.init()
        
        self._locationCalled = .pending
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}
