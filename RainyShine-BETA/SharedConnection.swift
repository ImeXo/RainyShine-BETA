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
    var _weatherInJSONFormat: NSDictionary!
    
    var weatherInJSONFormat: NSDictionary {
        get {
            return _weatherInJSONFormat
        }
    }
    
    func dataTask(with apiKey: String, andLocation locationData: CLLocationCoordinate2D) {
        
        request = URL(string: "https://api.darksky.net/forecast/\(apiKey)/\(locationData.latitude),\(locationData.longitude)") //DarkSky API
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) {
            (data, response, error) in
            if (error != nil) {
                print(error!.localizedDescription)
            } else {
                //let result = String(data: data!, encoding: String.Encoding.utf8) //The data can be converted to JSON without first becoming a String
                do {
                    self._weatherInJSONFormat = try? JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    print(self._weatherInJSONFormat as Any)
                }
            }
        }
        dataTask.resume()
    }
}
