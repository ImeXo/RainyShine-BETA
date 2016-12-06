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
    
    enum locationStatus: Int {
        case pending = 0, granted, denied
    }
    
    private let locationManager = CLLocationManager()
    private var _currentLocation: CLLocationCoordinate2D!
    private var _locationCall: locationStatus!
    
    
    var currentLocation: CLLocationCoordinate2D {
        get {
            return _currentLocation
        }
    }
    
    var locationCall: locationStatus {
        get {
            return _locationCall
        }
    }
    
    func requestCurrentLocation() -> Void {
        self._locationCall = .granted
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            self._currentLocation = locationManager.location?.coordinate
//            print(self._currentLocation)
            
        }else if CLLocationManager.authorizationStatus() == .denied {
            
            //if user declined to allow location use
            self._locationCall = .denied
        }else {
            
            //request authorization to use phone's location
            locationManager.requestWhenInUseAuthorization()
            requestCurrentLocation() //function return is not needed in this call.
        }
    }
    
    override init() {
        super.init()
        
        self._locationCall = .pending
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}
