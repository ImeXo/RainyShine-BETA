//
//  TimeLapse.swift
//  RainyShine-BETA
//
//  Created by Marlon Mingo (Admin) on 8/28/17.
//  Copyright © 2017 Mingo, Marlon (Admin). All rights reserved.
//

import Foundation

class TimeLapse {
    
    private var startTrackingTimeSinceUpdate: TimeInterval = 0
    private var endTrackingTimeSinceUpdate: TimeInterval = 0
    
    func startTimeLapse() {
        startTrackingTimeSinceUpdate = NSDate().timeIntervalSinceReferenceDate
    }
    func endTimeLapse() {
        endTrackingTimeSinceUpdate = NSDate().timeIntervalSinceReferenceDate
        print("\(endTrackingTimeSinceUpdate-startTrackingTimeSinceUpdate) :: \(startTrackingTimeSinceUpdate)")
    }
}
