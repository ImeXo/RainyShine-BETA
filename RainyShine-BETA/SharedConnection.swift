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
    
    func dataTask(with apiKey: String, andLocation locData: CLLocationCoordinate2D) {
        
        request = URL(string: "https://api.darksky.net/forecast/\(apiKey)/\(locData.latitude),\(locData.longitude)") //DarkSky API
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) {
            (data, response, error) in
            if (error != nil) {
                print(error!.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print(result! as Any)
            }
        }
            dataTask.resume()
    }
}
