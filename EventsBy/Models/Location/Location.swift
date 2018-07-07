//
//  Location.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/3/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    
    let latitude: Double
    let longitude: Double
    
    init(lat: Double, long: Double) {
        self.latitude = Double(lat)
        self.longitude = Double(long)
    }
    
}

extension Location {
    
    var clLocation: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}
