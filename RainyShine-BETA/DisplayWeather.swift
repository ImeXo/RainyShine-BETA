//
//  DisplayWeather.swift
//  RainyShine-BETA
//
//  Created by Marlon Mingo (Admin) on 8/24/17.
//  Copyright © 2017 Mingo, Marlon (Admin). All rights reserved.
//

import UIKit

class DisplayWeather {
    
    private var _jsonDictionary: NSDictionary = [:]
    
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    private var _lowTemp: Double!
    private var _highTemp: Double!
    
    @IBOutlet weak var weatherTypeTes: UITextField!
    @IBOutlet weak var currentTempTest: UITextField!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dayFormat = DateFormatter()
        dayFormat.dateFormat = "EEEE"
        _date = dayFormat.string(from: Date())
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        
        return _currentTemp
    }
    var lowTemp: Double {
        if _lowTemp == nil {
            _lowTemp = 0.0
        }
        
        return _lowTemp
    }
    var highTemp: Double {
        if _highTemp == nil {
            _highTemp = 0.0
        }
        
        return _highTemp
    }
}
