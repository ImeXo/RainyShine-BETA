//
//  SharedConnection.swift
//  SharedConnectionTest
//
//  Created by Marlon Mingo on 9/30/16.
//  Copyright © 2016 Marlon Mingo. All rights reserved.
//

import Foundation

class SharedConnection {
    
    func dataTask(withURL request: URL) {
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) {
            (data, response, error) in
            if (error != nil) {
                print(error!.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print(result as Any)
            }
        }
            dataTask.resume()
    }
    
    init(latitude lat: Double, longitude lon: Double, url resource: String, appID apikey: String) {
        let weatherURL: URL = URL(string: "\(resource)&lat=\(lat)&lon=\(lon)&appid=\(apikey)")!
        dataTask(withURL: weatherURL)
    }
}
