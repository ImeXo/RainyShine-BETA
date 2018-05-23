//
//  AccessPlist.swift
//  RainyShine-BETA
//
//  Created by Marlon Mingo (Admin) on 11/13/17.
//  Copyright © 2017 Mingo, Marlon (Admin). All rights reserved.
//

import Foundation

class InfoPlist {
    
    private var plistData: NSDictionary!
    var apiKey: String!
    
    private func getInfo(fromPlist plist: String){
        
        //grab Info.plist and store the data in a NSdictionary
        if let path = Bundle.main.path(forResource: plist, ofType: "plist") {
            plistData = NSDictionary(contentsOfFile: path)
//            print("\n\n \(plistData!) \n\n")
        } else {
            
        }
        
        //parse dictionary info and converts the Data to a String and unwraps it
        let APIStringData = String(data: plistData!["APIKey"]! as! Data, encoding: String.Encoding.utf8) //grabs APIkey and converts it from data to string
        apiKey = APIStringData!
    }
    
    private func getInfo(fromPlist plist: String, withKey key: String){
        
        if let path = Bundle.main.path(forResource: plist, ofType: "plist") {
            plistData = NSDictionary(contentsOfFile: path)
            //            print("\n\n \(plistData!) \n\n")
        } else {
            
        }
        
        //parse dictionary info and converts the Data to a String and unwraps it
        let APIStringData = String(data: plistData![key]! as! Data, encoding: String.Encoding.utf8) //grabs APIkey and converts it from data to string
        apiKey = APIStringData!
    }
    
    init(){
        getInfo(fromPlist: "Info") //default is Info.plist
    }
    
    init(withName name: String) {
        getInfo(fromPlist: name)
    }
}
