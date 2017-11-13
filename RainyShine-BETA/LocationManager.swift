//
//  LocationManager.swift
//  LocationTest
//
//  Created by Mingo, Marlon (Admin) on 9/30/16.
//  Copyright © 2016 Mingo, Marlon (Admin). All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: CLLocationManager, CLLocationManagerDelegate {
    
    enum locationStatus: Int {
        case pending, granted, denied
    }
    
    private let locationManager = CLLocationManager()
    private var _currentLocation: CLLocationCoordinate2D!
    private var _getCurrentLocation: locationStatus!
    
    
    var currentLocation: CLLocationCoordinate2D {
        get {
            return _currentLocation
        }
    }
    
    var getCurrentLocation: locationStatus {
        get {
            return _getCurrentLocation
        }
    }
    
    
    func requestCurrentLocation() -> Void {
        self._getCurrentLocation = .granted
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            self._currentLocation = locationManager.location?.coordinate
            //print(self._currentLocation)
            
        }else if CLLocationManager.authorizationStatus() == .denied {
            
            //if user declined to allow location use
            self._getCurrentLocation = .denied
        }else {
            
            //request authorization to use phone's GPS location
            locationManager.requestWhenInUseAuthorization()
            requestCurrentLocation() //function return is not needed in this call.
        }
    }
    
    //remove redundant code from init functions
    func initConfig() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    override init() {
        super.init()
        
        self._getCurrentLocation = nil
        initConfig()
    }
    
    init(statusIs status: locationStatus) {
        super.init()
        
        self._getCurrentLocation = status
        initConfig()
    }
}
