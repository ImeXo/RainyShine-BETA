//
//  SharedConnectionDelegate.swift
//  RainyShine-BETA
//
//  Created by Marlon Mingo on 5/22/18.
//  Copyright © 2018 Mingo, Marlon (Admin). All rights reserved.
//

import Foundation

protocol SharedConnectionDelegate {
    
    //Classes adopting this protocol MUST define this method
    //This methode checks to see wheather all data has been downloaded
    func downloadIsComplete (_ sender: SharedConnection)
}
