//
//  TimeLapse.swift
//  RainyShine-BETA
//
//  Created by Marlon Mingo (Admin) on 8/28/17.
//  Copyright © 2017 Mingo, Marlon (Admin). All rights reserved.
//

import Foundation

class TimeLapse {
    
    var startTrackingTimeSinceUpdate: TimeInterval = 0
    var endTrackingTimeSinceUpdate: TimeInterval = 0
    
    func startTimeLapse() {
        startTrackingTimeSinceUpdate = NSDate().timeIntervalSinceReferenceDate
    }
    func endTimeLapse() {
        endTrackingTimeSinceUpdate = NSDate().timeIntervalSinceReferenceDate
        print(endTrackingTimeSinceUpdate-startTrackingTimeSinceUpdate)
    }
}
