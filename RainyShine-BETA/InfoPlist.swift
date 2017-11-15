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
    private var test = [String: Data]()
    var APIKey: String = ""
    
    private func getInfo(fromPlist plist: String){
        
        //grab Info.plist and store the data in a NSdictionary
        if let path = Bundle.main.path(forResource: plist, ofType: "plist") {
            plistData = NSDictionary(contentsOfFile: path)
        }
        
        //parse dictionary info and converts the Data to a String
        let stringData = String(data: plistData!["APIKey"]! as! Data, encoding: String.Encoding.utf8)
        APIKey = stringData!
    }
    
    
    init(){
        getInfo(fromPlist: "Info")
    }
    
    init(withName name: String) {
        getInfo(fromPlist: name)
    }
}
