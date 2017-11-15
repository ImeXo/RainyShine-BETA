//
//  SharedConnection.swift
//  SharedConnectionTest
//
//  Created by Marlon Mingo on 9/30/16.
//  Copyright © 2016 Marlon Mingo. All rights reserved.
//

import Foundation
import CoreLocation

class SharedConnection {
    var request: URL!
    
    var _weatherDetails: NSDictionary!
    
    var weatherDetails: NSDictionary {
        get {
            return _weatherDetails
        }
    }
    
    func downloadWeatherData(withKey apiKey: String, andGPSLocation locationData: CLLocationCoordinate2D) {
        
        request = URL(string: "https://api.darksky.net/forecast/\(apiKey)/\(locationData.latitude),\(locationData.longitude)") //DarkSky API
        
        let newSession = URLSession.shared
        let downloadData = newSession.dataTask(with: request) {
            (data, response, error) in
            if (error != nil) {
                print(error!.localizedDescription)
            } else {
                //let result = String(data: data!, encoding: String.Encoding.utf8) //The data can be converted to JSON without first becoming a String
                do {
                    self._weatherDetails = try? JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
//                    print(self._weatherDetails as Any)
                    print("Data downloaded; ready to parse information and display weather!")
                }
            }
        }
        downloadData.resume()
    }
}
