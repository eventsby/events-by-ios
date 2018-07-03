//
//  EventAnnotation.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/3/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import MapKit

final class EventAnnotation: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    
    init(location: Location, title: String? = nil, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
        coordinate = location.clLocation
    }
    
}
